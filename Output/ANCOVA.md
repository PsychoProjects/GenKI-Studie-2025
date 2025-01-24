
> source("InstallPackages.R")

> source("Read_Data.R")

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
> omega_squared(ancova_model)
# Effect Size for ANOVA (Type I)

Parameter                           | Omega2 (partial) |       95% CI
---------------------------------------------------------------------
Anwendungsfeld                      |             0.36 | [0.30, 1.00]
Vertrauensmassnahmen                |             0.00 | [0.00, 1.00]
Einstellung_KI                      |             0.18 | [0.13, 1.00]
Anwendungsfeld:Vertrauensmassnahmen |             0.00 | [0.00, 1.00]

- One-sided CIs: upper bound fixed at [1.00].
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
> plot(daten$Einstellung_KI, daten$Akzeptanz, main = "Einstellung_KI vs. Akzeptanz", xlab = "Einstellung_KI", ylab = "Akzeptanz")

> abline(lm(Akzeptanz ~ Einstellung_KI, data = daten), col = "red")

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

