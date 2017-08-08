
#' Prepare the data for using in the QIC model comparisons.
#'
#' @param data Project data
#'
prep_qic_data <- function(data) {
    data %>%
        prep_gee_data() %>%
        dplyr::select(
            SID,
            YearsFromBaseline,
            lISSI2,
            lISI,
            TotalNE,
            Sex,
            BiEthnicity,
            MET,
            ALT,
            BaseAge,
            Waist,
            BMI,
            AlcoholPerWk,
            TobaccoUse,
            FamHistDiab,
            BaseTAG,
            MedsLipidsChol
        )
}

#' Clean data output from the QIC model selection functions.
#'
#' @param data QIC output data.
#'
clean_qic <- function(data) {
    data %>%
        tibble::rownames_to_column() %>%
        dplyr::select(Model = rowname, QIC = IC, Delta = delta) %>%
        dplyr::mutate(id = seq_len(nrow(.)))
}

qic_is <- function(data) {
    qic_data <<- data %>%
        prep_qic_data() %>%
        dplyr::select(-lISSI2) %>%
        stats::na.omit()

    M0 <- geepack::geeglm(
        lISI ~ TotalNE + YearsFromBaseline,
        data = qic_data,
        id = SID,
        family = stats::gaussian,
        corstr = 'ar1'
    )

    M1 <- stats::update(M0, . ~ . + TotalNE:YearsFromBaseline)
    M2 <- stats::update(M0, . ~ . + BaseAge + BiEthnicity + Sex)
    M3 <- stats::update(M2, . ~ . + Waist)
    M4 <- stats::update(M3, . ~ . + ALT)
    M5 <- stats::update(M3, . ~ . + MET)
    M6 <- stats::update(M3, . ~ . + AlcoholPerWk)
    M7 <- stats::update(M3, . ~ . + FamHistDiab)
    M8 <- stats::update(M3, . ~ . + TobaccoUse)
    M9 <- stats::update(M3, . ~ . + ALT + MET)
    M10 <- stats::update(M3, . ~ . + MedsLipidsChol)
    M11 <- stats::update(M3, . ~ . + TotalNE:YearsFromBaseline)
    M12 <- stats::update(M9, . ~ . + TotalNE:YearsFromBaseline)

    MuMIn::model.sel(M0, M1, M2, M3, M4, M5, M6, M7, M8, M9, M10, M11, M12,
                     rank = MuMIn::QIC) %>%
        clean_qic()
}

qic_bcf <- function(data) {

    qic_data <<- data %>%
        prep_qic_data() %>%
        dplyr::select(-lISI) %>%
        stats::na.omit()

    M0 <- geepack::geeglm(
        lISSI2 ~ TotalNE + YearsFromBaseline,
        data = qic_data,
        id = SID,
        family = stats::gaussian,
        corstr = 'ar1'
    )

    M1 <- stats::update(M0, . ~ . + TotalNE:YearsFromBaseline)
    M2 <- stats::update(M0, . ~ . + BaseAge + BiEthnicity + Sex)
    M3 <- stats::update(M2, . ~ . + Waist)
    M4 <- stats::update(M3, . ~ . + ALT)
    M5 <- stats::update(M3, . ~ . + MET)
    M6 <- stats::update(M3, . ~ . + AlcoholPerWk)
    M7 <- stats::update(M3, . ~ . + FamHistDiab)
    M8 <- stats::update(M3, . ~ . + TobaccoUse)
    M9 <- stats::update(M3, . ~ . + ALT + MET)
    M10 <- stats::update(M3, . ~ . + MedsLipidsChol)
    M11 <- stats::update(M3, . ~ . + TotalNE:YearsFromBaseline)
    M12 <- stats::update(M9, . ~ . + TotalNE:YearsFromBaseline)

    MuMIn::model.sel(M0, M1, M2, M3, M4, M5, M6, M7, M8, M9, M10, M11, M12,
                     rank = MuMIn::QIC) %>%
        clean_qic()
}

#' Combine together the QIC datasets.
#'
analyze_qic <- function() {
    qic_is_data <- project_data %>%
        qic_is() %>%
        dplyr::bind_rows(tibble::data_frame(Model = '**log(ISI)**', id = 0.5))

    qic_bcf_data <- project_data %>%
        qic_bcf() %>%
        dplyr::bind_rows(tibble::data_frame(Model = '**log(ISSI-2)**', id = 0.5)) %>%
        dplyr::mutate(id = max(id) + id)

    dplyr::bind_rows(qic_is_data, qic_bcf_data)
}

#' Create a table of the QIC from the QIC cleaned output.
#'
#' @param data Cleaned QIC output.
#' @param caption Table caption.
#'
table_qic <- function(data, caption = NULL) {
    data %>%
        dplyr::arrange(id) %>%
        dplyr::select(-id) %>%
        dplyr::mutate(QIC = precise_rounding(QIC, 1),
                      QIC = ifelse(QIC == "NA", NA, QIC),
                      Delta = precise_rounding(Delta, 1),
                      Delta = ifelse(Delta == "NA", NA, Delta)) %>%
        pander::pandoc.table(missing = '', caption = caption,
                             justify = c("left", "right", "right"))
}
