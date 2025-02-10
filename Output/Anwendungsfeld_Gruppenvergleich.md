
> source("InstallPackages.R")

> source("Read_Data.R")
[1] "Daten werden geladen..."

> # cohen's d für Anwendungsfeld (Paket lsr)
> cohensD(Akzeptanz ~ Anwendungsfeld, data = daten)
[1] 1.357685

> # Cohens's d mit Bootstrapping absichern
> ## Funktion zur Berechnung von Cohen's d für Bootstrapping
> cohens_d_boot <- function(data, indices) {
+   sample_data <- data[indices, ]  # Bootstrap-Stichprobe
+   
+   d_value <- cohensD(Akzeptanz ~ Anwendungsfeld, data = sample_data)
+   
+   return(d_value)
+ }

> ## Bootstrapping mit 1000 Wiederholungen
> set.seed(123)  

> boot_results <- boot(data = daten, statistic = cohens_d_boot, R = 1000)

> ## Konfidenzintervall berechnen
> ci <- boot.ci(boot_results, type = "perc")

> tibble(
+   Cohens_d = boot_results$t0,
+   CI_lower = ci$percent[4],
+   CI_upper = ci$percent[5]
+ ) %>% kable(digits = 2, caption = "Bootstrapped Cohen's d für Anwendungsfeld")


Table: Bootstrapped Cohen's d für Anwendungsfeld

| Cohens_d| CI_lower| CI_upper|
|--------:|--------:|--------:|
|     1.36|     1.13|     1.62|
