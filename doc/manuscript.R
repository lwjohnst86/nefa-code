## ----knit_setup, echo=FALSE----------------------------------------------
knitr::opts_knit$set(root.dir = '../')

## ----setup, message=FALSE, echo=FALSE------------------------------------
source('.Rprofile')
suppressMessages(run_setup())
ds <- load_data()
ds0yr <- filter(ds, VN == 0)

## ----caption_setup-------------------------------------------------------
## Include captions below using `captioner` package
fig <- captioner(prefix = 'Figure')
cite_f <- pryr::partial(fig, display = 'cite')
sfig <- captioner(prefix = 'Supplemental Figure S')
cite_sf <- pryr::partial(sfig, display = 'cite')
tab <- captioner(prefix = 'Table')
cite_t <- pryr::partial(tab, display = 'cite')
stab <- captioner(prefix = 'Supplemental Table S')
cite_st <- pryr::partial(stab, display = 'cite')
# usage: cite_st('basicChar')

tab_basic <- tab('basicChar', 'Basic characteristics of the PROMISE participants at each of the 3 clinic visits.')
fig_dist <- fig('nefaDist', 'Concentrations (nmol/mL) of each non-esterified fatty acid in PROMISE participants at the baseline visit (2004-2006).')
fig_gee <- fig('gee', 'Longitudinal associations of individual non-esterified fatty acids (mol% and nmol/mL) with insulin sensitivity and beta-cell function over the 6 years in the PROMISE cohort.  Generalized estimating equation models were adjusted for time, sex, ethnicity, baseline age, WC, ALT, and family history of diabetes. Outcome variables were log-transformed, predictor variables were scaled, and x-axis values were exponentiated to represent percent difference per SD increase in the fatty acid. P-values were adjusted for the BH false discovery rate, with the largest dot representing a significant (p<0.05) association.')

sfig_consort <- sfig('consort', 'CONSORT diagram of sample size at each examination visit.')
stab_qic <- stab('qic', 'Comparing generalized estimating equation models adjusting for different covariates using Quasi-Likelihood Information Criterion.')
stab_dist <- stab('nefaDist', 'Raw concentration values (nmol/mL) of each non-esterified fatty acid in the PROMISE cohort at the baseline visit (2004-2006). Values are presented as mean (SD).')
sfig_corr <- sfig('corr', 'Pearson correlation heatmap of non-esterified fatty acids (nmol/mL) and basic PROMISE participant characteristics for the baseline visit (2004-2006). Darkness of the colour indicates the magnitude of the correlation, with orange indicating positive and blue indicating negative correlations.')
sfig_gee <- sfig('gee', 'Unadjusted generalized estimating equation modeling of the longitudinal association of individual non-esterified fatty acids (mol% and nmol/mL) with insulin sensitivity and beta-cell function over 6 years in the PROMISE cohort. GEE models are only adjusted for time. Outcome variables were log-transformed, predictor variables were scaled, and x-axis values were exponentiated to represent percent difference per SD increase in the fatty acid. P-values were adjusted for the BH false discovery rate, with the largest dot representing a significant (p<0.05) association (*).')
stab_gee <- stab('gee', 'Longitudinal associations of individual non-esterified fatty acids (mol% and nmol/mL) with insulin sensitivity and beta-cell function over the 6 years in the PROMISE cohort. GEE models were adjusted for time, sex, ethnicity, baseline age, WC,
ALT, and family history of diabetes. Outcome variables were log-transformed, predictor variables were scaled, and x-axis values were exponentiated to represent percent difference per SD increase in the fatty acid.  P-values were adjusted for the BH false discovery rate, with significant (p<0.05) associations indicated by asterisk (*).')
stab_gee_unadj <- stab('gee_unadj', 'Unadjusted generalized estimating equation models of the longitudinal associations of individual non-esterified fatty acids (mol% and nmol/mL) with insulin sensitivity and beta-cell function over the 6 years in the PROMISE cohort.  GEE models are only adjusted for time. Outcome variables were log-transformed, predictor variables were scaled, and x-axis values were exponentiated to represent percent difference per SD increase in the fatty acid.  P-values were adjusted for the BH false discovery rate, with significant (p<0.05) associations indicated by asterisk.')
sfig_lcmm <- sfig('lcmm', 'Latent class mixed model (LCMM) analysis to identify individual classes of trajectories for log(ISSI-2) over the 6 years in the PROMISE cohort. LCMM is a technique that identifies groups of participants that share a similar underlying trajectory in beta-cell function over the 6 years (e.g. no change compared to declines in ISSI-2). Red lines indicate individuals with a high beta-cell function who stayed high, green represents those in the middle, and blue represents those who had the lowest beta-cell function.')
sfig_plsda_groups <- sfig('plsda_groups', '')
sfig_plsda_loadings <- sfig('plsda_loadings', 'Pattern loadings from partial least squares discriminant analysis (PLS-DA) to identify potential clusters of NEFA composition within the classes extracted from the latent class mixed model in 463 participants from the baseline PROMISE visit (2004-2006). The percent explained variance of each component is shown in brackets on each axis. The solid line represents an explained variance of 100% while the dashed line represents an explained variance of 50%. See the Supplemental Methods for a description of PLS-DA and an explanation of interpreting this plot.')
sfig_plsda_groups_dysgly <- sfig('plsda_groups_dysgly', '')
sfig_plsda_loadings_dysgly <- sfig('plsda_loadings_dysgly', 'Pattern loadings from partial least squares discriminant analysis (PLS-DA) to identify potential clusters of NEFA composition for dysglycemia (IFG, IGT, DM) conversion status over the 6-years in the participants from the baseline PROMISE visit (2004-2006). See the Supplemental Methods for a description of PLS-DA and an explanation of interpreting this plot. The percent explained variance of each component is shown in brackets on each axis. The solid line represents an explained variance of 100% while the dashed line represents an explained variance of 50%.')
sfig_plsda_example <- sfig('plsda_example', 'Example results of a high discriminatory ability to classify groups accurately when using partial least squares discriminatory analysis (PLS-DA). Discriminatory ability is evident from the amount of separation between the two groups. In this case, PLS-DA was 82% accurate at correctly classifying groups. See the Supplemental Methods for a description of PLS-DA and for interpreting this plot.')
sfig_plsda_groups <- sfig('plsda_groups', paste0('Clustering of extracted components from the partial least squares discriminant analysis (PLS-DA) on the classes extracted from the latent class mixed model (LCMM) in 463 participants from the baseline PROMISE visit (2004-2006). See the Supplemental Methods for a description of PLS-DA and interpreting this plot. The percent explained variance of each component is shown in brackets on each axis. Red, green, and blue lines indicate participants classified as high, middle, and low for beta-cell function, respectively, from the LCMM analysis. See ', cite_sf('plsda_example'), ' for a hypothetical example plot showing good discriminatory ability between groups.'))
sfig_plsda_groups_dysgly <- sfig('plsda_groups_dysgly', paste0('Clustering of extracted components from the partial least squares discriminant analysis for dysglycemia (IFG, IGT, DM) conversion status over the 6-years in the participants from the baseline PROMISE visit (2004-2006).  See the Supplemental Methods for a description of PLS-DA and interpreting this plot. The percent explained variance of each component is shown in brackets on each axis. Blue lines indicate dysglycemia conversion or maintanence and red lines indicate no dysglycemia status. See ', cite_sf('plsda_example'), ' for a hypothetical example plot showing good discriminatory ability between groups.'))

## ----variableAndDataSet, message=FALSE, results='hide'-------------------
gee_df <- get_gee_data(ds)
dysgly_data <- get_dysglycemia_data(ds)

outcomes_is <- c('linvHOMA', 'lISI')
outcomes_bcf <- c('lIGIIR', 'lISSI2')
outcomes <- c(outcomes_is, outcomes_bcf)
ne_pct <- grep('^pct_ne', names(gee_df), value = TRUE)
ne_conc <- c('TotalNE', grep('^ne\\d\\d', names(gee_df), value = TRUE))
covariates <- c('VN', 'Waist', 'Sex', 'Ethnicity', 'BaseAge', 'ALT', 'FamHistDiab')

## ----geeData, cache=TRUE-------------------------------------------------
gee_results <- dplyr::bind_rows(
    analyze_gee(gee_df, outcomes_is, ne_pct, covariates, 'mol%', adj.p = TRUE),
    analyze_gee(gee_df, outcomes_is, ne_conc, covariates, 'nmol/mL', adj.p = TRUE),
    analyze_gee(gee_df, outcomes_bcf, ne_pct, covariates, 'mol%', adj.p = TRUE),
    analyze_gee(gee_df, outcomes_bcf, ne_conc, covariates, 'nmol/mL', adj.p = TRUE)
    ) %>% 
    tidy_gee_results()

gee_results_unadj <- dplyr::bind_rows(
    analyze_gee(gee_df, outcomes_is, ne_pct, 'VN', 'mol%', adj.p = TRUE),
    analyze_gee(gee_df, outcomes_is, ne_conc, 'VN', 'nmol/mL', adj.p = TRUE),
    analyze_gee(gee_df, outcomes_bcf, ne_pct, 'VN', 'mol%', adj.p = TRUE),
    analyze_gee(gee_df, outcomes_bcf, ne_conc, 'VN', 'nmol/mL', adj.p = TRUE)
    ) %>% 
    tidy_gee_results()

## ----lcmmPls, cache=TRUE, results='hide'---------------------------------
# include also the 3-yr and 6-yr data for training/testing.
lcmm_results <- analyze_lcmm(ds)
lcmm_data <- combine_lcmm_data(ds, lcmm_results)
plsda_results <- analyze_plsda(lcmm_data)
plsda_dysgly <- dysgly_data %>% 
    mutate(ConvertDysgly = factor(ConvertDysgly, levels = c(0, 1), labels = c('No', 'Yes'))) %>% 
    analyze_plsda('ConvertDysgly')

## ----inlineResults-------------------------------------------------------
percent.nefa <- calculate_percent_nefa_contribution(ds) 
misclass.n.percent.bcf <- calculate_plsda_misclass(plsda_results)
misclass.n.percent.dysgly <- calculate_plsda_misclass(plsda_dysgly)
percent.change.outcomes <- calculate_outcomes_pct_change(ds)
lcmm.groups <- calculate_ngroups_lcmm(lcmm_results)
dm.convert <- calculate_conversion_dysgly(dysgly_data, 'ConvertDM')
predm.convert <- calculate_conversion_dysgly(dysgly_data, 'ConvertPreDM')
sex.npct <- calculate_factor_npercent(ds0yr$Sex, 'Female')
ethn.npct <- calculate_factor_npercent(ds0yr$Ethnicity, 'European')
fhd.npct <- calculate_factor_npercent(ds0yr$FamHistDiab, 'Yes')
est.gee <- calculate_gee_magnitude(gee_results)

## ----figure1, fig.cap=fig_dist-------------------------------------------
plot_nefa_distribution(ds)

## ----figure2, dependson='geeData', fig.cap=fig_gee-----------------------
plot_gee_results(gee_results, leg = 'none')

## ----table1--------------------------------------------------------------
table_basic(ds, caption = tab_basic)

## ----onlineSupplementalTableS1-------------------------------------------
prep_qic <- gee_df %>%
    dplyr::select(
        SID, VN, lISSI2, lISI, TotalNE, Sex, Ethnicity, MET, ALT, BaseAge,
        Waist, BMI, AlcoholPerWk, TobaccoUse, FamHistDiab
        ) 

qic_is <- prep_qic %>% 
    dplyr::select(-lISSI2) %>% 
    na.omit()

qic_bcf <- prep_qic %>% 
    dplyr::select(-lISI) %>% 
    na.omit()

# QIC for IS
M0 <- geepack::geeglm(
    lISI ~ TotalNE + VN, data = qic_is,
    id = SID, family = gaussian,
    corstr = 'ar1'
    )


M1 <- update(M0, . ~ . + Waist + BaseAge + Ethnicity + Sex)
M2 <- update(M0, . ~ . + Waist + BaseAge + Ethnicity + Sex + ALT) # best
M3 <- update(M0, . ~ . + Waist + BaseAge + Ethnicity + Sex + ALT + MET) # best
M4 <- update(M0, . ~ . + Waist + BaseAge + Ethnicity + Sex + ALT + MET + AlcoholPerWk) # best
M5 <- update(M0, . ~ . + Waist + BaseAge + Ethnicity + Sex + ALT + MET + AlcoholPerWk + FamHistDiab) # best
M6 <- update(M0, . ~ . + Waist + BaseAge + Ethnicity + Sex + ALT + MET + AlcoholPerWk + FamHistDiab + TobaccoUse) # best
M7 <- update(M0, . ~ . + Waist + BaseAge + Ethnicity + Sex + ALT + FamHistDiab + TobaccoUse) # best
M8 <- update(M0, . ~ . + Waist + BaseAge + Ethnicity + Sex + ALT + FamHistDiab) # best
M9 <- update(M0, . ~ . + Waist + BaseAge + Ethnicity + Sex + ALT + FamHistDiab + TotalNE:VN)

qic_is_tab <- MuMIn::model.sel(M0, M1, M2, M3, M4, M5, M6, M7, M8, M9, rank = QIC) %>% 
    dplyr::add_rownames() %>%
    dplyr::select(Model = rowname, QIC, Delta = delta) %>%
    dplyr::mutate(id = seq_len(nrow(.))) %>%
    dplyr::bind_rows(., data.frame(Model = '**log(ISI)**', id = 0.5))
    
# QIC data for BCF
qic_bcf <- prep_qic %>% 
    dplyr::select(-lISI) %>% 
    na.omit()

M0 <- geepack::geeglm(
    lISSI2 ~ TotalNE + VN, data = qic_bcf,
    id = SID, family = gaussian,
    corstr = 'ar1'
    )
M1 <- update(M0, . ~ . + Waist + BaseAge + Ethnicity + Sex)
M2 <- update(M0, . ~ . + Waist + BaseAge + Ethnicity + Sex + ALT) 
M3 <- update(M0, . ~ . + Waist + BaseAge + Ethnicity + Sex + ALT + MET)
M4 <- update(M0, . ~ . + Waist + BaseAge + Ethnicity + Sex + ALT + MET + AlcoholPerWk)
M5 <- update(M0, . ~ . + Waist + BaseAge + Ethnicity + Sex + ALT + MET + AlcoholPerWk + FamHistDiab) # best
M6 <- update(M0, . ~ . + Waist + BaseAge + Ethnicity + Sex + ALT + MET + AlcoholPerWk + FamHistDiab + TobaccoUse) # best
M7 <- update(M0, . ~ . + Waist + BaseAge + Ethnicity + Sex + ALT + FamHistDiab + TobaccoUse) # best
M8 <- update(M0, . ~ . + Waist + BaseAge + Ethnicity + Sex + ALT + FamHistDiab) # best
M9 <- update(M0, . ~ . + Waist + BaseAge + Ethnicity + Sex + ALT + FamHistDiab + TotalNE:VN) # best

qic_bcf_tab <- MuMIn::model.sel(M0, M1, M2, M3, M4, M5, M6, M7, M8, M9, rank = QIC) %>% 
    dplyr::add_rownames() %>%
    dplyr::select(Model = rowname, QIC, Delta = delta) %>% 
    dplyr::mutate(id = seq_len(nrow(.))+10) %>%
    dplyr::bind_rows(., data.frame(Model = '**log(ISSI-2)**', id = 10.5))

rbind(qic_is_tab, qic_bcf_tab) %>% 
    dplyr::arrange(id) %>%
    dplyr::select(-id) %>%
    dplyr::mutate(QIC = round(QIC, 1),
           Delta = round(Delta, 1)) %>% 
    pander::pander(missing = '', caption = stab_qic)

## ----onlineSupplementalTableS2-------------------------------------------
table_distribution(ds, stab_dist)

## ----onlineSupplementalFigureS2, fig.cap=sfig_corr-----------------------
plot_heatmap(ds)

## ----onlineSupplementalFigureS3, fig.cap=sfig_gee------------------------
plot_gee_results(gee_results_unadj)

## ----onlineSupplementalTableS3_4-----------------------------------------
table_gee(gee_results, stab_gee)
table_gee(gee_results_unadj, stab_gee_unadj)

## ----onlineSupplementalFigureS4, fig.cap=sfig_lcmm-----------------------
plot_lcmm_results(lcmm_data)

## ----onlineSupplementalFigureS5, fig.cap=sfig_plsda_groups---------------
plot_plsda_grouping(plsda_results, 'Beta-cell function')

## ----onlineSupplementalFigureS6, fig.cap=sfig_plsda_loadings, fig.width=7, fig.height=7----
plot_plsda_loadings(plsda_results)

## ----onlineSupplementalFigureS7, fig.cap=sfig_plsda_groups_dysgly--------
plot_plsda_grouping(plsda_dysgly, 'Dysglycemia')

## ----onlineSupplementalFigureS8, fig.cap=sfig_plsda_loadings_dysgly, fig.width=7, fig.height=7----
plot_plsda_loadings(plsda_dysgly)

## ----onlineSupplementalFigureS9, fig.cap=sfig_plsda_example--------------
plot_plsda_grouping(example_plsda_results(), 'Example groups')

