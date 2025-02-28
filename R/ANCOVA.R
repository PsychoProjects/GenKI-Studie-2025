source("InstallPackages.R")
source("Read_Data.R")

# Standard-ANCOVA
## ANCOVA-Modell erstellen mit 'Akzeptanz' als abhängige Variable, Anwendungsfeld, Vertrauensmassnahmen und Kovariate

model_def <- as.formula("Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI")
ancova_model <- aov(model_def, data = daten) 

## Zusammenfassung des Modells 
mp <- model_parameters(ancova_model, eta_squared = "partial")
kable(mp, digits = 2, caption = "Zusammenfassung des ANCOVA-Modells")

## Effektgrößen 
eff_es <- eta_squared(ancova_model, partial = TRUE)
kable(eff_es, digits = 2, caption = "Effektgrößen der ANCOVA")

## Koeefizienten des Modells ausgeben
coef_df <- coef(ancova_model)
kable(coef_df, digits = 2, caption = "ANCOVA Koeffizienten")

# Robuste ANCOVA mit heteroskedastizitätsrobusten Standardfehlern (HC3)
robust_ancova <- lm(model_def, data = daten)
anova_robust <- car::Anova(robust_ancova, type = "III", white.adjust = TRUE)

## Zusammenfassung des Modells 
mpr <- model_parameters(robust_ancova, eta_squared = "partial")
kable(mpr, digits = 2, caption = "Zusammenfassung des robusten ANCOVA-Modells")

## Effektgrößen
eff_esr <- eta_squared(robust_ancova, partial = TRUE)
kable(eff_esr, digits = 2, caption = "Effektgrößen der robusten ANCOVA")

# Bootstrapping
## Funktion für das Bootstrapping der ANCOVA-Koeffizienten
boot_ancova <- function(data, indices) {
  sampled_data <- data[indices, ]  # Ziehe Bootstrap-Stichprobe
  model <- lm(model_def, data = sampled_data)
  return(coef(model))  # Rückgabe der Koeffizienten
}

## Bootstrapping mit 1000 Wiederholungen
set.seed(123)  # Für Reproduzierbarkeit
boot_results <- boot(data = daten, statistic = boot_ancova, R = 1000)

## Ausgabe der Bootstrapped-Konfidenzintervalle
print(boot.ci(boot_results, type = "perc"))

## Prädiktornamen aus dem Modell extrahieren
predictor_names <- names(coef(lm(model_def, data = daten)))

## Ausgabe der Bootstrapped-Konfidenzintervalle für alle Prädiktoren mit Namen
boot_ci_results <- lapply(1:length(boot_results$t0), function(i) {
  ci <- boot.ci(boot_results, type = "perc", index = i)
  list(
    Prädiktor = predictor_names[i],
    Untergrenze = ci$percent[4],
    Obergrenze = ci$percent[5]
  )
})

## Konfidenzintervalle anzeigen
boot_ci_df <- do.call(rbind, lapply(boot_ci_results, as.data.frame))
kable(boot_ci_df, digits = 2, caption = "Bootstrapped Konfidenzintervalle")

## Visualisierung der Bootstrap-Schätzwerte
hist(boot_results$t[, 2], main = "Bootstrap-Verteilung für Anwendungsfeld", xlab = "Koeffizient", col = "lightblue", border = "black")

# Prüfung der Voraussetzungen für die ANCOVA
## Homogenität der Varianzen prüfen
leveneTest(residuals(ancova_model) ~ Anwendungsfeld * Vertrauensmassnahmen, data = daten)

## Normalverteilung der Residuen prüfen
shapiro.test(residuals(ancova_model))

## QQ-Plot der Residuen
ggqqplot(
  residuals(ancova_model), 
     conf.int = TRUE, 
     conf.int.fill = "lightgray",
  ) +
  theme(
    axis.title.x = element_text(size = 24),  
    axis.title.y = element_text(size = 24),  
    axis.text = element_text(size = 20)      
  ) +
  labs(
    title = "QQ-Plot der Residuen", 
    x = "Theoretische Quantile", 
    y = "Residuen"
  )


