# Functions for the PLS analysis
#
# Grab or combine data ----------------------------------------------------

#' Prepare the project data for PLS analysis.
#'
#' @param data Project data.
#' @param y Y or outcome variable.
#' @param x X or exposure variables of interest.
#'
prep_pls_data <- function(data, y, x) {
    data %>%
        dplyr::filter(VN == 0) %>%
        dplyr::select_(.dots = c(y, x)) %>%
        stats::na.omit()
}

# Analyze -----------------------------------------------------------------

#' Compute PLS analysis.
#'
#' @param data Project data.
#' @param y Outcome variable.
#' @param x Exposure variables.
#' @param ncomp Number of components.
#' @param cv Whether to use CV.
#'
analyze_pls <- function(data, y, x = ne_pct, ncomp = NULL, cv = TRUE) {
    data %>%
        prep_pls_data(y = y, x = x) %>%
        mason::design('pls') %>%
        mason::add_settings(ncomp = ncomp, validation = 'CV', cv.data = cv, cv.seed = 5436) %>%
        mason::add_variables('yvars', y) %>%
        mason::add_variables('xvars', x) %>%
        mason::construct() %>%
        mason::scrub()
}

# Plots -------------------------------------------------------------------

#' Plot the X loadings of the PLS results.
#'
#' @param data PLS output results.
#'
plot_pls <- function(data) {
    seer::view_pls_xloadings(data, renaming.x = renaming_fa, dot.colour = "black") +
        graph_theme(minor.grid.lines = FALSE)
}

# Calculations ------------------------------------------------------------

#' Calculate the correlation between the predicted and actual outcome.
#'
#' @param model The PLS output results.
#' @param test The test data to predict from.
#' @param ncomps The component to predict on.
#'
calc_pred_corr <- function(model, test, ncomps = 1) {
    predicted <- stats::predict(model, ncomp = ncomps, newdata = test)
    measured <- as.matrix(stats::model.response(
        stats::model.frame(formula(model), data = test))
        )
    corr <- broom::tidy(stats::cor.test(predicted, measured))[c(1, 3)]
    r <- precise_rounding(corr[1], 2)
    p <- format_p(corr[2])
    list(r = r, p = p, r_p = paste0('r=', r, ', p', p))

}
