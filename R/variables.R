outcomes <- c('linvHOMA', 'lISI', 'lIGIIR', 'lISSI2')
ne_pct <- grep('^pct_ne', vars, value = TRUE)
ne_conc <- grep('^ne\\d\\d', vars, value = TRUE)
covariates <- c('VN', 'Waist', 'Sex', 'Ethnicity', 'BaseAge', 'ALT', 'FamHistDiab')
