
#' Plot the individual fatty acids in NEFA to see the distribution.
#'
plot_nefa_distribution <- function() {
    nefa_dist <- project_data %>%
        dplyr::filter(VN == 0) %>%
        dplyr::select(dplyr::matches('^ne\\d')) %>%
        tidyr::gather(Measure, Value) %>%
        dplyr::mutate(Measure = renaming_fa(Measure) %>%
                   gsub('ne_', '', .)) %>%
        order_by_fattyacid(fa_col = "Measure") %>%
        dplyr::mutate(Measure = forcats::fct_inorder(Measure))

    nefa_dist %>%
        seer::view_boxplots(dots = TRUE, "Measure", "Value") +
        ggplot2::labs(x = 'Concentration (nmol/mL)',
                      y = 'Non-esterified fatty acid') +
        graph_theme(ticks = FALSE)
}