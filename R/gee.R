#' Get the dataset organized and wrangled into a format for the GEE analysis.
#'
prep_gee_data <- function(data) {
    data <- data %>%
        dplyr::filter(DM != 1)

    data_without_fa <- dplyr::select(data, -dplyr::matches('pct_ne|^ne'), -TotalNE)

    data_with_fa_scaled <- data %>%
        dplyr::filter(VN == 0) %>%
        dplyr::select(SID, TotalNE, dplyr::matches('pct_ne|^ne')) %>%
        dplyr::mutate_at(dplyr::vars(-SID), dplyr::funs(as.numeric(scale(.))))

    full_data_fa_scaled <-
        dplyr::full_join(data_without_fa,
                         data_with_fa_scaled,
                         by = 'SID')

    data_fa_covar_scaled <- full_data_fa_scaled %>%
        dplyr::group_by(VN) %>%
        dplyr::mutate_at(dplyr::vars(Waist, ALT, BaseAge, MET, TAG),
                         dplyr::funs(as.numeric(scale(.))))

    gee_prepped_data <- data_fa_covar_scaled %>%
        dplyr::ungroup() %>%
        dplyr::arrange(SID, VN)

    return(gee_prepped_data)
}


#' Run GEE on data and generate the model results.
#'
#' @param data project data
#' @param y outcomes
#' @param x predictors
#' @param covar covariates
#' @param unit unit for the fatty acids (percent or conc)
#' @param intvar interaction variable
#' @param mod adjusted or unadjusted
#'
analyze_gee <- function(data, y, x, covar, unit, intvar = NULL, mod = NA) {

    # What to filter from the dataset
    int <- !is.null(intvar)
    if (int) {
        extract_term <- ':'
    } else {
        extract_term <- 'Xterm$'
    }

    gee_results <- data %>%
        mason::design('gee') %>%
        mason::add_settings(family = stats::gaussian('identity'), corstr = 'ar1', cluster.id = 'SID') %>%
        mason::add_variables('yvars', y) %>%
        mason::add_variables('xvars', x) %>%
        mason::add_variables('covariates', covar) %>% {
            if (int) {
                mason::add_variables(., 'interaction', intvar)
            } else {
                .
            }
        } %>%
        mason::construct() %>%
        mason::scrub() %>%
        dplyr::filter(grepl(extract_term, term)) %>%
        mason::polish_transform_estimates(function(x) (exp(x) - 1) * 100) %>%
        mason::polish_adjust_pvalue(method = "BH") %>%
        dplyr::mutate_at("Xterms", renaming_fa) %>%
        dplyr::mutate_at("Yterms", renaming_outcomes) %>%
        dplyr::mutate(unit = unit,
                      covars = paste0(covar, collapse = ", "),
                      model = mod) %>%
        order_by_fattyacid(fa_col = "Xterms")

    return(gee_results)
}

#' Tidy up the GEE results output.
#'
#' @param results GEE results from analyze_gee
#'
tidy_gee_results <- function(results) {
    results %>%
        dplyr::rename(unadj.p.value = p.value, p.value = adj.p.value) %>%
        dplyr::mutate(Yterms = Yterms %>%
                          renaming_outcomes() %>%
                          forcats::fct_inorder(),
            Xterms = forcats::fct_inorder(Xterms))
}


#' Plots the estimates from the GEE modeling as a forest plot.
#'
#' @param results Results from the GEE modeling.
#'
plot_gee_main <- function(results) {
    legend_title <- ~ atop(
        paste("FDR-adjusted"),
        paste(italic(p), "-value          ")
    )
    results %>%
        seer::view_main_effect(
            graph.options = "dot.grey",
            groups = 'unit~Yterms',
            legend.title = legend_title,
            xlab = 'Percent difference with 95% CI in the outcomes\nfor each SD increase in NEFA',
            ylab = 'NEFA'
            ) +
        graph_theme(ticks = FALSE, legend.pos = "none") +
        ggplot2::facet_grid(unit~Yterms, switch = 'both',
                            scales = 'free_y',
                            space = 'free_y', as.table = FALSE) +
        ggplot2::theme(panel.spacing = grid::unit(0.6, "lines"),
                       strip.placement = "outside")
}

#' Create a table from the GEE results.
#'
#' @param results GEE model results dataset
#' @param caption caption for the table
#' @param digits number of digits for the values
#'
table_gee_main <- function(results, caption = NULL, digits = 1) {
    table_data <- results %>%
        dplyr::mutate_at(
            dplyr::vars(estimate, conf.low, conf.high),
            dplyr::funs(precise_rounding(., digits = digits))
        ) %>%
        dplyr::mutate(
            p.binary = ifelse(p.value <= 0.05, '\\*', ''),
            estimate.ci = paste0(estimate, ' (', conf.low, ', ', conf.high, ')',
                                 p.binary)
        ) %>%
        dplyr::select(Yterms, Xterms, unit, estimate.ci) %>%
        tidyr::spread(Yterms, estimate.ci) %>%
        dplyr::mutate(Xterms = as.character(Xterms))

    dplyr::bind_rows(
            tibble::data_frame(Xterms = '**Total**'),
            dplyr::filter(table_data, unit == 'Total'),
            tibble::data_frame(Xterms = '**nmol/mL**'),
            dplyr::filter(table_data, unit == 'nmol/mL'),
            tibble::data_frame(Xterms = '**mol%**'),
            dplyr::filter(table_data, unit == 'mol%')
        ) %>%
        dplyr::select(-unit) %>%
        dplyr::rename('Fatty acid' = Xterms) %>%
        as.data.frame() %>%
        pander::pander(missing = '', caption = caption)

}
