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
        gsub('BaseTotalNE', 'NEFA (nmol/mL)', .) %>%
        gsub('Age', 'Age (yrs)', .) %>%
        gsub('BMI', 'BMI (kg/m^2^)', .) %>%
        gsub('Waist', 'WC (cm)', .)
}

renaming_outcomes <- function(x) {
    x %>%
        gsub('linvHOMA', 'log(1/HOMA-IR)', .) %>%
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
        mason::design_analysis('gee') %>%
        mason::add_settings(family = gaussian('identity'), corstr = 'ar1', cluster.id = 'SID') %>%
        mason::add_variables('yvars', y) %>%
        mason::add_variables('xvars', x) %>%
        mason::add_variables('covariates', covar) %>% {
            if (int) {
                mason::add_variables(., 'interaction', 'VN')
            } else {
                .
            }
        } %>%
        mason::construct_analysis() %>%
        mason::scrub() %>%
        mason::polish_filter(extract_term, 'term') %>%
        mason::polish_transform_estimates(function(x) (exp(x) - 1) * 100) %>%
        mason::polish_renaming(renaming_fa, 'Xterms') %>%
        mason::polish_renaming(renaming_outcomes, 'Yterms') %>%
        dplyr::mutate(
            unit = unit,
            order1 = substr(Xterms, nchar(Xterms), nchar(Xterms)),
            order1 = ifelse(order1 == 0, 10, order1),
            order1 = ifelse(order1 == 'l', 20, order1),
            order1 = as.integer(order1)
        )

    if (adj.p) {
        gee_results <- gee_results %>%
            mason::polish_adjust_pvalue(method = adj.p.method)
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
            dplyr::select(-matches('pct_ne|^ne'), -TotalNE),
        ## Scale all the fatty acids
        data %>%
            dplyr::filter(VN == 0) %>%
            dplyr::select(SID, TotalNE, matches('pct_ne|^ne')) %>%
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
    results.gee %>%
        seer::view_main_effect(
            graph.options = 'dot.size',
            groups = 'unit~Yterms',
            legend.title = 'FDR-adjusted\np-value',
            xlab = 'Percent difference with 95% CI in the outcomes\nfor each SD increase in fatty acid',
            ylab = 'Non-esterified fatty acids'
            ) %>%
        seer::vision_simple(base.size = 10, base.family = 'Arial') +
        ggplot2::theme(axis.ticks.y = element_blank())
}

plot_nefa_distribution <- function(data) {
    data %>%
        dplyr::filter(VN == 0) %>%
        dplyr::select(SID, matches('^ne\\d')) %>%
        dplyr::filter(complete.cases(.)) %>%
        tidyr::gather(Measure, Value,-SID) %>%
        dplyr::mutate(Measure = renaming_fa(Measure) %>%
                   gsub('ne_', '', .)) %>%
        dplyr::mutate(
            order1 = substr(Measure, nchar(Measure), nchar(Measure)),
            order1 = ifelse(order1 == 0, 10, order1),
            order1 = ifelse(order1 == 'l', 20, order1),
            order1 = as.integer(order1)
        ) %>%
        dplyr::arrange(desc(order1)) %>%
        dplyr::select(-order1) %>%
        dplyr::mutate(Measure = Measure %>%
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

plot_heatmap <- function(data, x = c(outcomes, 'BMI', 'Waist', 'Age', 'lALT',
                                     'lTAG', 'Chol', 'HDL', 'LDL'),
                         y = ne_conc) {
    data %>%
        dplyr::filter(VN == 0) %>%
        mason::design_analysis('cor') %>%
        mason::add_settings(method = 'pearson', obs.usage = 'complete.obs') %>%
        mason::add_variables('yvars', y) %>%
        mason::add_variables('xvars', x) %>%
        mason::construct_analysis() %>%
        mason::scrub() %>%
        mason::polish_renaming(renaming_fa, 'Vars2') %>%
        #mason::polish_renaming(renaming_outcomes, 'Vars1') %>%
        mason::polish_renaming(function(x)
            gsub('l(ALT|TAG|IGIIR|invHOMA|ISI|ISSI2)', '\\1', x) %>%
                renaming_outcomes(), 'Vars1') %>%
        mason::polish_round(2) %>%
        dplyr::mutate(
            order1 = substr(Vars2, nchar(Vars2), nchar(Vars2)),
            order1 = ifelse(order1 == 0, 10, order1),
            order1 = ifelse(order1 == 'l', 20, order1),
            order1 = as.integer(order1)
        ) %>%
        dplyr::arrange(desc(order1)) %>%
        dplyr::select(-order1) %>%
        dplyr::mutate(Vars2 = factor(Vars2, unique(Vars2)),
                      Vars1 = factor(Vars1, unique(Vars1)),
                      Correlations = round(Correlations, 2)) %>%
        seer::visualize_corr_heatmap(
            y = 'Vars2',
            x = 'Vars1',
            ylab = 'Non-esterified fatty acids (nmol/mL)',
            number.colours = 5,
            values.size = 4) %>%
        seer::vision_simple(10, 'Arial')
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

table_basic <- function(data, caption) {
    data %>%
        carpenter::outline_table(
            c(
                'BaseTotalNE',
                'HOMA',
                'ISI',
                'IGIIR',
                'ISSI2',
                'TAG',
                'Chol',
                'BMI',
                'Waist',
                'HDL',
                'FamHistDiab',
                'Age',
                'Ethnicity',
                'Sex',
                'MET',
                'IFG',
                'IGT',
                'DM'
            ),
            'f.VN'
        ) %>%
        carpenter::add_rows(c('HOMA', 'ISI', 'IGIIR', 'ISSI2'), carpenter::stat_medianIQR, digits = 1) %>%
        carpenter::add_rows(c('TAG', 'Chol', 'HDL', 'BaseTotalNE', 'BMI', 'Waist', 'Age'),
                            carpenter::stat_meanSD,
                            digits = 1) %>%
        carpenter::add_rows(c('Ethnicity', 'Sex'), carpenter::stat_nPct, digits = 0) %>%
        carpenter::rename_rows(renaming_table_rows) %>%
        carpenter::rename_columns('Measure', 'Baseline', '3-yr', '6-yr') %>%
        carpenter::construct_table(caption = caption)
}

# Misc --------------------------------------------------------------------

# Trim white space
trim_ws <- function (x) {
    gsub("^\\s+|\\s+$", "", x)
}

tidy_gee_results <- function(results.gee) {
    results.gee %>%
        dplyr::mutate(Yterms = factor(
            Yterms,
            levels = c('log(1/HOMA-IR)', 'log(ISI)',
                       'log(IGI/IR)', 'log(ISSI-2)'),
            ordered = TRUE
        )) %>%
        dplyr::rename(unadj.p.value = p.value, p.value = adj.p.value) %>%
        dplyr::arrange(desc(order1)) %>%
        dplyr::select(-order1)
}

graph_theme <- function(base.plot) {
    base.plot %>%
        seer::vision_simple(base.size = 10, base.family = 'Arial', legend.position = 'none') +
        ggplot2::theme(axis.ticks.y = element_blank())
}
