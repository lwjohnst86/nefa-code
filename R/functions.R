##'
##' Functions
##'
##' Custom functions used for analyses.
##'


# Analyze -----------------------------------------------------------------

analyze_lcmm <- function(data, lc.var = 'lISSI2') {
    data.prep <- data %>%
        dplyr::select_('SID', lc.var, 'VN') %>%
        stats::na.omit() %>%
        dplyr::arrange(SID, VN)
    lcmm_results <- lcmm::lcmm(
        lISSI2 ~ VN,
        mixture = ~ VN, random = ~ VN, subject = 'SID',
        ng = 3, idiag = TRUE, link = '3-equi-splines',
        data = data.prep
    )

    return(lcmm_results)
}

analyze_plsda <- function(data, variable = 'ClassLCMM') {
    data.prep <- data %>%
        dplyr::filter(VN == 0) %>%
        dplyr::select(dplyr::contains(variable), dplyr::matches('^pct_ne\\d\\d')) %>%
        na.omit()

    if (length(caret::nearZeroVar(data.prep[2:dim(data.prep)[2]])) != 0)
        message('Near zero variance, check into it')

    # pre-processing
    data.prep <- caret:::predict.preProcess(caret::preProcess(data.prep), data.prep)

    y <- as.factor(data.prep[[1]])
    x <- as.matrix(data.prep[2:dim(data.prep)[2]])
    plsda_results <- list(
        results = caret::plsda(x, y, probMethod = 'Bayes'),
        data = list(
            x = x,
            y = y
        )
    )

    ## Returns a list
    return(plsda_results)
}

# Grab or combine data ----------------------------------------------------

get_dysglycemia_data <- function(data) {
    dysgly.data <-
        dplyr::left_join(
            data %>%
                dplyr::filter(VN == 0),
            data %>%
                dplyr::filter(!is.na(TotalNE)) %>%
                dplyr::mutate_each(dplyr::funs(ifelse(is.na(.), 0, .)), IFG, IGT) %>%
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

    return(dysgly.data)
}

combine_lcmm_data <- function(data, results.lcmm) {
    data <- data %>%
        dplyr::full_join(results.lcmm$pprob %>%
                             as.data.frame() %>%
                             dplyr::select(SID, class)) %>%
        dplyr::mutate(class = factor(class, levels = c(2, 1, 3),
                                     labels = c('High', 'Mid', 'Low'))) %>%
        dplyr::rename(ClassLCMM = class)

    return(data)
}


# Plotting ----------------------------------------------------------------

plot_lcmm_results <- function(results.lcmm) {
    results.lcmm %>%
        ggplot2::ggplot(ggplot2::aes(f.VN, lISSI2, group = SID, colour = ClassLCMM)) +
        ggplot2::geom_line(ggplot2::aes(group = SID, colour = ClassLCMM), size = 0.1, alpha = 0.9) +
        ggplot2::geom_smooth(ggplot2::aes(group = ClassLCMM), method = "loess", size = 2)  +
        ggplot2::labs(x = "Time", y = "log(ISSI-2)", colour = "Latent Class") +
        ggplot2::scale_x_discrete(labels = c('Baseline', 'Year 3', 'Year 6'), expand = c(0.05, 0.05)) +
        graph_theme()
}


plot_plsda_loadings <- function(results.plsda) {
    # Select only the plsda results from the list
    results <- results.plsda$results

    seer::view_plsda_xloadings(results, renaming.x = renaming_fa) +
        graph_theme(minor.grid.lines = TRUE)
}

plot_plsda_grouping <- function(results.plsda, legend = 'LCMM Class') {
    # Select only the plsda results and class from the list
    results <- results.plsda$results
    grouping <- results.plsda$data$y

    # Explained variance for each component from PLSDA
    explained.var <- round((results$Xvar / results$Xtotvar) * 100, 1)

    plot_data <- results$scores %>%
        as.data.frame.matrix %>%
        cbind(grouping) %>%
        dplyr::rename(Comp1 = `Comp 1`, Comp2 = `Comp 2`)

    plot_data %>%
        ggplot2::ggplot(ggplot2::aes(Comp1, Comp2, colour = grouping)) +
        ggplot2::stat_density2d(ggplot2::aes(alpha = ..level.., colour = grouping), size = 1) +
        ggplot2::scale_alpha(guide = 'none') +
        ggplot2::scale_color_discrete(legend) +
        ggplot2::labs(
            x = paste0('Component 1 (', explained.var[1], '%)'),
            y = paste0('Component 2 (', explained.var[2], '%)')
        ) +
        graph_theme(minor.grid.lines = TRUE)
}

example_plsda_results <- function() {
    library(caret)
    data(mdrr)
    set.seed(1)
    inTrain <- sample(seq(along = mdrrClass), 450)

    nzv <- nearZeroVar(mdrrDescr)
    filteredDescr <- mdrrDescr[, -nzv]

    training <- filteredDescr[inTrain,]
    trainMDRR <- mdrrClass[inTrain]

    preProcValues <- preProcess(training)

    trainDescr <- predict(preProcValues, training)

    y <- trainMDRR
    x <- trainDescr
    plsda_results <- list(
        results = caret::plsda(x, y, probMethod = 'Bayes'),
        data = list(
            x = x,
            y = y
        )
    )

    return(plsda_results)
}
