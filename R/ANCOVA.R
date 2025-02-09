source("InstallPackages.R")
source("Read_Data.R")

### Standard-ANCOVA
# ANCOVA-Modell erstellen mit 'Akzeptanz' als abhängige Variable, Anwendungsfeld, Vertrauensmassnahmen und Kovariate
ancova_model <- aov(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI, data = daten) 

# Koeefizienten des Modells ausgeben
coef_df <- coef(ancova_model)
kable(coef_df, digits = 2, caption = "ANCOVA Koeffizienten")

# Zusammenfassung des Modells 
model_parameters(ancova_model, eta_squared = "partial")

# Effektgrößen 
eta_squared(ancova_model, partial = TRUE)

### Robuste ANCOVA mit heteroskedastizitätsrobusten Standardfehlern (HC3)
robust_ancova <- lm(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI, data = daten)
anova_robust <- car::Anova(robust_ancova, type = "III", white.adjust = TRUE)

# Zusammenfassung des Modells 
model_parameters(robust_ancova, eta_squared = "partial")

# Effektgrößen
eta_squared(robust_ancova, partial = TRUE)

### Bootstrapping
# Funktion für das Bootstrapping der ANCOVA-Koeffizienten
boot_ancova <- function(data, indices) {
  sampled_data <- data[indices, ]  # Ziehe Bootstrap-Stichprobe
  model <- lm(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI, data = sampled_data)
  return(coef(model))  # Rückgabe der Koeffizienten
}

# Bootstrapping mit 1000 Wiederholungen
set.seed(123)  # Für Reproduzierbarkeit
boot_results <- boot(data = daten, statistic = boot_ancova, R = 1000)

# Ausgabe der Bootstrapped-Konfidenzintervalle
print(boot.ci(boot_results, type = "perc"))

# Prädiktornamen aus dem Modell extrahieren
predictor_names <- names(coef(lm(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI, data = daten)))

# Ausgabe der Bootstrapped-Konfidenzintervalle für alle Prädiktoren mit Namen
boot_ci_results <- lapply(1:length(boot_results$t0), function(i) {
  ci <- boot.ci(boot_results, type = "perc", index = i)
  list(
    Prädiktor = predictor_names[i],
    Untergrenze = ci$percent[4],
    Obergrenze = ci$percent[5]
  )
})

# Konfidenzintervalle als Dataframe anzeigen
boot_ci_df <- do.call(rbind, lapply(boot_ci_results, as.data.frame))
print(boot_ci_df)

# Visualisierung der Bootstrap-Schätzwerte
hist(boot_results$t[, 2], main = "Bootstrap-Verteilung für Anwendungsfeld", xlab = "Koeffizient", col = "lightblue", border = "black")

###
# Correlation zwischen Akzeptanz und Einstellung_KI ermitteln (H4)
daten %>% with(cor.test(Einstellung_KI, Akzeptanz, method = "kendall"))
daten %>% filter(Anwendungsfeld == "Objektiv") %>% with(cor.test(Einstellung_KI, Akzeptanz, method = "kendall"))
daten %>% filter(Anwendungsfeld == "Subjektiv") %>% with(cor.test(Einstellung_KI, Akzeptanz, method = "kendall"))

# Post-hoc Tests für die kategorialen Prädiktoren (falls nötig) mit Tukey HSD durchführen
TukeyHSD(ancova_model, which = c("Anwendungsfeld", "Vertrauensmassnahmen"))

### Prüfung der Voraussetzungen für die ANCOVA
# Normalverteilung der Residuen prüfen
shapiro.test(residuals(ancova_model))

qqnorm(residuals(ancova_model))
qqline(residuals(ancova_model))

# Homogenität der Varianzen prüfen
leveneTest(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen, data = daten)
leveneTest(Akzeptanz ~ Anwendungsfeld, data = daten)
leveneTest(Akzeptanz ~ Vertrauensmassnahmen, data = daten)

# grafische Darstellung Korrelation zwischen Einstellung_KI und Akzeptanz
ggplot(daten, aes(x = Einstellung_KI, y = Akzeptanz, color = Anwendungsfeld, shape = Anwendungsfeld, linetype = Anwendungsfeld)) +
  geom_point(alpha = 0.7, size = 2) +  # Punkte etwas größer für bessere Sichtbarkeit
  geom_smooth(method = "lm", se = FALSE) +
  scale_color_manual(values = c("Objektiv" = "red", "Subjektiv" = "blue")) +
  scale_shape_manual(values = c("Objektiv" = 4, "Subjektiv" = 3)) +  # 4 = X, 3 = +
  scale_linetype_manual(values = c("Objektiv" = "dotted", "Subjektiv" = "solid")) +  # Unterschiedliche Linien
  labs(title = "Zusammenhang zwischen Einstellung_KI und Akzeptanz nach Anwendungsfeld",
       x = "Einstellung_KI",
       y = "Akzeptanz",
       color = "Anwendungsfeld",
       shape = "Anwendungsfeld",
       linetype = "Anwendungsfeld") +
  theme_minimal()


