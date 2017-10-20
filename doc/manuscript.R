## ----setup, include=FALSE------------------------------------------------
devtools::load_all('.')
set_options()

## ----captions------------------------------------------------------------
## Include captions below using `captioner` package
library(captioner)
fig <- captioner(prefix = 'Fig.')
cite_f <- pryr::partial(fig, display = 'cite')
sfig <- captioner(prefix = 'ESM Fig.')
cite_sf <- pryr::partial(sfig, display = 'cite')
tab <- captioner(prefix = 'Table')
cite_t <- pryr::partial(tab, display = 'cite')
stab <- captioner(prefix = 'ESM Table')
cite_st <- pryr::partial(stab, display = 'cite')

tab_basic <- tab('basic', 'Basic characteristics of the PROMISE participants at each of the three clinic visits.')
fig_dist <- fig('nefa', 'Concentrations (nmol/ml) of each NEFA in PROMISE participants at the baseline visit (2004-2006).')
fig_gee_unadj <- fig('gee_unadj', 'Longitudinal associations of individual non-esterified fatty acids (mol% and nmol/ml) with insulin sensitivity and beta cell function over 6 years in the PROMISE cohort. Models are only adjusted for time. X-axis values represent a percent difference in the outcome per SD increase in the fatty acid. P-values were adjusted for the BH false discovery rate (FDR), with each increase in dot size and blackness representing a p-value significance of p>0.05, p<0.05, p<0.01, and p<0.001.')
fig_gee_adj <- fig('gee_adj', 'Longitudinal associations of individual non-esterified fatty acids (mol% and nmol/ml) with insulin sensitivity and beta cell function over the 6 years in the PROMISE cohort. Generalized estimating equation models were fully adjusted. X-axis values represent a percent difference in the outcome per SD increase in the fatty acid. P-values were adjusted for the BH false discovery rate (FDR), with each increase in dot size and blackness representing a p-value significance of p>0.05, p<0.05, and p<0.01.')

## ----inline_results------------------------------------------------------
nefa <- calc_pct_nefa(project_data)
chg_outcomes <- calc_outcomes_chg_n(project_data)

ds0yr <- dplyr::filter(project_data, VN == 0)
female <- calc_npercent(ds0yr$Sex, 'Female')
european <- calc_npercent(ds0yr$Ethnicity, 'European')
famhist <- calc_npercent(ds0yr$FamHistDiab, 'Yes')
est_gee <- gee_results %>% 
    dplyr::filter(model == "Adjusted") %>% 
    calc_gee_magnitude()

meds_use <- table(project_data$MedsLipidsChol, project_data$VN)[2, c(1, 3)]

sig_fa_unadj <- gee_results %>% 
    dplyr::filter(model == "Unadjusted", p.value < 0.05) %>% 
    dplyr::select(Yterms, Xterms, unit) %>% 
    dplyr::mutate(Xterms = ifelse(Xterms == "Total", "total NEFA", as.character(Xterms)))
sig_fa_adj <- gee_results %>% 
    dplyr::filter(model == "Adjusted", p.value < 0.05) %>% 
    dplyr::select(Yterms, Xterms, unit) %>% 
    dplyr::mutate(Xterms = ifelse(Xterms == "Total", "total NEFA", as.character(Xterms)))

dm_each_visit <- calc_dm_each_visit()

## ----table1_basic--------------------------------------------------------
table_basic(project_data, caption = tab_basic)

## ----figure1_nefa, fig.cap=fig_dist--------------------------------------
plot_nefa_distribution()

## ----figure2_gee_unadj, fig.cap=fig_gee_unadj----------------------------
gee_results %>% 
    dplyr::filter(model == "Unadjusted") %>% 
    dplyr::mutate(unit = ifelse(unit == "Total", " ", unit)) %>% 
    plot_gee_main()

## ----figure3_gee_adj, fig.cap=fig_gee_adj--------------------------------
gee_results %>% 
    dplyr::filter(model == "Adjusted") %>% 
    dplyr::mutate(unit = ifelse(unit == "Total", " ", unit)) %>% 
    plot_gee_main()

