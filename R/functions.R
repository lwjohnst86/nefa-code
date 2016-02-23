##'
##' Functions
##' =========
##'
##' Custom functions used for analyses.
##'


# Renaming ----------------------------------------------------------------

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
        gsub('.*(\\d\\d)(\\d)', '\\1:\\2', .) %>%
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


# Analyze -----------------------------------------------------------------

analyze_gee <- function(data, y, x, covar, unit,
                        adj.p = FALSE, adj.p.method = 'BH', int = FALSE) {
    if (int) {
        extract_term <- ':'
    } else {
        extract_term <- 'Xterm$'
    }
    gee_results <- data %>%
        mason::design('gee', family = gaussian, corstr = 'ar1') %>%
        {
            if (int) {
                mason::lay_base(., 'SID', y, x, covar, intvar = 'VN')

            } else {
                mason::lay_base(., 'SID', y, x, covar)
            }
        } %>%
        mason::build() %>%
        mason::polish(
            extract_term, adjust.p = FALSE,
            transform.beta.funs = function(x)
                (exp(x) - 1) * 100,
            rename.vars.funs = renaming_list
        ) %>%
        dplyr::mutate(
            unit = unit,
            order1 = substr(Xterms, nchar(Xterms), nchar(Xterms)),
            order2 = substr(Xterms, 1, 2),
            Yterms = factor(Yterms, unique(Yterms))
        ) %>%
        dplyr::arrange(order1, order2, Yterms) %>%
        dplyr::select(-order1,-order2)

    if (adj.p) {
        gee_results <- gee_results %>%
            dplyr::mutate(p.value = p.adjust(p.value, method = adj.p.method))
    }

    return(gee_results)
}

analyze_lcmm <- function(data, lc.var = 'lISSI2') {
    data.prep <- data %>%
        dplyr::select_('SID', lc.var, 'VN') %>%
        na.omit() %>%
        dplyr::arrange(SID, VN)
    lcmm_results <- lcmm::lcmm(
        lISSI2 ~ VN,
        mixture = ~ VN, random = ~ VN, subject = 'SID',
        ng = 3, idiag = TRUE, link = '3-equi-splines',
        data = data.prep
    )

    return(lcmm_results)
}

analyze_plsda <- function(data.lcmm) {
    data.prep <- data.lcmm %>%
        dplyr::filter(VN == 0) %>%
        dplyr::select(ClassLCMM, matches('^ne\\d\\d')) %>%
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

get_gee_data <- function(data) {
    gee_ready_data <- dplyr::full_join(
        data %>%
            dplyr::select(-matches('pct_ne|^ne'),-ne_Total),
        ## Scale all the fatty acids
        data %>%
            dplyr::filter(VN == 0) %>%
            dplyr::select(SID, ne_Total, matches('pct_ne|^ne')) %>%
            dplyr::mutate_each(funs(as.numeric(scale(
                .
            ))),-SID),
        by = 'SID'
    ) %>%
    dplyr::group_by(VN) %>%
    dplyr::mutate(
        Waist = as.numeric(scale(Waist)),
        ALT = as.numeric(scale(ALT)),
        BaseAge = as.numeric(scale(BaseAge)),
        MET = as.numeric(scale(MET)),
        TAG = as.numeric(scale(TAG)),
        AlcoholPerWk = plyr::mapvalues(
            as.factor(AlcoholPerWk), c('1', '2', '3', '4', '5', '6', '7'),
            c('1', '2', '3', '3', '3', '3', '3')
            ) %>%
            as.factor()
        ) %>%
    dplyr::ungroup() %>%
    dplyr::arrange(SID, VN)

    return(gee_ready_data)
}

combine_lcmm_data <- function(data, results.lcmm) {
    data <- data %>%
        dplyr::full_join(results.lcmm$pprob %>%
                             as.data.frame() %>%
                             dplyr::select(SID, class)) %>%
        dplyr::mutate(class = factor(class, labels = c('Mid', 'High', 'Low'))) %>%
        dplyr::rename(ClassLCMM = class)

    return(data)
}


# Plotting ----------------------------------------------------------------

plot_lcmm_results <- function(results.lcmm) {
    results.lcmm %>%
        ggplot2::ggplot(ggplot2::aes(VN, lISSI2, group = SID, colour = ClassLCMM)) +
        ggplot2::geom_line(ggplot2::aes(group = SID, colour = ClassLCMM), size = 0.1, alpha = 0.9) +
        ggplot2::geom_smooth(aes(group = ClassLCMM), method = "loess", size = 2)  +
        ggplot2::labs(x = "Time", y = "log(ISSI-2)", colour = "Latent Class") +
        ggthemes::theme_tufte(11, 'sans')
}

plot_gee_results <- function(results.gee) {
    data <- results.gee %>%
        mutate(Xterms = Xterms %>% factor(., unique(.)))
    data %>%
        seer::trance('main_effect') %>%
        seer::visualize(groups = 'unit~Yterms',
                        xlab = 'Percent difference with 95% CI in the outcomes\nfor each SD increase in fatty acid',
                        ylab = 'Non-esterified fatty acids') %>%
        seer::vision_simple(legend.position = 'bottom') +
        ggplot2::theme(
            axis.text = element_text(face = ifelse(
                levels(data$Xterms) == 'Total', "bold", "plain"
            )),
            legend.key.width = grid::unit(0.75, "line"),
            legend.key.height = grid::unit(0.75, "line"),
            panel.margin = grid::unit(0.75, "lines"),
            strip.background = element_blank()
        ) +
        ggplot2::scale_alpha_discrete(name = 'FDR-adjusted p-value', range = c(0.4, 1.0)) +
        ggplot2::scale_size_discrete(name = 'FDR-adjusted p-value') +
        ggplot2::facet_grid(unit~Yterms, scale = 'free_y', switch = 'y')
}

plot_nefa_distribution <- function(data) {
    data %>%
        dplyr::filter(VN == 0) %>%
        dplyr::select(SID, matches('^ne\\d')) %>%
        dplyr::filter(complete.cases(.)) %>%
        tidyr::gather(Measure, Value,-SID) %>%
        dplyr::mutate(Measure = renaming_fa(Measure) %>%
                   gsub('ne_', '', .) %>%
                   factor(., levels = unique(.))) %>%
        tidyr::spread(Measure, Value) %>%
        dplyr::select(-SID) %>%
        seer::trance('boxes_dots') %>%
        seer::visualize(dots = FALSE,
                  xlab = 'Concentration (nmol/mL)',
                  ylab = 'Non-esterified fatty acid') %>%
        seer::vision_simple() +
        ggplot2::theme(axis.ticks.y = element_blank())
}

plot_plsda_loadings <- function(results.plsda) {
    # Select only the plsda results from the list
    results <- results.plsda$results

    # Explained variance for each component from PLSDA
    explained.var <- round((results$Xvar / results$Xtotvar) * 100, 2)

    results$loadings %>%
        as.data.frame.matrix %>%
        dplyr::add_rownames('nefa') %>%
        dplyr::rename(Comp1 = `Comp 1`, Comp2 = `Comp 2`) %>%
        dplyr::mutate(nefa = nefa %>%
                   renaming_fa() %>%
                   factor(., levels = unique(.))) %>%
        ggplot2::ggplot(ggplot2::aes(Comp1, Comp2)) +
        ggplot2::geom_point(size = 0.5) +
        ggplot2::geom_text(aes(label = nefa), hjust = 0, vjust = 0) +
        ggplot2::labs(
            x = paste0('Component 1 (', round(explained.var[1], 1), '%)'),
            y = paste0('Component 2 (', round(explained.var[2], 1), '%)')
        ) +
        ggthemes::theme_tufte(11, 'sans') +
        ggplot2::theme(
            panel.grid = ggplot2::element_line(),
            panel.grid.minor = ggplot2::element_blank()
        )
}

plot_plsda_grouping <- function(results.plsda) {
    # Select only the plsda results and class from the list
    results <- results.plsda$results
    class.lcmm <- results.plsda$data$y

    # Explained variance for each component from PLSDA
    explained.var <- round((results$Xvar / results$Xtotvar) * 100, 2)

    plot_data <- results$scores %>%
        as.data.frame.matrix %>%
        cbind(class.lcmm) %>%
        dplyr::rename(Comp1 = `Comp 1`, Comp2 = `Comp 2`)

    plot_data %>%
        ggplot2::ggplot(ggplot2::aes(Comp1, Comp2, colour = class.lcmm)) +
        ggplot2::stat_density2d(ggplot2::aes(alpha = ..level.., colour = class.lcmm), size = 2) +
        ggplot2::scale_alpha(guide = 'none') +
        ggplot2::scale_color_discrete('LCMM Class') +
        ggplot2::labs(
            x = paste0('Component 1 (', round(explained.var[1], 1), '%)'),
            y = paste0('Component 2 (', round(explained.var[2], 1), '%)')
        ) +
        ggthemes::theme_tufte(11, 'sans') +
        ggplot2::theme(
            panel.grid = ggplot2::element_line(),
            panel.grid.minor = ggplot2::element_blank()
        )
}

plot_heatmap <- function(data) {
    data %>%
        dplyr::filter(VN == 0) %>%
        mason::design('cor', method = 'pearson') %>%
        mason::lay_base(c(
            outcomes, 'BMI', 'Waist', 'Age', 'lALT', 'lTAG', 'Chol', 'HDL', 'LDL'
        ), ne_conc) %>%
        mason::build() %>%
        mason::polish(
            rename.vars.fun = function(x)
                renaming_list(x) %>%
                gsub('^l(ALT|TAG)', 'log(\\1)', .)
        ) %>%
        seer::trance('heatmap') %>%
        seer::visualize(colours = c('darkred', 'darkblue'), number.colours = 5) %>%
        seer::vision_simple() +
        ggplot2::ylab('Non-esterified fatty acids (nmol/mL)')
}

# Calculate or extract for inline -----------------------------------------

calculate_ngroups_lcmm <- function(results.lcmm) {
    n_by_group <- results.lcmm$pprob$class %>%
        table %>%
        as.data.frame
    names(n_by_group) <- c('Group', 'Freq')
    n_by_group <-
        dplyr::mutate(n_by_group, Group = factor(Group, labels = c('Mid', 'High', 'Low')))

    return(n_by_group)
}

calculate_percent_nefa_contribution <- function(data) {
    over_10pct_nefa <- data %>%
        dplyr::filter(VN == 0) %>%
        dplyr::select(matches('pct_ne')) %>%
        tidyr::gather(fat, value) %>%
        dplyr::group_by(fat) %>%
        dplyr::summarise(pct = round(mean(value, na.rm = TRUE), 1)) %>%
        dplyr::mutate(fat = renaming_fa(fat),
               c = paste0(fat, ' (', pct, '%)')) %>%
        dplyr::arrange(dplyr::desc(pct)) %>%
        dplyr::filter(pct >= 10)

    return(over_10pct_nefa)
}

calculate_plsda_misclass <- function(results.plsda) {
    misclass_plsda <-
        caret::confusionMatrix(predict(results.plsda$results,
                                       results.plsda$data$x), results.plsda$data$y) %>%
        .$table %>%
        as.data.frame %>%
        dplyr::mutate(Match = ifelse(Prediction == Reference, 'yes', 'no')) %>%
        dplyr::group_by(Match) %>%
        dplyr::summarise(N = sum(Freq)) %>%
        dplyr::ungroup() %>%
        dplyr::mutate(Total = sum(N),
                      Percent = paste0(round((N / Total) * 100, 1), '%'))

    return(misclass_plsda)
}

calculate_outcomes_pct_change <- function(data) {
    change_over_time_outcomes <- data %>%
        dplyr::select(f.VN, HOMA, ISI, IGIIR, ISSI2) %>%
        tidyr::gather(Measure, Value,-f.VN) %>%
        na.omit() %>%
        dplyr::group_by(Measure, f.VN) %>%
        dplyr::summarise(med = median(Value)) %>%
        dplyr::ungroup() %>%
        tidyr::spread(f.VN, med) %>%
        dplyr::mutate(pctChg = ((yr6 - yr0) / yr0) * 100) %>%
        dplyr::select(pctChg) %>%
        abs() %>%
        round(1) %>%
        {paste0(min(.), '% to ', max(.), '%')}

    return(change_over_time_outcomes)
}


extract_gee_estimateCI <- function(data) {
    data %>%
        dplyr::mutate(
            estCI = paste0(
                '(beta: ', trim_ws(format(round(estimate, 1), nsmall = 1)),
                ' CI: ',
                trim_ws(format(round(conf.low, 1), nsmall = 1)),
                ', ',
                trim_ws(format(round(conf.high, 1), nsmall = 1)),
                ')'
            ),
            #indep.estCI = paste(indep, estCI),
            #dep = paste(dep %>% gsub('log\\((.*)\\)', '\\1', .), estCI),
            dep = paste(dep %>% gsub('log\\((.*)\\)', '\\1', .))
        ) %>%
      dplyr::filter(p.value <= 0.05) %>%
      dplyr::arrange(dep, dplyr::desc(estimate)) %>%
      dplyr::select(dep, indep, estCI)
}

# Tables ------------------------------------------------------------------

table_gee <- function(results, caption, digits = 1) {
    gee_table_prep <- results %>%
        mutate_each(funs(trim_ws(format(
            round(., digits), nsmall = digits
        ))), estimate, conf.low, conf.high) %>%
        mutate(
            p.binary = ifelse(p.value <= 0.05, '\\*', ''),
            estimate.ci = paste0(estimate, ' (', conf.low, ', ', conf.high, ')', p.binary),
            Yterms = factor(Yterms, unique(Yterms)),
            Xterms = factor(Xterms, unique(Xterms))
        ) %>%
        select(Yterms, Xterms, unit, estimate.ci) %>%
        spread(Yterms, estimate.ci)

    gee_table <-
        bind_rows(
            data.frame(Xterms = paste0('**', unique(gee_table_prep$unit)[1], '**')),
            filter(gee_table_prep, unit == 'mol%'),
            data.frame(Xterms = paste0('**', unique(gee_table_prep$unit)[2], '**')),
            filter(gee_table_prep, unit == 'nmol/mL')
        ) %>%
        select(-unit)

    pander(gee_table, missing = '', caption = caption)
}

# Misc --------------------------------------------------------------------

# Trim white space
trim_ws <- function (x) gsub("^\\s+|\\s+$", "", x)



