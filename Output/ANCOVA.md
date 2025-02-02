
> source("InstallPackages.R")

> source("Read_Data.R")
[1] "Daten werden geladen..."

> ### Standard-ANCOVA
> # ANCOVA-Modell erstellen mit 'Akzeptanz' als abhängige Variable, Anwendungsfeld, Vertrauensmassnahmen und Kovariate
> ancova_model <- aov(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI, data = daten) 

> # Zusammenfassung des Modells 
> model_parameters(ancova_model, eta_squared = "partial")
Parameter                           | Sum_Squares |  df | Mean_Square |      F |      p
---------------------------------------------------------------------------------------
Anwendungsfeld                      |      137.15 |   1 |      137.15 | 210.58 | < .001
Vertrauensmassnahmen                |        0.30 |   1 |        0.30 |   0.47 | 0.496 
Einstellung_KI                      |       54.83 |   1 |       54.83 |  84.18 | < .001
Anwendungsfeld:Vertrauensmassnahmen |        0.02 |   1 |        0.02 |   0.03 | 0.869 
Residuals                           |      240.99 | 370 |        0.65 |        |       

Anova Table (Type 1 tests)

> # Effektgrößen 
> eta_squared(ancova_model, partial = TRUE)
# Effect Size for ANOVA (Type I)

Parameter                           | Eta2 (partial) |       95% CI
-------------------------------------------------------------------
Anwendungsfeld                      |           0.36 | [0.30, 1.00]
Vertrauensmassnahmen                |       1.26e-03 | [0.00, 1.00]
Einstellung_KI                      |           0.19 | [0.13, 1.00]
Anwendungsfeld:Vertrauensmassnahmen |       7.41e-05 | [0.00, 1.00]

- One-sided CIs: upper bound fixed at [1.00].
> ### Robuste ANCOVA mit heteroskedastizitätsrobusten Standardfehlern (HC3)
> robust_ancova <- lm(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI, data = daten)

> anova_robust <- car::Anova(robust_ancova, type = "III", white.adjust = TRUE)

> # Zusammenfassung des Modells 
> model_parameters(robust_ancova, eta_squared = "partial")
Parameter                                                        | Coefficient |   SE |         95% CI | t(370) |      p
------------------------------------------------------------------------------------------------------------------------
(Intercept)                                                      |        1.58 | 0.26 | [ 1.07,  2.08] |   6.18 | < .001
Anwendungsfeld [Subjektiv]                                       |       -1.20 | 0.12 | [-1.43, -0.97] | -10.19 | < .001
Vertrauensmassnahmen [Mit Maßnahme]                              |    2.71e-03 | 0.12 | [-0.23,  0.23] |   0.02 | 0.982 
Einstellung KI                                                   |        0.61 | 0.07 | [ 0.48,  0.75] |   9.17 | < .001
Anwendungsfeld [Subjektiv] × Vertrauensmassnahmen [Mit Maßnahme] |       -0.03 | 0.17 | [-0.36,  0.30] |  -0.17 | 0.869 

> # Effektgrößen
> eta_squared(robust_ancova, partial = TRUE)
# Effect Size for ANOVA (Type I)

Parameter                           | Eta2 (partial) |       95% CI
-------------------------------------------------------------------
Anwendungsfeld                      |           0.36 | [0.30, 1.00]
Vertrauensmassnahmen                |       1.26e-03 | [0.00, 1.00]
Einstellung_KI                      |           0.19 | [0.13, 1.00]
Anwendungsfeld:Vertrauensmassnahmen |       7.41e-05 | [0.00, 1.00]

- One-sided CIs: upper bound fixed at [1.00].
> ### Bootstrapping
> # Funktion für das Bootstrapping der ANCOVA-Koeffizienten
> boot_ancova <- function(data, indices) {
+   sampled_data <- data[indices, ]  # Ziehe Bootstrap-Stichprobe
+   model <- lm(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI, data = sampled_data)
+   return(coef(model))  # Rückgabe der Koeffizienten
+ }

> # Bootstrapping mit 1000 Wiederholungen
> set.seed(123)  # Für Reproduzierbarkeit

> boot_results <- boot(data = daten, statistic = boot_ancova, R = 1000)

> # Ausgabe der Bootstrapped-Konfidenzintervalle
> print(boot.ci(boot_results, type = "perc"))
BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
Based on 1000 bootstrap replicates

CALL : 
boot.ci(boot.out = boot_results, type = "perc")

Intervals : 
Level     Percentile     
95%   ( 1.103,  2.080 )  
Calculations and Intervals on Original Scale

> # Prädiktornamen aus dem Modell extrahieren
> predictor_names <- names(coef(lm(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI, data = daten)))

> # Ausgabe der Bootstrapped-Konfidenzintervalle für alle Prädiktoren mit Namen
> boot_ci_results <- lapply(1:length(boot_results$t0), function(i) {
+   ci <- boot.ci(boot_results, type = "perc", index = i)
+   list(
+     Prädiktor = predictor_names[i],
+     Untergrenze = ci$percent[4],
+     Obergrenze = ci$percent[5]
+   )
+ }) %>% print()
[[1]]
[[1]]$Prädiktor
[1] "(Intercept)"

[[1]]$Untergrenze
[1] 1.102873

[[1]]$Obergrenze
[1] 2.080137


[[2]]
[[2]]$Prädiktor
[1] "AnwendungsfeldSubjektiv"

[[2]]$Untergrenze
[1] -1.435143

[[2]]$Obergrenze
[1] -0.9961955


[[3]]
[[3]]$Prädiktor
[1] "VertrauensmassnahmenMit Maßnahme"

[[3]]$Untergrenze
[1] -0.1803191

[[3]]$Obergrenze
[1] 0.1834547


[[4]]
[[4]]$Prädiktor
[1] "Einstellung_KI"

[[4]]$Untergrenze
[1] 0.4845193

[[4]]$Obergrenze
[1] 0.7446094


[[5]]
[[5]]$Prädiktor
[1] "AnwendungsfeldSubjektiv:VertrauensmassnahmenMit Maßnahme"

[[5]]$Untergrenze
[1] -0.3685968

[[5]]$Obergrenze
[1] 0.3242357



> # Konfidenzintervalle als Dataframe anzeigen
> boot_ci_df <- do.call(rbind, lapply(boot_ci_results, as.data.frame))

> print(boot_ci_df)
                                                 Prädiktor Untergrenze Obergrenze
1                                              (Intercept)   1.1028726  2.0801370
2                                  AnwendungsfeldSubjektiv  -1.4351428 -0.9961955
3                         VertrauensmassnahmenMit Maßnahme  -0.1803191  0.1834547
4                                           Einstellung_KI   0.4845193  0.7446094
5 AnwendungsfeldSubjektiv:VertrauensmassnahmenMit Maßnahme  -0.3685968  0.3242357

> # Visualisierung der Bootstrap-Schätzwerte
> hist(boot_results$t[, 2], main = "Bootstrap-Verteilung für Anwendungsfeld", xlab = "Koeffizient", col = "lightblue", border = "black")

> ###
> # Correlation zwischen Akzeptanz und Einstellung_KI ermitteln (H4)
> daten %>% with(cor.test(Einstellung_KI, Akzeptanz, method = "kendall"))

	Kendall's rank correlation tau

data:  Einstellung_KI and Akzeptanz
z = 6.8454, p-value = 7.627e-12
alternative hypothesis: true tau is not equal to 0
sample estimates:
      tau 
0.2525058 


> daten %>% filter(Anwendungsfeld == "Objektiv") %>% with(cor.test(Einstellung_KI, Akzeptanz, method = "kendall"))

	Kendall's rank correlation tau

data:  Einstellung_KI and Akzeptanz
z = 7.9842, p-value = 1.415e-15
alternative hypothesis: true tau is not equal to 0
sample estimates:
      tau 
0.4212254 


> daten %>% filter(Anwendungsfeld == "Subjektiv") %>% with(cor.test(Einstellung_KI, Akzeptanz, method = "kendall"))

	Kendall's rank correlation tau

data:  Einstellung_KI and Akzeptanz
z = 4.2613, p-value = 2.033e-05
alternative hypothesis: true tau is not equal to 0
sample estimates:
      tau 
0.2266471 


> # Post-hoc Tests für die kategorialen Prädiktoren (falls nötig) mit Tukey HSD durchführen
> TukeyHSD(ancova_model, which = c("Anwendungsfeld", "Vertrauensmassnahmen"))
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI, data = daten)

$Anwendungsfeld
                        diff       lwr       upr p adj
Subjektiv-Objektiv -1.209737 -1.373667 -1.045807     0

$Vertrauensmassnahmen
                                 diff        lwr      upr     p adj
Mit Maßnahme-Ohne Maßnahme 0.05634024 -0.1075755 0.220256 0.4995397


> ### Prüfung der Voraussetzungen für die ANCOVA
> # Normalverteilung der Residuen prüfen
> shapiro.test(residuals(ancova_model))

	Shapiro-Wilk normality test

data:  residuals(ancova_model)
W = 0.99308, p-value = 0.0821


> qqnorm(residuals(ancova_model))

> qqline(residuals(ancova_model))

> # Homogenität der Varianzen prüfen
> leveneTest(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen, data = daten)
Levene's Test for Homogeneity of Variance (center = median)
       Df F value    Pr(>F)    
group   3  7.7782 4.753e-05 ***
      371                      
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> leveneTest(Akzeptanz ~ Anwendungsfeld, data = daten)
Levene's Test for Homogeneity of Variance (center = median)
       Df F value    Pr(>F)    
group   1  21.808 4.211e-06 ***
      373                      
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> leveneTest(Akzeptanz ~ Vertrauensmassnahmen, data = daten)
Levene's Test for Homogeneity of Variance (center = median)
       Df F value Pr(>F)
group   1  0.0058 0.9395
      373               

> # Die Kovariate sollte nicht mit den Residuen korrelieren
> cor.test(daten$Einstellung_KI, residuals(model))

	Pearson's product-moment correlation

data:  daten$Einstellung_KI and residuals(model)
t = -1.3945e-15, df = 373, p-value = 1
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 -0.101271  0.101271
sample estimates:
          cor 
-7.220575e-17 


> # grafische Darstellung Korrelation zwischen Einstellung_KI und Akzeptanz
> ggplot(daten, aes(x = Einstellung_KI, y = Akzeptanz, color = Anwendungsfeld, shape = Anwendungsfeld, linetype = Anwendungsfeld)) +
+   geom_point(alpha = 0.7, size = 2) +  # Punkte etwas größer für bessere Sichtbarkeit
+   geom_smooth(method = "lm", se = FALSE) +
+   scale_color_manual(values = c("Objektiv" = "red", "Subjektiv" = "blue")) +
+   scale_shape_manual(values = c("Objektiv" = 4, "Subjektiv" = 3)) +  # 4 = X, 3 = +
+   scale_linetype_manual(values = c("Objektiv" = "dotted", "Subjektiv" = "solid")) +  # Unterschiedliche Linien
+   labs(title = "Zusammenhang zwischen Einstellung_KI und Akzeptanz nach Anwendungsfeld",
+        x = "Einstellung_KI",
+        y = "Akzeptanz",
+        color = "Anwendungsfeld",
+        shape = "Anwendungsfeld",
+        linetype = "Anwendungsfeld") +
+   theme_minimal()
