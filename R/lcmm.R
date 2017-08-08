
#' Compute LCMM groups.
#'
#' @param data project data
#' @param lc_var latent class variable
#'
analyze_lcmm <- function(data, lc_var = 'lISSI2') {
    data_prep <- data %>%
        dplyr::select_('SID', lc_var, 'VN') %>%
        stats::na.omit() %>%
        dplyr::arrange(SID, VN)

    lcmm_formula <- as.formula(paste0(lc_var, " ~ VN"))
    lcmm_results <- lcmm::lcmm(
        lcmm_formula,
        mixture = ~ VN, random = ~ VN, subject = 'SID',
        ng = 3, idiag = TRUE, link = '3-equi-splines',
        data = data_prep
    )

    return(lcmm_results)
}

#' Combine together the project data and the lcmm results.
#'
#' @param data project data
#' @param results lcmm results
#'
combine_lcmm_results_with_data <- function(data, results) {
    data <- data %>%
        dplyr::full_join(results$pprob %>%
                             as.data.frame() %>%
                             dplyr::select(SID, class)) %>%
        dplyr::filter(!is.na(class)) %>%
        dplyr::mutate(class = factor(
            class,
            levels = c(2, 1, 3),
            labels = c('High', 'Mid', 'Low')
        )) %>%
        dplyr::rename(ClassLCMM = class)

    return(data)
}

#' Plot the results of the LCMM modeling.
#'
#' @param data project data
#' @param results lcmm results
#' @param lc_var the latent class variable
#'
plot_lcmm_results <- function(data, results, lc_var = "lISSI2") {
    data %>%
        combine_lcmm_results_with_data(results) %>%
        ggplot2::ggplot(ggplot2::aes_string("f.VN", lc_var, group = "SID", colour = "ClassLCMM")) +
        ggplot2::geom_line(ggplot2::aes(group = SID, colour = ClassLCMM), size = 0.1, alpha = 0.9) +
        ggplot2::geom_smooth(ggplot2::aes(group = ClassLCMM), method = "loess", size = 2)  +
        ggplot2::labs(x = "Time", y = "log(ISSI-2)", colour = "Latent Class") +
        ggplot2::scale_x_discrete(labels = c('Baseline', 'Year 3', 'Year 6'), expand = c(0.05, 0.05)) +
        graph_theme()
}

# Untested right now. Worked previously.
calculate_ngroups_lcmm <- function(results.lcmm) {
    n_by_group <- results.lcmm$pprob$class %>%
        table %>%
        as.data.frame
    names(n_by_group) <- c('Group', 'Freq')
    n_by_group <-
        dplyr::mutate(n_by_group, Group = factor(Group, labels = c('Mid', 'High', 'Low')))

    return(n_by_group)
}
