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
    "gridExtra",
    "Hmisc",
    "kableExtra",
    "knitr",
    "lmtest",
    "magrittr", 
    "pROC",
    "psych",
    "pwr",
    "readr",
    "skimr",
    "stringr",
    "tibble",
    "tidyr",
    "tidyverse",
    "WRS2"
  )
)
