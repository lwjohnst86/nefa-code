
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

#' Calculate incident dysglycemia over the 6 years.
#'
#' @param data project data
#'
incident_dysglycemia_data <- function(data) {
    dysgly_data <-
        dplyr::left_join(
            data %>%
                dplyr::filter(VN == 0),
            data %>%
                dplyr::filter(!is.na(TotalNE)) %>%
                dplyr::mutate_at(c("IFG", "IGT"), dplyr::funs(ifelse(is.na(.), 0, .))) %>%
                dplyr::mutate(PreDM = as.numeric(rowSums(.[c('IFG', 'IGT')], na.rm = TRUE))) %>%
                dplyr::mutate(FactorDysgly = ifelse(
                    PreDM == 1, 'PreDM',
                    ifelse(DM == 1, 'DM',
                           'NGT')
                )) %>%
                dplyr::select(SID, VN, FactorDysgly) %>%
                tidyr::spread(VN, FactorDysgly) %>%
                dplyr::mutate(
                    DetailedConvert = as.factor(paste0(`0`, '-', `1`, '-', `2`)),
                    ConvertDysgly = as.numeric(!grepl('NGT$|NGT-NA$|NGT-NGT-NA$|NGT-NA-NA$',
                                                      DetailedConvert)),
                    ConvertDM = as.numeric(grepl('-DM$|-DM-DM$|-DM-NA$|-DM-NGT$',
                                                 DetailedConvert)),
                    ConvertPreDM = as.numeric(grepl('-PreDM$|-PreDM-PreDM$|-PreDM-NA$',
                                                    DetailedConvert))
                )
        ) %>%
        dplyr::filter(!is.na(TotalNE))

    return(dysgly_data)
}
