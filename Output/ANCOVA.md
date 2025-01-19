
> source("InstallPackages.R")

> source("Read_Data.R")

> # ANCOVA-Modell erstellen mit 'Akzeptanz' als abhängige Variable, Anwendungsfeld, Vertrauensmassnahmen und Kovariate
> ancova_model <- aov(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI, data = daten)

> # Zusammenfassung des Modells anzeigen
> summary(ancova_model)
                                     Df Sum Sq Mean Sq F value Pr(>F)    
Anwendungsfeld                        1 127.28  127.28 196.942 <2e-16 ***
Vertrauensmassnahmen                  1   0.31    0.31   0.487  0.486    
Einstellung_KI                        1  54.64   54.64  84.547 <2e-16 ***
Anwendungsfeld:Vertrauensmassnahmen   1   0.01    0.01   0.008  0.929    
Residuals                           360 232.66    0.65                   
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> # Effektgröße berechnen
> eta_squared(ancova_model, partial = TRUE)
# Effect Size for ANOVA (Type I)

Parameter                           | Eta2 (partial) |       95% CI
-------------------------------------------------------------------
Anwendungsfeld                      |           0.35 | [0.29, 1.00]
Vertrauensmassnahmen                |       1.35e-03 | [0.00, 1.00]
Einstellung_KI                      |           0.19 | [0.13, 1.00]
Anwendungsfeld:Vertrauensmassnahmen |       2.20e-05 | [0.00, 1.00]

- One-sided CIs: upper bound fixed at [1.00].
> omega_squared(ancova_model)
# Effect Size for ANOVA (Type I)

Parameter                           | Omega2 (partial) |       95% CI
---------------------------------------------------------------------
Anwendungsfeld                      |             0.35 | [0.29, 1.00]
Vertrauensmassnahmen                |             0.00 | [0.00, 1.00]
Einstellung_KI                      |             0.19 | [0.13, 1.00]
Anwendungsfeld:Vertrauensmassnahmen |             0.00 | [0.00, 1.00]

- One-sided CIs: upper bound fixed at [1.00].
> # Post-hoc Tests für die kategorialen Prädiktoren (falls nötig) mit Tukey HSD durchführen
> TukeyHSD(ancova_model, which = c("Anwendungsfeld", "Vertrauensmassnahmen"))
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI, data = daten)

$Anwendungsfeld
                        diff       lwr       upr p adj
Subjektiv-Objektiv -1.181131 -1.346647 -1.015615     0

$Vertrauensmassnahmen
                                 diff        lwr       upr     p adj
Mit Maßnahme-Ohne Maßnahme 0.05819465 -0.1073363 0.2237256 0.4897747


> ### Prüfung der Voraussetzungen für die ANCOVA
> # Normalverteilung der Residuen prüfen
> shapiro.test(residuals(ancova_model))

	Shapiro-Wilk normality test

data:  residuals(ancova_model)
W = 0.99165, p-value = 0.03761


> qqnorm(residuals(ancova_model))

> qqline(residuals(ancova_model))

> # Homogenität der Varianzen prüfen
> leveneTest(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen, data = daten)
Levene's Test for Homogeneity of Variance (center = median)
       Df F value    Pr(>F)    
group   3  7.8076 4.607e-05 ***
      361                      
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> leveneTest(Akzeptanz ~ Anwendungsfeld, data = daten)
Levene's Test for Homogeneity of Variance (center = median)
       Df F value   Pr(>F)    
group   1   21.19 5.76e-06 ***
      363                     
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> leveneTest(Akzeptanz ~ Vertrauensmassnahmen, data = daten)
Levene's Test for Homogeneity of Variance (center = median)
       Df F value Pr(>F)
group   1  0.0055 0.9408
      363               

> # Lineare Beziehung zwischen der Kovariate und der abhängigen Variable prüfen
> plot(daten$Einstellung_KI, daten$Akzeptanz, main = "Einstellung_KI vs. Akzeptanz", xlab = "Einstellung_KI", ylab = "Akzeptanz")

> abline(lm(Akzeptanz ~ Einstellung_KI, data = daten), col = "red")

> model <- aov(Akzeptanz ~ Einstellung_KI, data = daten)

> cor.test(daten$Einstellung_KI, residuals(model))

	Pearson's product-moment correlation

data:  daten$Einstellung_KI and residuals(model)
t = 6.2332e-15, df = 363, p-value = 1
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 -0.1026506  0.1026506
sample estimates:
         cor 
3.271575e-16 

