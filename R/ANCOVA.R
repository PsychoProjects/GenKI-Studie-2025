source("InstallPackages.R")
source("Read_Data.R")

# ANCOVA-Modell erstellen mit 'Akzeptanz' als abhängige Variable, Anwendungsfeld, Vertrauensmassnahmen und Kovariate
ancova_model <- aov(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI, data = daten) 

# Zusammenfassung des Modells anzeigen
summary(ancova_model)

# Effektgröße berechnen
eta_squared(ancova_model, partial = TRUE)

# Robuste ANCOVA mit heteroskedastizitätsrobusten Standardfehlern (HC3)
robust_ancova <- lm(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI, data = daten)
anova_robust <- Anova(robust_ancova, type = "III", white.adjust = TRUE)

# Ausgabe der robusten ANCOVA
print(anova_robust)

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
boot.ci(boot_results, type = "perc")

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

# Lineare Beziehung zwischen der Kovariate und der abhängigen Variable prüfen
model <- aov(Akzeptanz ~ Einstellung_KI, data = daten)
cor.test(daten$Einstellung_KI, residuals(model))

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


