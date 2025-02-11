
> source("InstallPackages.R")

> source("Read_Data.R")
[1] "Daten werden geladen..."

> # Prüfung der 4. Hypothese
> ## Hilfsunktionen für das Bootstrapping
> ### Funktion zur Berechnung von Spearman’s Rho mit Bootstrapping für das Konfidenzintervall
> spearman_boot <- function(data, indices) {
+   sample_data <- data[indices, ]  ## Bootstrap-Stichprobe
+   return(cor(sample_data$Einstellung_KI, sample_data$Akzeptanz, method = "spearman"))
+ }

> ### Funktion zur Berechnung des p-Werts mit cor.test()
> compute_p_value <- function(data) {
+   test <- cor.test(data$Einstellung_KI, data$Akzeptanz, method = "spearman", exact = FALSE)
+   return(test$p.value)
+ }

> ## Bootstrapping für Gesamt, Objektiv und Subjektiv
> set.seed(123)  ## Reproduzierbarkeit

> boot_overall <- boot(data = daten, statistic = spearman_boot, R = 1000)

> boot_objektiv <- boot(data = daten %>% filter(Anwendungsfeld == "Objektiv"), statistic = spearman_boot, R = 1000)

> boot_subjektiv <- boot(data = daten %>% filter(Anwendungsfeld == "Subjektiv"), statistic = spearman_boot, R = 1000)

> ## Aufbereitung der Ergebnisse
> ### Konfidenzintervalle berechnen
> ci_overall <- boot.ci(boot_overall, type = "perc")$percent[4:5]

> ci_objektiv <- boot.ci(boot_objektiv, type = "perc")$percent[4:5]

> ci_subjektiv <- boot.ci(boot_subjektiv, type = "perc")$percent[4:5]

> ### Freiheitsgrade berechnen
> df_overall <- nrow(daten) - 2

> df_objektiv <- nrow(daten %>% filter(Anwendungsfeld == "Objektiv")) - 2

> df_subjektiv <- nrow(daten %>% filter(Anwendungsfeld == "Subjektiv")) - 2

> ### p-Werte berechnen
> p_values <- c(
+   compute_p_value(daten),
+   compute_p_value(daten %>% filter(Anwendungsfeld == "Objektiv")),
+   compute_p_value(daten %>% filter(Anwendungsfeld == "Subjektiv"))
+ )

> ## Ergebnisse
> cor_results <- data.frame(
+   Gruppe = c("Gesamt", "Objektiv", "Subjektiv"),
+   df = c(df_overall, df_objektiv, df_subjektiv),
+   rho = c(boot_overall$t0, boot_objektiv$t0, boot_subjektiv$t0),
+   CI_unter = c(ci_overall[1], ci_objektiv[1], ci_subjektiv[1]),
+   CI_ober = c(ci_overall[2], ci_objektiv[2], ci_subjektiv[2]),
+   p_Wert = p_values
+ )

> kable(cor_results, digits = 2, 
+       caption = "Bootstrapped Spearman's Rho-Korrelation zwischen Akzeptanz und Einstellung_KI")


Table: Bootstrapped Spearman's Rho-Korrelation zwischen Akzeptanz und Einstellung_KI

|Gruppe    |  df|  rho| CI_unter| CI_ober| p_Wert|
|:---------|---:|----:|--------:|-------:|------:|
|Gesamt    | 373| 0.34|     0.25|    0.43|      0|
|Objektiv  | 189| 0.53|     0.41|    0.65|      0|
|Subjektiv | 182| 0.31|     0.16|    0.45|      0|
