source("R/InstallPackages.R")

# Daten laden 
file_path <- file.path(getwd(), "Daten", "data_project_1027295_2025_01_07.csv")
rohdaten <- read.csv(file_path, sep = ";")

# Herausfiltern der Testpersonen, die nicht in der Studie berücksichtigt werden sollen
rohdaten <- rohdaten %>% filter(Alter != 99, Alter >= 18, consent_data_usage == 1, seriousness_check == 1)

# Spalten umbenennen, da Unipark die nicht korrekt exportiert hat
rohdaten <- rohdaten %>% mutate(Anwendungsfeld = rohdaten$c_0002)
rohdaten <- rohdaten %>% mutate(Vertrauensmassnahmen = rohdaten$c_0003)

# nur die für die Analyse relevanten Spalten auswählen und ergänzen
daten <- rohdaten %>% select(lfdn, duration, Experimentalgruppe = c_0001, Attention_test)

# Anwendungsfeld und Vertrauensmassnahmen als Faktoren definieren
daten$Anwendungsfeld <- factor(rohdaten$c_0002, levels = c(0, 1), labels = c("Objektiv", "Subjektiv"))
daten$Vertrauensmassnahmen <- factor(rohdaten$c_0003, levels = c(0, 1), labels = c("Ohne Maßnahme", "Mit Maßnahme"))
daten$Gruppe <- paste(daten$Anwendungsfeld, daten$Vertrauensmassnahmen, sep = " - ") # für die Darstellung in Grafiken

# Spalte 'Akzeptanz' erstellen als Mittelwert der einzelnen Akzeptanzwerte abhängig vom Anwendungsfeld
daten$Akzeptanz <- ifelse(daten$Anwendungsfeld == "Objektiv", 
                         rowMeans(select(rohdaten, Akzeptanz_O1, Akzeptanz_O2, Akzeptanz_O3), na.rm = TRUE),
                         rowMeans(select(rohdaten, Akzeptanz_S1, Akzeptanz_S2, Akzeptanz_S3), na.rm = TRUE))

# Spalte für den normierten Wert von Akzeptanz für die Regressionsanalyse hinzufügen
daten$Akzeptanz_norm <- scale(daten$Akzeptanz)

# Binäre Variable 'Akzeptanz_binär' erstellen (1 = hoch, 0 = niedrig, Splitwert = 3)
daten$Akzeptanz_binär <- ifelse(daten$Akzeptanz > 3, 1, 0)
daten$Akzeptanz_binär <- factor(daten$Akzeptanz_binär, levels = c(0, 1), labels = c("niedrig", "hoch"))

# Negative Items des ATTARI müssen umkodiert werden
negative_items <- c("ATTARI12_2", "ATTARI12_4", "ATTARI12_7", "ATTARI12_8", "ATTARI12_10", "ATTARI12_12")

for (item in negative_items) {
  rohdaten[[item]] <- 6 - rohdaten[[item]]
}

# Gesamtscore für ATTARI-12 berechnen und als neue Spalte hinzufügen
daten$Einstellung_KI <- rowMeans(select(rohdaten, starts_with("ATTARI12")), na.rm = TRUE)

# Spalte für den normierten Wert von Einstellung_KI für die Regressionsanalyse hinzufügen
daten$Einstellung_KI_norm <- scale(daten$Einstellung_KI)

daten <- daten %>% mutate(Alter = rohdaten$Alter)

# Faktoren für die demographischen Variablen definieren
daten$Geschlecht <- factor(rohdaten$Geschlecht, levels = c(1, 2, 3), labels = c("weiblich", "männlich", "divers"))
daten$Bildungsabschluss <- factor(rohdaten$Bildungsabschluss, levels = c(1, 2, 3, 4, 5, 6), 
                                 labels = c("Ohne Schulabschluss", "Volks- oder Hauptschulabschluss", "Mittlere Reife (Realschulabschluss)", 
                                            "Abitur oder Fachabitur", "Hochschulabschluss", "Promotion oder Habilitation"))

daten$Berufsstatus <- factor(rohdaten$Berufsstatus, 
                            levels = c(1, 2, 3, 4), labels = c("nicht erwerbstätig", "erwerbstätig", "im Studium", "in der Ausbildung"))

daten$GenKI_Erfahrung <- factor(rohdaten$GenKI_Erfahrung, levels = c(1, 2, 3, 4, 5), 
                               labels = c("sehr gering", "gering", "mittel", "hoch", "sehr hoch"))

daten$Berufserfahrung <- factor(rohdaten$Berufserfahrung, levels = c(1, 2, 3, 4, 5), 
                               labels = c("keine", "weniger als 1 Jahr", "1-5 Jahre", "5-10 Jahre", "mehr als 10 Jahre"))


daten <- daten %>% mutate(Attention_test = rohdaten$Attention_test)


write.csv2(daten, "Daten/data_cleaned.csv", row.names = TRUE, quote = FALSE, fileEncoding = "UTF-16LE")

