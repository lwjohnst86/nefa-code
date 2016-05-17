#' Code preamble
#' =============
#'
#' Install packages if they are not installed and load them. Set options for
#' the packages.
#'
run_setup <- function() {
    # Run the following packages for setup
    .load_packages()
    .set_options()
    .load_packages()
    .load_packages()
}

.load_packages <- function() {
    # May need to run this function another time if a package needs to be
    # installed.
    #
    # Add your packages you want to use here, using the following format:
    # - For pre-bundled packages

    # - For CRAN packages:
    # if (!require(package)) install.packages('package')
    if (!require(lcmm)) install.packages('lcmm')
    if (!require(caret)) install.packages('caret')
    if (!require(fdrtool)) install.packages('fdrtool')
    if (!require(captioner)) install.packages('captioner')
    if (!require(tidyr)) install.packages('tidyr')
    if (!require(ggplot2)) install.packages('ggplot2')
    if (!require(pander)) install.packages('pander')
    if (!require(knitr)) install.packages('knitr')
    if (!require(DiagrammeR)) install.packages('DiagrammeR')
    if (!require(MuMIn)) install.packages('MuMIn')
    if (!require(geepack)) install.packages('geepack')
    if (!require(magrittr)) install.packages('magrittr')
    if (!require(dplyr)) install.packages('dplyr')
    # - For github packages:
    # if (!require(package)) packrat::install_github('username/package')

    # How to manage local? Not sure.
    library(carpenter)
    library(mason)
    library(seer)
}

.set_options <- function() {
    # Set the options here for individual packages

    # For tables (pander)
    panderOptions('table.split.table', Inf)
    panderOptions('table.style', 'rmarkdown')
    panderOptions('table.alignment.default',
                  function(df)
                      ifelse(sapply(df, is.numeric), 'center', 'left'))

    # For the document (knitr)
    knitr::opts_chunk$set(
        warning = FALSE, message = FALSE, collapse = TRUE,
        fig.showtext = TRUE
    )
}

