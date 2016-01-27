#' Fetch data from the master dataset.
#'
#' This function fetchs the main dataset, keeps variables relevant to
#' the analysis, restrict the sample size as needed, and lastly save
#' the new dataset as an `.RData` file. The dot in front of the function hides
#' it from the global environment.
#'
.fetch_data <- function(master.dataset) {
    # Load the master dataset,
    ds.prep <- read.table(master.dataset,
                          header = TRUE, na = "",
                          sep = ",") %>%
        filter(VN %in% c(1, 3, 6)) %>%
        ## Kick out Canoers
        filter(is.na(Canoe)) %>%
        tbl_df()

    print(paste0('Original dataset rows are ', dim(ds.prep)[1], ' and columns are ', dim(ds.prep)[2]))

    ##' Munge and wrangle the data into the final version.
    ds <-
        full_join(ds.prep,
                  ds.prep %>%
                      filter(VN == 1) %>%
                      select(SID, BaseAge = Age)) %>%
        select(
            SID, VN, BMI, Waist, HOMA, ISI, IGIIR, ISSI2, TAG, LDL, HDL, Chol,
            ALT, CRP, FamHistDiab, matches('meds'), Age, Sex, Ethnicity,
            IFG, IGT, DM, MET, BaseAge, AlcoholPerWk, TobaccoUse, SelfEdu, Occupation
        ) %>%
        mutate(
            FamHistDiab =
                plyr::mapvalues(FamHistDiab, c(0, 1:12),
                                c('No', rep('Yes', 12))) %>%
                as.factor(),
            invHOMA = (1 / HOMA),
            linvHOMA = log(invHOMA),
            lISI = log(ISI),
            lIGIIR = log(IGIIR),
            lISSI2 = log(ISSI2),
            MedsLipidsChol = ifelse(is.na(MedsLipidsChol), 0, MedsLipidsChol)
        ) %>%
        full_join(
            .,
            ## Merge in the FA dataset so it is time-independent.
            full_join(
                ds.prep %>%
                    filter(VN == 1) %>%
                    select(SID, totalNE, matches('^ne\\d+')) %>%
                    filter(complete.cases(.)),
                ## Create percent of total fatty acid values.
                ds.prep %>%
                    filter(VN == 1) %>%
                    select(SID, totalNE, matches('^ne\\d+')) %>%
                    gather(Total, TotConc, totalNE) %>%
                    gather(Fat, FatConc,-SID,-Total,-TotConc) %>%
                    mutate(
                        Total = gsub('total', '', Total),
                        FatPool = toupper(gsub('\\d.*$', '', Fat)) %>% factor(),
                        Pct = (FatConc / TotConc) * 100,
                        Fat = gsub('^', 'pct_', Fat)
                    ) %>%
                    filter(complete.cases(.), Total == FatPool) %>%
                    select(SID, Fat, Pct) %>%
                    spread(Fat, Pct)
            ),
            by = 'SID'
        ) %>%
        mutate(
            VN = plyr::mapvalues(VN, c(1, 3, 6), c(0, 1, 2)),
            f.VN = factor(VN, c(0, 1, 2), c('yr0', 'yr3', 'yr6')),
            Dysgly = plyr::mapvalues(as.character(IFG + IGT + DM), c('0', '1'), c('No', 'Yes')),
            Sex = plyr::mapvalues(Sex, c('F', 'M'), c('Female', 'Male')),
            Ethnicity =
                plyr::mapvalues(
                    Ethnicity,
                    c(
                        'African', 'European', 'First Nations',
                        'Latino/a', 'Other', 'South Asian'
                    ),
                    c('Other', 'European', 'Other', 'Latino/a',
                      'Other', 'South Asian')
                )
        ) %>%
        select(
            SID, VN, ne_Total = totalNE,
            matches('(pct_ne|^ne).*0$'),
            matches('(pct_ne|^ne).*n9'),
            matches('(pct_ne|^ne).*n7'),
            matches('(pct_ne|^ne).*n6'),
            matches('(pct_ne|^ne).*n3'),
            everything()
        ) %>%
        arrange(SID, VN)

    print(paste0('Working dataset rows are ', dim(ds)[1], ' and columns are ', dim(ds)[2]))

    # There are no duplicate rows
    if(any(duplicated(ds[c('SID', 'VN')])))
        message('There are duplicate values.')

    # Final dataset object
    # Save the dataset as an RData file.
    save(ds, file = file.path('data', 'ds.RData'))
}
