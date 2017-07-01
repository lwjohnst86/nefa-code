
#' Generate and save all the outputs of the analyses as datasets.
#'
#' @return Saves the various outputs of the analyses as datasets.
#' @export
generate_results <- function() {
    generate_results_corr()
    generate_results_gee()
    generate_results_lcmm()
    generate_data_dysgly()
    generate_results_pls()

    invisible()
}

#' Generate and save the results from the GEE modeling as a dataset.
#'
generate_results_gee <- function() {
    gee_data <- prep_gee_data(project_data)

    gee_results_adj <- dplyr::bind_rows(
        analyze_gee(gee_data, y = outcomes[1:2], x = ne_pct, covar = covariates,
                    unit = 'mol%', mod = "Adjusted"),
        analyze_gee(gee_data, y = outcomes[3:4], x = ne_pct, covar = covariates,
                    unit = 'mol%', mod = "Adjusted"),
        analyze_gee(gee_data, y = outcomes[1:2], x = ne_conc, covar = covariates,
                    unit = 'nmol/mL', mod = "Adjusted"),
        analyze_gee(gee_data, y = outcomes[3:4], x = ne_conc, covar = covariates,
                    unit = 'nmol/mL', mod = "Adjusted"),
        analyze_gee(gee_data, y = outcomes, x = ne_total, covar = covariates,
                    unit = 'Total', mod = "Adjusted")
        ) %>%
        tidy_gee_results()

    gee_results_unadj <- dplyr::bind_rows(
        analyze_gee(gee_data, y = outcomes[1:2], x = ne_pct, covar = 'YearsFromBaseline',
                    unit = 'mol%', mod = "Unadjusted"),
        analyze_gee(gee_data, y = outcomes[3:4], x = ne_pct, covar = 'YearsFromBaseline',
                    unit = 'mol%', mod = "Unadjusted"),
        analyze_gee(gee_data, y = outcomes[1:2], x = ne_conc, covar = 'YearsFromBaseline',
                    unit = 'nmol/mL', mod = "Unadjusted"),
        analyze_gee(gee_data, y = outcomes[3:4], x = ne_conc, covar = 'YearsFromBaseline',
                    unit = 'nmol/mL', mod = "Unadjusted"),
        analyze_gee(gee_data, y = outcomes, x = ne_total, covar = "YearsFromBaseline",
                    unit = 'Total', mod = "Unadjusted")
        ) %>%
        tidy_gee_results()

    # Save output of results into dataset
    gee_results <- dplyr::bind_rows(gee_results_adj, gee_results_unadj)
    devtools::use_data(gee_results, overwrite = TRUE)
}

#' Generate and save the results of the correlation analysis as a dataset.
#'
generate_results_corr <- function() {
    corr_results <- analyze_corr()
    # Save output of results into dataset
    devtools::use_data(corr_results, overwrite = TRUE)
}

#' Generate results for LCMM modeling as a dataset.
#'
generate_results_lcmm <- function() {
    lcmm_results <- analyze_lcmm(project_data)
    # Save output of results into dataset
    devtools::use_data(lcmm_results, overwrite = TRUE)
}

#' Generate dataset that contains incident dysglycemia data.
#'
generate_data_dysgly <- function() {
    dysgly_data <- incident_dysglycemia_data(project_data)
    # Save output of results into dataset
    devtools::use_data(dysgly_data, overwrite = TRUE)
}

#' Generate dataset that has the PLS modeling results.
#'
generate_results_pls <- function() {
    # Cross-validated (half size of dataset)
    pls_cv_results <- analyze_pls(project_data, y = "lISSI2", cv = TRUE)
    devtools::use_data(pls_cv_results, overwrite = TRUE)

    # Full dataset
    pls_full_results <- analyze_pls(project_data, y = "lISSI2", cv = FALSE)
    devtools::use_data(pls_full_results, overwrite = TRUE)
}
