outcomes <- c('lHOMA2_S', 'lISI', 'lIGIIR', 'lISSI2')
ne_pct <- grep('^pct_ne', vars, value = TRUE)
ne_conc <- grep('^ne\\d\\d', vars, value = TRUE)
ne_total <- "TotalNE"
covariates <- c("YearsFromBaseline", 'Waist', 'Sex', 'BiEthnicity', 'BaseAge', 'ALT', 'FamHistDiab')
