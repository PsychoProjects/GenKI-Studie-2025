source("R/InstallPackages.R")
source("R/Read_Data.R")

daten <- filter(daten, Anwendungsfeld == "Objektiv")
ancova_model <- aov(Akzeptanz ~ Vertrauensmassnahmen + Einstellung_KI, data = daten)

# ANCOVA-Modell erstellen mit 'Akzeptanz' als abhängige Variable, Anwendungsfeld, Vertrauensmassnahmen und Kovariate
ancova_model <- aov(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen + Einstellung_KI, data = daten)

# Zusammenfassung des Modells anzeigen
summary(ancova_model) %>% print()

# Effektgröße berechnen
eta_squared(ancova_model, partial = TRUE) %>% print()
omega_squared(ancova_model) %>% print()

# Post-hoc Tests für die kategorialen Prädiktoren (falls nötig) mit Tukey HSD durchführen
TukeyHSD(ancova_model, which = c("Anwendungsfeld", "Vertrauensmassnahmen")) %>% print()

### Prüfung der Voraussetzungen für die ANCOVA
# Normalverteilung der Residuen prüfen
shapiro.test(residuals(ancova_model)) %>% print()

qqnorm(residuals(ancova_model))
qqline(residuals(ancova_model))

# Homogenität der Varianzen prüfen
leveneTest(Akzeptanz ~ Anwendungsfeld * Vertrauensmassnahmen, data = daten) %>% print()
leveneTest(Akzeptanz ~ Anwendungsfeld, data = daten) %>% print()
leveneTest(Akzeptanz ~ Vertrauensmassnahmen, data = daten) %>% print()

# Lineare Beziehung zwischen der Kovariate und der abhängigen Variable prüfen
plot(daten$Einstellung_KI, daten$Akzeptanz, main = "Einstellung_KI vs. Akzeptanz", xlab = "Einstellung_KI", ylab = "Akzeptanz")
abline(lm(Akzeptanz ~ Einstellung_KI, data = daten), col = "red")

model <- aov(Akzeptanz ~ Einstellung_KI, data = daten)
cor.test(daten$Einstellung_KI, residuals(model)) %>% print()
