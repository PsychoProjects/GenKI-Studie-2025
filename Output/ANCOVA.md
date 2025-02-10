
> source("InstallPackages.R")

> source("Read_Data.R")
[1] "Daten werden geladen..."

> # Standard-ANCOVA
> ## ANCOVA-Modell erstellen mit 'Akzeptanz' als abhängige Variable, Anwendungsfeld, Vertrauensmassnahmen und Kovariate
> ancova_model <- aov(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI, data = daten) 

> ## Koeefizienten des Modells ausgeben
> coef_df <- coef(ancova_model)

> kable(coef_df, digits = 2, caption = "ANCOVA Koeffizienten")


Table: ANCOVA Koeffizienten

|                                                         |     x|
|:--------------------------------------------------------|-----:|
|(Intercept)                                              |  1.58|
|AnwendungsfeldSubjektiv                                  | -1.20|
|VertrauensmassnahmenMit Maßnahme                         |  0.00|
|Einstellung_KI                                           |  0.61|
|AnwendungsfeldSubjektiv:VertrauensmassnahmenMit Maßnahme | -0.03|

> ## Zusammenfassung des Modells 
> mp <- model_parameters(ancova_model, eta_squared = "partial")

> kable(mp, digits = 2, caption = "Zusammenfassung des ANCOVA-Modells")


Table: Zusammenfassung des ANCOVA-Modells

|Parameter                           | Sum_Squares|  df| Mean_Square|      F|    p|
|:-----------------------------------|-----------:|---:|-----------:|------:|----:|
|Anwendungsfeld                      |      137.15|   1|      137.15| 210.58| 0.00|
|Vertrauensmassnahmen                |        0.30|   1|        0.30|   0.47| 0.50|
|Einstellung_KI                      |       54.83|   1|       54.83|  84.18| 0.00|
|Anwendungsfeld:Vertrauensmassnahmen |        0.02|   1|        0.02|   0.03| 0.87|
|Residuals                           |      240.99| 370|        0.65|     NA|   NA|

> ## Effektgrößen 
> eff_es <- eta_squared(ancova_model, partial = TRUE)

> kable(eff_es, digits = 2, caption = "Effektgrößen der ANCOVA")


Table: Effektgrößen der ANCOVA

|Parameter                           | Eta2_partial|   CI| CI_low| CI_high|
|:-----------------------------------|------------:|----:|------:|-------:|
|Anwendungsfeld                      |         0.36| 0.95|   0.30|       1|
|Vertrauensmassnahmen                |         0.00| 0.95|   0.00|       1|
|Einstellung_KI                      |         0.19| 0.95|   0.13|       1|
|Anwendungsfeld:Vertrauensmassnahmen |         0.00| 0.95|   0.00|       1|

> # Robuste ANCOVA mit heteroskedastizitätsrobusten Standardfehlern (HC3)
> robust_ancova <- lm(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI, data = daten)

> anova_robust <- car::Anova(robust_ancova, type = "III", white.adjust = TRUE)

> ## Zusammenfassung des Modells 
> mpr <- model_parameters(robust_ancova, eta_squared = "partial")

> kable(mpr, digits = 2, caption = "Zusammenfassung des robusten ANCOVA-Modells")


Table: Zusammenfassung des robusten ANCOVA-Modells

|Parameter                                                | Coefficient|   SE|   CI| CI_low| CI_high|      t| df_error|    p|
|:--------------------------------------------------------|-----------:|----:|----:|------:|-------:|------:|--------:|----:|
|(Intercept)                                              |        1.58| 0.26| 0.95|   1.07|    2.08|   6.18|      370| 0.00|
|AnwendungsfeldSubjektiv                                  |       -1.20| 0.12| 0.95|  -1.43|   -0.97| -10.19|      370| 0.00|
|VertrauensmassnahmenMit Maßnahme                         |        0.00| 0.12| 0.95|  -0.23|    0.23|   0.02|      370| 0.98|
|Einstellung_KI                                           |        0.61| 0.07| 0.95|   0.48|    0.75|   9.17|      370| 0.00|
|AnwendungsfeldSubjektiv:VertrauensmassnahmenMit Maßnahme |       -0.03| 0.17| 0.95|  -0.36|    0.30|  -0.17|      370| 0.87|

> ## Effektgrößen
> eff_esr <- eta_squared(robust_ancova, partial = TRUE)

> kable(eff_esr, digits = 2, caption = "Effektgrößen der robusten ANCOVA")


Table: Effektgrößen der robusten ANCOVA

|Parameter                           | Eta2_partial|   CI| CI_low| CI_high|
|:-----------------------------------|------------:|----:|------:|-------:|
|Anwendungsfeld                      |         0.36| 0.95|   0.30|       1|
|Vertrauensmassnahmen                |         0.00| 0.95|   0.00|       1|
|Einstellung_KI                      |         0.19| 0.95|   0.13|       1|
|Anwendungsfeld:Vertrauensmassnahmen |         0.00| 0.95|   0.00|       1|

> # Bootstrapping
> ## Funktion für das Bootstrapping der ANCOVA-Koeffizienten
> boot_ancova <- function(data, indices) {
+   sampled_data <- data[indices, ]  # Ziehe Bootstrap-Stichprobe
+   model <- lm(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI, data = sampled_data)
+   return(coef(model))  # Rückgabe der Koeffizienten
+ }

> ## Bootstrapping mit 1000 Wiederholungen
> set.seed(123)  # Für Reproduzierbarkeit

> boot_results <- boot(data = daten, statistic = boot_ancova, R = 1000)

> ## Ausgabe der Bootstrapped-Konfidenzintervalle
> print(boot.ci(boot_results, type = "perc"))
BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
Based on 1000 bootstrap replicates

CALL : 
boot.ci(boot.out = boot_results, type = "perc")

Intervals : 
Level     Percentile     
95%   ( 1.103,  2.080 )  
Calculations and Intervals on Original Scale

> ## Prädiktornamen aus dem Modell extrahieren
> predictor_names <- names(coef(lm(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI, data = daten)))

> ## Ausgabe der Bootstrapped-Konfidenzintervalle für alle Prädiktoren mit Namen
> boot_ci_results <- lapply(1:length(boot_results$t0), function(i) {
+   ci <- boot.ci(boot_results, type = "perc", index = i)
+   list(
+     Prädiktor = predictor_names[i],
+     Untergrenze = ci$percent[4],
+     Obergrenze = ci$percent[5]
+   )
+ })

> ## Konfidenzintervalle anzeigen
> boot_ci_df <- do.call(rbind, lapply(boot_ci_results, as.data.frame))

> kable(boot_ci_df, digits = 2, caption = "Bootstrapped Konfidenzintervalle")


Table: Bootstrapped Konfidenzintervalle

|Prädiktor                                                | Untergrenze| Obergrenze|
|:--------------------------------------------------------|-----------:|----------:|
|(Intercept)                                              |        1.10|       2.08|
|AnwendungsfeldSubjektiv                                  |       -1.44|      -1.00|
|VertrauensmassnahmenMit Maßnahme                         |       -0.18|       0.18|
|Einstellung_KI                                           |        0.48|       0.74|
|AnwendungsfeldSubjektiv:VertrauensmassnahmenMit Maßnahme |       -0.37|       0.32|

> ## Visualisierung der Bootstrap-Schätzwerte
> hist(boot_results$t[, 2], main = "Bootstrap-Verteilung für Anwendungsfeld", xlab = "Koeffizient", col = "lightblue", border = "black")

> # Prüfung der Voraussetzungen für die ANCOVA
> ## Normalverteilung der Residuen prüfen
> shapiro.test(residuals(ancova_model))

	Shapiro-Wilk normality test

data:  residuals(ancova_model)
W = 0.99308, p-value = 0.0821


> ## QQ-Plot der Residuen
> ggqqplot(
+   residuals(ancova_model), 
+      conf.int = TRUE, 
+      conf.int.fill = "lightgray",
+   ) +
+   theme(
+     axis.title.x = element_text(size = 24),  
+     axis.title.y = element_text(size = 24),  
+     axis.text = element_text(size = 20)      
+   ) +
+   labs(
+     title = "QQ-Plot der Residuen", 
+     x = "Theoretische Quantile", 
+     y = "Residuen"
+   )

> ## Homogenität der Varianzen prüfen
> leveneTest(residuals(ancova_model) ~ Anwendungsfeld * Vertrauensmassnahmen, data = daten)
Levene's Test for Homogeneity of Variance (center = median)
       Df F value    Pr(>F)    
group   3  11.363 3.804e-07 ***
      371                      
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
