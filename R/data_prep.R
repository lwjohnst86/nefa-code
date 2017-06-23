
#' Order fatty acid variables that are in a column (long form) by degree of desaturation.
#'
#' @param data Dataset with fatty acid variables in long form.
#' @param fa_col The column that contains the fatty acid variables.
#'
order_by_fattyacid <- function(data, fa_col) {
    data %>%
        dplyr::rename_("Measure" = fa_col) %>%
        dplyr::mutate(
            order1 = substr(Measure, nchar(Measure), nchar(Measure)),
            order1 = ifelse(order1 == 0, 10, order1),
            order1 = ifelse(order1 == 'l', 20, order1),
            order1 = as.integer(order1)
        ) %>%
        dplyr::arrange(dplyr::desc(order1)) %>%
        dplyr::select(-order1) %>%
        dplyr::rename_(.dots = stats::setNames(names(.), gsub("Measure", fa_col, names(.))))
}
