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

analyze_gee <- function(data, y, x, covar, unit, adj.p = FALSE, adj.p.method = 'BH', int = FALSE) {

    if (int) {
        extract_term <- ':'
    } else {
        extract_term <- 'Xterm$'
    }
    out <- data %>%
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
        )

    if (adj.p) {
        out <- out %>%
            dplyr::mutate(p.value = p.adjust(p.value, method = adj.p.method))
    }

    return(out)

}

get_gee_data <- function(ds) {
    full_join(
    ds %>%
        select(-matches('pct_ne|^ne'),-ne_Total),
    ## Scale all the fatty acids
    ds %>%
        filter(VN == 0) %>%
        select(SID, ne_Total, matches('pct_ne|^ne')) %>%
        mutate_each(funs(as.numeric(scale(.))),-SID),
    by = 'SID') %>%
    group_by(VN) %>%
    mutate(
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
    ungroup() %>%
    arrange(SID, VN)
}

get_lda_data <- function(data) {
    data %>%
        filter(VN == 0) %>%
        mutate(BCF = rstatsToolkit::aide.tertile(lISSI2) %>%
                   factor(
                       ., labels = c(
                           '1st tertile: log(ISSI-2)',
                           '2nd tertile: log(ISSI-2)',
                           '3rd tertile: log(ISSI-2)'
                       ),
                       ordered = TRUE
                   )) %>%
        select(BCF, matches('^ne\\d\\d')) %>%
        mutate_each(funs(as.numeric(scale(.))),-BCF) %>%
        na.omit() %>%
        arrange(BCF)
}

plot_gee_results <- function(data) {
    data <- data %>%
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

calculate_percent_nefa_contribution <- function(data) {
    data %>%
        filter(VN == 0) %>%
        select(matches('pct_ne')) %>%
        gather(fat, value) %>%
        group_by(fat) %>%
        summarise(pct = round(mean(value, na.rm = TRUE), 1)) %>%
        mutate(fat = renaming_fa(fat),
               c = paste0(fat, ' (', pct, '%)')) %>%
        arrange(desc(pct)) %>%
        filter(pct >= 10)
}

calculate_misclass_npct <- function(data.lda, data.orig) {
    fit.class <- predict(data.lda, newdata = data.orig[,-1])$class %>%
        factor(., ordered = TRUE)

    # Amount of participants who were misclassified
    misclass <- table(fit.class, data.orig[[1]]) %>%
        as.data.frame() %>%
        filter(fit.class != Var2) %>%
        summarize(count = sum(Freq)) %>%
        as.numeric()

    # Amount of participants who were correctly classified
    good_class <- table(fit.class, data.orig[[1]]) %>%
        as.data.frame() %>%
        filter(fit.class == Var2) %>%
        summarize(count = sum(Freq)) %>%
        as.numeric()

    npct <-
        paste0(misclass, ' (', round(misclass / (good_class + misclass) * 100, 0), '%)')
    return(npct)
}

calculate_outcomes_pct_change <- function(data) {
    data %>%
        select(f.VN, HOMA, ISI, IGIIR, ISSI2) %>%
        gather(Measure, Value,-f.VN) %>%
        na.omit() %>%
        group_by(Measure, f.VN) %>%
        summarise(med = median(Value)) %>%
        ungroup() %>%
        spread(f.VN, med) %>%
        mutate(pctChg = ((yr6 - yr0) / yr0) * 100) %>%
        select(pctChg) %>%
        abs() %>%
        round(1) %>%
        {
        paste0(min(.), '% to ', max(.), '%')
        }
}

extract_gee_estimateCI <- function(data) {
    data %>%
      mutate(estCI = paste0('(beta: ', trim(format(round(estimate, 1), nsmall = 1)),
                            ' CI: ',
                            trim(format(round(conf.low, 1), nsmall = 1)),
                            ', ',
                            trim(format(round(conf.high, 1), nsmall = 1)),
                            ')'),
             #indep.estCI = paste(indep, estCI),
             #dep = paste(dep %>% gsub('log\\((.*)\\)', '\\1', .), estCI),
             dep = paste(dep %>% gsub('log\\((.*)\\)', '\\1', .))
             ) %>%
      filter(p.value <= 0.05) %>%
      arrange(dep, desc(estimate)) %>%
      select(dep, indep, estCI)
}
