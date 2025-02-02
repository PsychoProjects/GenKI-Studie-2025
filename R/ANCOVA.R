source("InstallPackages.R")
source("Read_Data.R")

# ANCOVA-Modell erstellen mit 'Akzeptanz' als abhängige Variable, Anwendungsfeld, Vertrauensmassnahmen und Kovariate
ancova_model <- aov(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI, data = daten) 

# Zusammenfassung des Modells anzeigen
summary(ancova_model)

# Effektgröße berechnen
eta_squared(ancova_model, partial = TRUE)

# Correlation zwischen Akzeptanz und Einstellung_KI ermitteln (H4)
cor.test(daten$Einstellung_KI, daten$Akzeptanz)

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


