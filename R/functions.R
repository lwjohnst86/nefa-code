##'
##' Functions
##' =========
##'
##' Custom functions used for analyses.
##'

renaming_table_rows <- function(x) {
    x %>%
        gsub('IGIIR', 'IGI/IR', .) %>%
        gsub('ISSI2', 'ISSI-2', .) %>%
        gsub('HOMA', 'HOMA-IR', .) %>%
        gsub('TAG', 'TAG (mmol/L)', .) %>%
        gsub('Chol', 'Chol (mmol/L)', .) %>%
        gsub('LDL', 'LDL (mmol/L)', .) %>%
        gsub('HDL', 'HDL (mmol/L)', .) %>%
        gsub('ne_Total', 'NEFA (nmol/mL)', .) %>%
        gsub('Age', 'Age (yrs)', .) %>%
        gsub('BMI', 'BMI (kg/m^2^)', .) %>%
        gsub('Waist', 'WC (cm)', .)
}

renaming_outcomes <- function(x) {
    x %>%
        gsub('linvHOMA', 'log(HOMA-IS)', .) %>%
        gsub('lISI', 'log(ISI)', .) %>%
        gsub('lIGIIR', 'log(IGI/IR)', .) %>%
        gsub('lISSI2', 'log(ISSI-2)', .)
}

renaming_fa <- function(x) {
    x %>%
        gsub('.*(\\d\\d)(\\d)', '\\1:\\2', .) %>%
        gsub('n(\\d)$', 'n-\\1', .) %>%
        gsub('D(\\d\\d)$', 'D-\\1', .) %>%
        gsub('^pct_', '', .) %>%
        gsub('ne_Total', 'Total', .)
}

renaming_fraction <- function(x) {
    x %>%
        gsub('ne', 'Non-esterified', .)
}

renaming_list <- function(x) {
    x %>%
        renaming_fa() %>%
        renaming_outcomes()
}

analyze_gee <- function(data, y, x, covar, unit, adj.p = FALSE, adj.p.method = 'BH', int = FALSE) {

    if (int) {
        extract_term <- ':'
    } else {
        extract_term <- 'Xterm$'
    }
    out <- data %>%
        mason::design('gee', family = gaussian, corstr = 'ar1') %>%
        {
            if (int) {
                mason::lay_base(., 'SID', y, x, covar, intvar = 'VN')

            } else {
                mason::lay_base(., 'SID', y, x, covar)
            }
        } %>%
        mason::build() %>%
        mason::polish(
            extract_term, adjust.p = FALSE,
            transform.beta.funs = function(x)
                (exp(x) - 1) * 100,
            rename.vars.funs = renaming_list
        ) %>%
        dplyr::mutate(Xterms = Xterms %>% factor(., unique(.)),
                      unit = as.factor(unit))

    if (adj.p) {
        out <- out %>%
            dplyr::mutate(p.value = p.adjust(p.value, method = adj.p.method))
    }

    return(out)

}

get_gee_data <- function(ds) {
    full_join(
    ds %>%
        select(-matches('pct_ne|^ne'),-ne_Total),
    ## Scale all the fatty acids
    ds %>%
        filter(VN == 0) %>%
        select(SID, ne_Total, matches('pct_ne|^ne')) %>%
        mutate_each(funs(as.numeric(scale(.))),-SID),
    by = 'SID') %>%
    group_by(VN) %>%
    mutate(
        Waist = as.numeric(scale(Waist)),
        ALT = as.numeric(scale(ALT)),
        BaseAge = as.numeric(scale(BaseAge)),
        MET = as.numeric(scale(MET)),
        TAG = as.numeric(scale(TAG)),
        AlcoholPerWk = plyr::mapvalues(
            as.factor(AlcoholPerWk), c('1', '2', '3', '4', '5', '6', '7'),
            c('1', '2', '3', '3', '3', '3', '3')
            ) %>%
            as.factor()
        ) %>%
    ungroup() %>%
    arrange(SID, VN)
}

forest_plot <- function(data) {
    data %>%
        seer::trance('main_effect') %>%
        seer::visualize(groups = 'unit~Yterms',
                        xlab = 'Percent difference with 95% CI in the outcomes\nfor each SD increase in fatty acid',
                        ylab = 'Non-esterified fatty acids') %>%
        seer::vision_simple(legend_position = 'bottom') +
        ggplot2::theme(
            axis.text.y = element_text(face = ifelse(
                gee_results$Xterms == 'Total', "bold", "plain"
            )),
            legend.key.width = grid::unit(0.75, "line"),
            legend.key.height = grid::unit(0.75, "line"),
            panel.margin = grid::unit(0.75, "lines"),
            strip.background = element_blank()
        ) +
        ggplot2::scale_alpha_discrete(name = 'P-value', range = c(0.4, 1.0))
}
