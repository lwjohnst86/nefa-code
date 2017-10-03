
# Renaming ----------------------------------------------------------------

renaming_table_rows <- function(x) {
    x %>%
        gsub('HOMA2_S', 'HOMA2-%S', .) %>%
        gsub('IGIIR', 'IGI/IR', .) %>%
        gsub('ISSI2', 'ISSI-2', .) %>%
        gsub('^HOMA$', 'HOMA-IR', .) %>%
        gsub('TAG', 'TAG (mmol/l)', .) %>%
        gsub('Chol', 'Chol (mmol/l)', .) %>%
        gsub('ALT', 'ALT (U/l)', .) %>%
        gsub('LDL', 'LDL (mmol/l)', .) %>%
        gsub('HDL', 'HDL (mmol/l)', .) %>%
        gsub('BaseTotalNE', 'NEFA (nmol/ml)', .) %>%
        gsub('Age', 'Age (yrs)', .) %>%
        gsub('Glucose0', 'Fasting glucose (mmol/l)', .) %>%
        gsub('Glucose120', '2-hour glucose (mmol/l)', .) %>%
        gsub('Insulin0', 'Fasting insulin (pmol/l)', .) %>%
        gsub('Insulin120', '2-hour insulin (pmol/l)', .) %>%
        gsub('BMI', 'BMI (kg/m^2^)', .) %>%
        gsub('FG', 'BMI (kg/m^2^)', .) %>%
        gsub('Waist', 'WC (cm)', .)
}

renaming_outcomes <- function(x) {
    x %>%
        gsub('lHOMA2_S', 'log(HOMA2-%S)', .) %>%
        gsub('linvHOMA', 'log(1/HOMA-IR)', .) %>%
        gsub('lHOMA2_S', 'log(HOMA2-%S)', .) %>%
        gsub('lISI', 'log(ISI)', .) %>%
        gsub('lIGIIR', 'log(IGI/IR)', .) %>%
        gsub('lISSI2', 'log(ISSI-2)', .) %>%
        gsub('^invHOMA$', '1/HOMA-IR', .) %>%
        gsub('^ISSI2$', 'ISSI-2', .) %>%
        gsub('^IGIIR$', 'IGI/IR', .)
}

renaming_fa <- function(x) {
    x %>%
        gsub('.*(\\d\\d)(\\d)', '\\1:\\2', .) %>%
        gsub('n(\\d)$', 'n-\\1', .) %>%
        gsub('D(\\d\\d)$', 'D-\\1', .) %>%
        gsub('^pct_', '', .) %>%
        gsub('TotalNE', 'Total', .)
}

renaming_fraction <- function(x) {
    gsub('ne', 'Non-esterified', x)
}

renaming_list <- function(x) {
    x %>%
        renaming_fa() %>%
        renaming_outcomes()
}
