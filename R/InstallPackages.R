load_packages <- function(packages) {
  for (package in packages) {
    if (!(package %in% rownames(installed.packages()))) {
      install.packages(package)
    }
    library(package, character.only = TRUE)
  }
}

load_packages(
  c(
    "boot",
    "car",
    "dplyr",
    "effectsize",
    "ggplot2",
    "ggpubr",
    "gridExtra",
    "Hmisc",
    "kableExtra",
    "knitr",
    "lmtest",
    "lsr",
    "magrittr",
#    "MASS",
    "moments",
    "parameters",
    "pROC",
    "psych",
    "pwr",
    "readr",
    "RVAideMemoire",
    "sandwich",
    "skimr",
    "stringr",
    "tibble",
    "tidyr",
    "tidyverse",
    "WRS2"
  )
)
