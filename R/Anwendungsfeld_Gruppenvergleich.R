source("InstallPackages.R")
source("Read_Data.R")

# cohen's d für Anwendungsfeld (Paket lsr)
cohensD(Akzeptanz ~ Anwendungsfeld, data = daten)

# Cohens's d mit Bootstrapping absichern
## Funktion zur Berechnung von Cohen's d für Bootstrapping
cohens_d_boot <- function(data, indices) {
  sample_data <- data[indices, ]

  d_value <- cohensD(Akzeptanz ~ Anwendungsfeld, data = sample_data)

  return(d_value)
}

## Bootstrapping mit 1000 Wiederholungen
set.seed(123)  # Zwecks Reproduzierbarkeit
boot_results <- boot(data = daten, statistic = cohens_d_boot, R = 1000)

## Konfidenzintervall berechnen
ci <- boot.ci(boot_results, type = "perc")

tibble(
  Cohens_d = boot_results$t0,
  CI_lower = ci$percent[4],
  CI_upper = ci$percent[5]
) %>% kable(digits = 2, caption = "Bootstrapped Cohen's d für Anwendungsfeld")