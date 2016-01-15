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
        gsub('\\D\\D(\\d\\d)(\\d)', '\\1:\\2', .) %>%
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

analyze_gee <- function(data, y, x, covar, unit) {
    data %>%
        mason::design('gee', family = gaussian, corstr = 'ar1') %>%
        mason::lay_base('SID', y, x, covar) %>%
        mason::build() %>%
        mason::polish(
            'Xterm$', adjust.p = FALSE,
            transform.beta.funs = function(x)
                (exp(x) - 1) * 100,
            rename.vars.funs = renaming_list
        ) %>%
        dplyr::mutate(unit = as.factor(unit))
}

