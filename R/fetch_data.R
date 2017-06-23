#' Fetch data from the original source
#'
#' This function fetchs the main dataset, keeps variables relevant to
#' the analysis, restrict the sample size as needed, and lastly save
#' the new dataset as an `.RData` file.
#'
#' @return Saves the wrangled data into the data/ folder.
#'
fetch_data <- function() {
    # Load the master dataset,
    ds.prep <- PROMISE::PROMISE %>%
        dplyr::filter(VN %in% c(1, 3, 6)) %>%
        ## Kick out Canoers
        dplyr::filter(is.na(Canoe)) %>%
        dplyr::tbl_df()

    print(paste0('Original dataset rows are ', dim(ds.prep)[1], ' and columns are ', dim(ds.prep)[2]))

    ##' Munge and wrangle the data into the final version.
    ds <- ds.prep %>%
        dplyr::select(
            SID, VN, BMI, Waist, HOMA, ISI, IGIIR, ISSI2, TAG, LDL, HDL, Chol,
            ALT, CRP, FamHistDiab, dplyr::matches('meds'), Age, Sex, Ethnicity,
            IFG, IGT, DM, MET, Age, AlcoholPerWk, TobaccoUse, SelfEdu, Occupation,
            TotalNE, dplyr::matches('^ne\\d+'), Glucose0, Glucose120, TAG,
            MonthsFromBaseline, dplyr::matches("HOMA")
        ) %>%
        dplyr::mutate(
            YearsFromBaseline = MonthsFromBaseline / 12,
            FamHistDiab =
                plyr::mapvalues(FamHistDiab, c(0, 1:12),
                                c('No', rep('Yes', 12))) %>%
                as.factor(),
            BaseTotalNE = TotalNE,
            BaseTAG = ifelse(VN == 1, TAG, NA),
            lBaseTAG = log(BaseTAG),
            BaseAge = ifelse(VN == 1, Age, NA),
            invHOMA = (1 / HOMA),
            linvHOMA = log(invHOMA),
            lHOMA2IR = log(HOMA2IR),
            lHOMA2_S = log(HOMA2_S),
            lISI = log(ISI),
            lIGIIR = log(IGIIR),
            lISSI2 = log(ISSI2),
            lALT = log(ALT),
            lTAG = log(TAG),
            MedsLipidsChol = ifelse(is.na(MedsLipidsChol), 0, MedsLipidsChol)
        ) %>%
        dplyr::arrange(SID, VN) %>%
        dplyr::group_by(SID) %>%
        tidyr::fill(TotalNE, dplyr::matches('^ne\\d+'), BaseTAG, BaseAge) %>%
        dplyr::ungroup()

    ds <- ds %>%
        dplyr::full_join(ds %>%
                      dplyr::filter(VN == 1) %>%
                      dplyr::select(SID, TotalNE, dplyr::matches('^ne\\d+')) %>%
                      dplyr::mutate_at(dplyr::vars(dplyr::matches('^ne\\d+')),
                                       dplyr::funs((. / TotalNE) * 100)) %>%
                      dplyr::select(-TotalNE) %>%
                      stats::setNames(paste0('pct_', names(.))) %>%
                      dplyr::rename(SID = pct_SID),
                  by = 'SID')

    ds <- ds %>%
        dplyr::mutate(
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
        dplyr::arrange(SID, VN) %>%
        dplyr::filter(!is.na(TotalNE))

    print(paste0('Working dataset rows are ', dim(ds)[1], ' and columns are ', dim(ds)[2]))

    # There are no duplicate rows
    if (any(duplicated(ds[c('SID', 'VN')])))
        message('There are duplicate values.')

    # Final dataset object
    project_data <- ds

    # Save the dataset to the data/ folder.
    devtools::use_data(project_data, overwrite = TRUE)
}
