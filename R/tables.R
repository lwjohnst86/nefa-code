
# Tables ------------------------------------------------------------------

#' Create a basic descriptive characteristics table.
#'
#' @param data project data
#' @param caption table caption
#'
table_basic <- function(data, caption = NULL) {
    data %>%
        dplyr::mutate(Ethnicity = ifelse(VN == 0, as.character(Ethnicity), NA),
                      Ethnicity = as.factor(Ethnicity),
                      Sex = ifelse(VN == 0, as.character(Sex), NA),
                      Sex = as.factor(Sex)) %>%
        carpenter::outline_table('f.VN') %>%
        carpenter::add_rows(c('HOMA2_S', 'ISI', 'IGIIR', 'ISSI2'),
                            carpenter::stat_medianIQR, digits = 1) %>%
        carpenter::add_rows(c('BMI', 'Waist', 'Age', 'MET', 'ALT', 'TAG', 'Chol', 'HDL',
                              'BaseTotalNE'),
                            carpenter::stat_meanSD,
                            digits = 1) %>%
        carpenter::add_rows(c('Ethnicity', 'Sex'), carpenter::stat_nPct, digits = 0) %>%
        carpenter::renaming('rows', renaming_table_rows) %>%
        carpenter::renaming('header', function(x) c('Measure', 'Baseline', '3-yr', '6-yr')) %>%
        carpenter::build_table(caption = caption)
}

#' Table of raw values for the concentration and proportion for NEFA.
#'
#' @param data project data
#' @param caption table caption
#'
table_distribution <- function(data, caption = NULL) {
    grep_nefa <- function(pattern, x = c(ne_conc, ne_total))
        rev(grep(pattern, x, value = TRUE))

    nefa <- c(grep_nefa('3$'), grep_nefa('6$'), grep_nefa('7$'),
              grep_nefa('9$'), grep_nefa('0$'), grep_nefa('TotalNE$'))

    data %>%
        dplyr::filter(VN == 0) %>%
        tidyr::gather(FA, Value, dplyr::matches('ne\\d')) %>%
        dplyr::mutate(unit = as.factor(ifelse(grepl('pct_', FA), 'mol%', 'nmol/mL')),
                      FA = gsub('pct_', '', FA)) %>%
        tidyr::spread(FA, Value) %>%
        dplyr::mutate(TotalNE = ifelse(unit == 'mol%', NA, TotalNE),
                      unit = factor(unit, levels = c('nmol/mL', 'mol%'), ordered = TRUE)) %>%
        carpenter::outline_table('unit') %>%
        carpenter::add_rows(nefa, carpenter::stat_meanSD, digits = 2) %>%
        carpenter::renaming('header', function(x) c('NEFA', 'Concentrations (nmol/mL)', "Proportion (mol%)")) %>%
        carpenter::renaming('rows', renaming_fa) %>%
        carpenter::build_table(caption = caption)
}
