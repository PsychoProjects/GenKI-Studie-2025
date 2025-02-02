
> source("InstallPackages.R")

> source("Read_Data.R")
[1] "Daten werden geladen..."

> # ANCOVA-Modell erstellen mit 'Akzeptanz' als abhängige Variable, Anwendungsfeld, Vertrauensmassnahmen und Kovariate
> ancova_model <- aov(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI, data = daten) 

> # Zusammenfassung des Modells anzeigen
> summary(ancova_model)
                                     Df Sum Sq Mean Sq F value Pr(>F)    
Anwendungsfeld                        1 137.15  137.15 210.576 <2e-16 ***
Vertrauensmassnahmen                  1   0.30    0.30   0.465  0.496    
Einstellung_KI                        1  54.83   54.83  84.180 <2e-16 ***
Anwendungsfeld:Vertrauensmassnahmen   1   0.02    0.02   0.027  0.869    
Residuals                           370 240.99    0.65                   
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> # Effektgröße berechnen
> eta_squared(ancova_model, partial = TRUE)
# Effect Size for ANOVA (Type I)

Parameter                           | Eta2 (partial) |       95% CI
-------------------------------------------------------------------
Anwendungsfeld                      |           0.36 | [0.30, 1.00]
Vertrauensmassnahmen                |       1.26e-03 | [0.00, 1.00]
Einstellung_KI                      |           0.19 | [0.13, 1.00]
Anwendungsfeld:Vertrauensmassnahmen |       7.41e-05 | [0.00, 1.00]

- One-sided CIs: upper bound fixed at [1.00].
> # Robuste ANCOVA mit heteroskedastizitätsrobusten Standardfehlern (HC3)
> robust_ancova <- lm(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI, data = daten)

> anova_robust <- Anova(robust_ancova, type = "III", white.adjust = TRUE)

> # Ausgabe der robusten ANCOVA
> print(anova_robust)
Analysis of Deviance Table (Type III tests)

Response: Akzeptanz
                                     Df        F    Pr(>F)    
(Intercept)                           1  37.3356 2.522e-09 ***
Anwendungsfeld                        1 116.0092 < 2.2e-16 ***
Vertrauensmassnahmen                  1   0.0009    0.9766    
Einstellung_KI                        1  82.8353 < 2.2e-16 ***
Anwendungsfeld:Vertrauensmassnahmen   1   0.0269    0.8697    
Residuals                           370                       
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

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
> boot.ci(boot_results, type = "perc")
BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
Based on 1000 bootstrap replicates

CALL : 
boot.ci(boot.out = boot_results, type = "perc")

Intervals : 
Level     Percentile     
95%   ( 1.103,  2.080 )  
Calculations and Intervals on Original Scale

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

> # Lineare Beziehung zwischen der Kovariate und der abhängigen Variable prüfen
> model <- aov(Akzeptanz ~ Einstellung_KI, data = daten)

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
