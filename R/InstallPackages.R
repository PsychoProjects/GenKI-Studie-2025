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
    "boot",       # boot(), boot.ci() 
    "car",        # Anova() 
    "dplyr", 
    "effectsize", # eta_squared() 
    "ggplot2", 
    "ggpubr",
    "kableExtra",
    "knitr",
    "lmtest",     # bptest() 
    "lsr",        # CohensD
    "magrittr", 
    "moments",    # skewness(), kurtosis()
    "parameters", # model_parameters() 
    "psych",      # alpha()
    "pwr",        # pwr.anova.test() 
    "readr", 
    "sandwich",   # vcovHC() 
    "skimr",      # skim() 
    "stringr", 
    "tibble", 
    "tidyr", 
    "tidyverse"
  )
)

