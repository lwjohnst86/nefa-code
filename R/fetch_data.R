#' Fetch data from the master dataset.
#'
#' This function fetchs the main dataset, keeps variables relevant to
#' the analysis, restrict the sample size as needed, and lastly save
#' the new dataset as an `.RData` file. The dot in front of the function hides
#' it from the global environment.
#'
.fetch_data <- function() {
    # Load the master dataset,
    ds.prep <- PROMISE::PROMISE_data %>%
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
                      select(SID, BaseAge = Age, BaseTAG = TAG)) %>%
        select(
            SID, VN, BMI, Waist, HOMA, ISI, IGIIR, ISSI2, TAG, LDL, HDL, Chol,
            ALT, CRP, FamHistDiab, matches('meds'), Age, Sex, Ethnicity,
            IFG, IGT, DM, MET, BaseAge, AlcoholPerWk, TobaccoUse, SelfEdu, Occupation,
            TotalNE, matches('^ne\\d+'), Glucose0, Glucose120, BaseTAG
        ) %>%
        mutate(
            BaseTotalNE = TotalNE,
            FamHistDiab =
                plyr::mapvalues(FamHistDiab, c(0, 1:12),
                                c('No', rep('Yes', 12))) %>%
                as.factor(),
            invHOMA = (1 / HOMA),
            linvHOMA = log(invHOMA),
            lISI = log(ISI),
            lIGIIR = log(IGIIR),
            lISSI2 = log(ISSI2),
            lALT = log(ALT),
            lTAG = log(TAG),
            MedsLipidsChol = ifelse(is.na(MedsLipidsChol), 0, MedsLipidsChol)
        ) %>%
        arrange(SID, VN) %>%
        group_by(SID) %>%
        fill(TotalNE, matches('^ne\\d+')) %>%
        ungroup()

    ds <- ds %>%
        full_join(ds %>%
                      filter(VN == 1) %>%
                      select(SID, TotalNE, matches('^ne\\d+')) %>%
                      mutate_each(funs((. / TotalNE) * 100), matches('^ne\\d+')) %>%
                      select(-TotalNE) %>%
                      setNames(paste0('pct_', names(.))) %>%
                      rename(SID = pct_SID),
                  by = 'SID')

        # full_join(
        #     .,
        #     ## Merge in the FA dataset so it is time-independent.
        #     full_join(
        #         ds.prep %>%
        #             filter(VN == 1) %>%
        #             select(SID, TotalNE, matches('^ne\\d+')) %>%
        #             filter(complete.cases(.)),
        #         ## Create percent of total fatty acid values.
        #         ds.prep %>%
        #             dplyr::filter(VN == 1, !is.na(TotalNE)) %>%
        #             dplyr::select(SID, TotalNE, matches('^ne\\d+')) %>%
        #             tidyr::gather(Fat, FatConc,-SID,-TotalNE) %>%
        #             dplyr::mutate(
        #                 Pct = (FatConc / TotalNE) * 100,
        #                 Fat = gsub('^', 'pct_', Fat)
        #             ) %>%
        #             dplyr::filter(complete.cases(.)) %>%
        #             dplyr::select(SID, Fat, Pct) %>%
        #             tidyr::spread(Fat, Pct)
        #     ),
        #     by = 'SID'
        # ) %>%
    ds <- ds %>%
        mutate(
            VN = plyr::mapvalues(VN, c(1, 3, 6), c(0, 1, 2)),
            f.VN = factor(VN, c(0, 1, 2), c('yr0', 'yr3', 'yr6')),
            Dysgly = plyr::mapvalues(as.character(IFG + IGT + DM), c('0', '1'), c('No', 'Yes')),
            Ethnicity =
                plyr::mapvalues(
                    Ethnicity,
                    c(
                        'African',
                        'European',
                        'First Nations',
                        'Latino/a',
                        'Other',
                        'South Asian'
                    ),
                    c('Other', 'European', 'Other', 'Latino/a',
                      'Other', 'South Asian')
                )
        ) %>%
        arrange(SID, VN) %>%
        filter(!is.na(TotalNE))

    print(paste0('Working dataset rows are ', dim(ds)[1], ' and columns are ', dim(ds)[2]))

    # There are no duplicate rows
    if(any(duplicated(ds[c('SID', 'VN')])))
        message('There are duplicate values.')

    # Final dataset object
    # Save the dataset as an RData file.
    saveRDS(ds, file = file.path('data', 'data.Rds'))
}
