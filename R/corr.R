#' Compute correlation coefficients (pearson) results dataset.
#'
#' @return Saves a dataset with the correlation coefficient results.
#' @param x Variables on the X-axis
#' @param y Variables on the Y-axis
analyze_corr <- function(x = c(outcomes, 'BMI', 'Waist', 'Age', 'lALT', 'lTAG', 'Chol', 'HDL', 'LDL'),
                         y) {

    baseline_data <- project_data %>%
        dplyr::filter(VN == 0)

    corr_results <- baseline_data %>%
        mason::design('cor') %>%
        mason::add_settings(method = 'pearson', use = 'complete.obs') %>%
        mason::add_variables('yvars', y) %>%
        mason::add_variables('xvars', x) %>%
        mason::construct() %>%
        mason::scrub() %>%
        dplyr::mutate_at("Vars2", renaming_fa) %>%
        dplyr::mutate_at("Vars1", function(x)
            gsub('l(ALT|TAG|IGIIR|HOMA2_S|invHOMA|ISI|ISSI2)', '\\1', x) %>%
                renaming_outcomes()) %>%
        order_by_fattyacid(fa_col = 'Vars2') %>%
        dplyr::mutate(Vars2 = forcats::fct_inorder(Vars2),
                      Vars1 = forcats::fct_inorder(Vars1),
                      Correlations = round(Correlations, 2))

    return(corr_results)
}

#' Plot the correlations into a heatmap.
#'
#' @param results Correlation results
plot_corr_heatmap <- function(results, unit) {
    results %>%
        seer::view_heatmap(
            y = 'Vars2',
            x = 'Vars1',
            ylab = paste0('Non-esterified fatty acids (', unit, ")"),
            number.colours = 5,
            values.text = FALSE
        ) +
        graph_theme(ticks = FALSE, legend.pos = 'right')
}
