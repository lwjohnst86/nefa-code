
#' Calculate the conversion of participants to DM or pre DM (incidence).
#'
#' @param variable which dysgly variable to use
#'
calc_incid_dysgly <- function(variable = c('ConvertDM', 'ConvertPreDM')) {
    variable <- match.arg(variable)

    conversion <-
        table(dysgly_data[variable])[2] %>%
        {
            paste0(., ' (', round((. / 477) * 100, 0), '%)')
        }

    return(conversion)
}

#' Calculate the percentage of contribution for NEFA that are >10 percent.
#'
#' @param data project data
#'
calc_pct_nefa <- function(data = project_data) {
    over_10pct_nefa <- data %>%
        dplyr::filter(VN == 0) %>%
        dplyr::select(dplyr::matches('pct_ne')) %>%
        tidyr::gather(fat, value) %>%
        dplyr::group_by(fat) %>%
        dplyr::summarise(pct = round(mean(value, na.rm = TRUE), 1)) %>%
        dplyr::mutate(fat = renaming_fa(fat),
               c = paste0(fat, ' (', pct, '%)')) %>%
        dplyr::arrange(dplyr::desc(pct)) %>%
        dplyr::filter(pct >= 10)

    return(over_10pct_nefa)
}

#' Calculate the percent change in the outcomes (plus sample size and p-value).
#'
#' @param data project data
#'
calc_outcomes_chg_n <- function(data = project_data) {
    prep_data <- data %>%
        dplyr::select(f.VN, HOMA2_S, ISI, IGIIR, ISSI2) %>%
        tidyr::gather(Measure, Value,-f.VN) %>%
        stats::na.omit() %>%
        dplyr::group_by(Measure, f.VN) %>%
        dplyr::summarise(med = stats::median(Value),
                         n = n()) %>%
        dplyr::ungroup()

    sample_size <- prep_data$n %>%
        {paste0(min(.), '-', max(.))}

    change_over_time <- prep_data %>%
        dplyr::select(-n) %>%
        tidyr::spread(f.VN, med) %>%
        dplyr::mutate(pctChg = ((yr6 - yr0) / yr0) * 100) %>%
        dplyr::select(pctChg) %>%
        abs() %>%
        round(0) %>%
        {paste0(min(.), '% to ', max(.), '%')}

    pval <- mason::design(data, 'gee') %>%
        mason::add_settings(family = stats::gaussian(), corstr = 'ar1', cluster.id = 'SID') %>%
        mason::add_variables('yvars', c(outcomes)) %>%
        mason::add_variables('xvars', 'VN') %>%
        mason::construct() %>%
        mason::scrub() %>%
        dplyr::filter(grepl('Xterm$', term)) %>%
        dplyr::summarise(p.value = mean(p.value)) %>%
        dplyr::mutate(p.value = format.pval(p.value, digits = 2, eps = 0.001))

    change_in_outcomes <- list(n = sample_size, chg = change_over_time, p = pval[[1]])

    return(change_in_outcomes)
}

#' Number and percent of total of discrete variables.
#'
#' @param x vector for the discrete variable.
#' @param group which value/group to use as the percent.
#'
calc_npercent <- function(x, group = c('Yes', 'Female', 'European')) {
    nums <- table(x)
    pct <- (nums[group]/sum(nums)) * 100
    list(
        n = nums[group],
        pct = paste0(round(pct, 1), '%'),
        npct = paste0(nums[group], ' (', paste0(round(pct, 1), '%)'))
    )
}

#' Calculate the mean estimate of the FA by each outcome.
#'
#' @param results gee modeling results.
#'
calc_gee_magnitude <- function(results) {
    results %>%
        dplyr::filter(p.value <= 0.05) %>%
        dplyr::group_by(Yterms) %>%
        dplyr::summarise(est = mean(estimate) %>%
                             round(1) %>%
                             abs())
}

extract_gee_estimateCI <- function(data) {
    data %>%
        dplyr::mutate(
            estCI = paste0(
                '(beta: ', precise_rounding(estimate),
                ' CI: ',
                precise_rounding(conf.low),
                ', ',
                precise_rounding(conf.high),
                ')'
            ),
            dep = paste(gsub('log\\((.*)\\)', '\\1', dep))
        ) %>%
      dplyr::filter(p.value <= 0.05) %>%
      dplyr::arrange(dep, dplyr::desc(estimate)) %>%
      dplyr::select(dep, indep, estCI)
}

#' Mean and SD followup time for those who attended the 6 year visit.
#'
#' @param data Project data
#'
calc_followup_time <- function(data = project_data) {
    data %>%
        dplyr::arrange(SID, VN) %>%
        dplyr::group_by(SID) %>%
        dplyr::slice(n()) %>%
        dplyr::ungroup() %>%
        dplyr::summarise(MeanFollowup = aide::ave_sd(YearsFromBaseline)) %>%
        .[[1]]
}

#' Calculate the number of participants who attended one, two, or three visits.
#'
#' @param data Project data.
#'
calc_n_for_visits <- function(data = project_data) {
    data %>%
        dplyr::select(SID, VN, f.VN) %>%
        stats::na.omit() %>%
        tidyr::spread(f.VN, VN) %>%
        dplyr::mutate(Visits = paste(yr0, yr3, yr6, sep = '-')) %>%
        .$Visits %>%
        table()
}


#' Percent of participants who attended each of the 3 visits.
#'
calc_pct_full_visits <- function() {
    pct_val <- calc_n_for_visits()[1] / sum(calc_n_for_visits())
    precise_rounding(pct_val * 100)
}

#' Calculate the number of DM cases at each clinic visit.
#'
calc_dm_each_visit <- function() {
    project_data %>%
        incid_dysgly() %>%
        dplyr::select(SID, DetailedConvert, `0`, `1`, `2`) %>%
        tidyr::gather(VN, Dysgly, -SID, -DetailedConvert) %>%
        dplyr::mutate(DM = as.numeric(Dysgly == "DM")) %>%
        dplyr::arrange(SID, VN) %>%
        dplyr::filter(DM == 1) %>%
        dplyr::group_by(SID) %>%
        dplyr::mutate(DM_cumsum = cumsum(DM)) %>%
        dplyr::ungroup() %>%
        dplyr::filter(DM_cumsum == 1) %>%
        dplyr::count(VN)
}
