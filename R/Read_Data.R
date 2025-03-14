source("InstallPackages.R")

if(!exists("daten")) {
  # Daten laden 
  print("Daten werden geladen...")
  
  file_path <- file.path(getwd(), "../Daten", "data_project_1027295_2025_01_24.csv")
  rohdaten <- read.csv(file_path, sep = ";")
  
  # Zusammenstellen des Auswertungsdatensatzes
  ## nur die für die Analyse relevanten Spalten auswählen und ergänzen
  daten <- rohdaten %>% select(lfdn, duration, Experimentalgruppe = c_0001, Attention_test, consent_data_usage, seriousness_check)
  
  ## Anwendungsfeld und Vertrauensmassnahmen als Faktoren definieren
  daten$Anwendungsfeld <- factor(rohdaten$c_0002, 
    levels = c(0, 1), 
    labels = c("Objektiv", "Subjektiv"))
  
  daten$Vertrauensmassnahmen <- factor(rohdaten$c_0003, 
    levels = c(0, 1), 
    labels = c("Ohne Maßnahme", "Mit Maßnahme"))
  
  ## für die Darstellung in Grafiken wird eine neue Spalte 'Gruppe' erstellt
  daten$Gruppe <- factor(
    paste0(
      ifelse(rohdaten$c_0002 == 0, "o", "s"),  # o = Objektiv, s = Subjektiv
      ifelse(rohdaten$c_0003 == 0, "0", "1")   # 0 = ohne Maßnahme, 1 = mit Maßnahme
    ),
    levels = c("o0", "o1", "s0", "s1"),  
    labels = c(
      "o0: Objektiv - ohne Maßnahme",
      "o1: Objektiv - mit Maßnahme",
      "s0: Subjektiv - ohne Maßnahme",
      "s1: Subjektiv - mit Maßnahme"
    )
  )
  
  ## Akzeptanzwerte
  ### Akzeptanzwerte übernehmen und -77 durch NA ersetzen 
  daten <- cbind(daten, select(rohdaten, starts_with("Akzeptanz_")))
  daten <- daten %>%
    mutate(across(starts_with("Akzeptanz_"), ~ replace(.x, .x == -77, NA)))
  
  ### Spalte 'Akzeptanz' erstellen als Mittelwert der einzelnen Akzeptanzwerte abhängig vom Anwendungsfeld
  daten$Akzeptanz <- ifelse(
    daten$Anwendungsfeld == "Objektiv", 
    rowMeans(select(rohdaten, Akzeptanz_O1, Akzeptanz_O2, Akzeptanz_O3), na.rm = TRUE),
    rowMeans(select(rohdaten, Akzeptanz_S1, Akzeptanz_S2, Akzeptanz_S3), na.rm = TRUE))
  
  ## ATTARI-12: Einstellung gegenüber KI
  daten <- cbind(daten, select(rohdaten, starts_with("ATTARI12_")))
  
  ### Negative Items des ATTARI müssen umkodiert werden
  negative_items <- c("ATTARI12_2", "ATTARI12_4", "ATTARI12_7", "ATTARI12_8", "ATTARI12_10", "ATTARI12_12")
  
  for (item in negative_items) {
    daten[[item]] <- 6 - daten[[item]]
  }
  
  ### Gesamtscore für ATTARI-12 berechnen und als neue Spalte hinzufügen
  daten$Einstellung_KI <- rowMeans(select(daten, starts_with("ATTARI12")), na.rm = TRUE)
  
  ## weitere Demographische Variablen
  daten <- daten %>% mutate(Alter = rohdaten$Alter)
  
  ### Faktoren für die demographischen Variablen definieren
  daten$Geschlecht <- factor(rohdaten$Geschlecht, 
    levels = c(1, 2, 3), 
    labels = c("weiblich", "männlich", "divers"))
  
  daten$Bildungsabschluss <- factor(rohdaten$Bildungsabschluss, 
    levels = c(1, 2, 3, 4, 5, 6), 
    labels = c("Ohne Schulabschluss", "Volks- oder Hauptschulabschluss", "Mittlere Reife (Realschulabschluss)", 
      "Abitur oder Fachabitur", "Hochschulabschluss", "Promotion oder Habilitation"))
  
  daten$Berufsstatus <- factor(rohdaten$Berufsstatus, 
    levels = c(1, 2, 3, 4), 
    labels = c("nicht erwerbstätig", "erwerbstätig", "im Studium", "in der Ausbildung"))
  
  daten$GenKI_Erfahrung <- factor(rohdaten$GenKI_Erfahrung, 
    levels = c(1, 2, 3, 4, 5), 
    labels = c("sehr gering", "gering", "mittel", "hoch", "sehr hoch"))
  
  daten$Berufserfahrung <- factor(rohdaten$Berufserfahrung, 
    levels = c(1, 2, 3, 4, 5), 
    labels = c("keine", "weniger als 1 Jahr", "1-5 Jahre", "5-10 Jahre", "mehr als 10 Jahre"))
  
  ## Einschätzung der Teilnehmenden zur Objektivität und Subjektivität der Anwendungsfelder
  daten$objektiv_subjektiv <- factor(rohdaten$v_114, 
    levels = c(1, 2), 
    labels = c("Objektiv", "Subjektiv"))
  
  ## Daten ausschließen, die nicht den Bedingungen entsprechen
  ### die Anzahl wird für die Berichterstattung benötigt
  anzahl <- c(nrow(daten))
  
  daten$skipped <- FALSE
  
  ### skipped auf true setzen, wenn die Bedinungen nicht erfüllt sind
  daten$skipped <- ifelse(daten$Alter < 18, TRUE, daten$skipped)
  anzahl <- c(anzahl, nrow(daten[daten$skipped == FALSE,]))
  
  daten$skipped <- ifelse(daten$consent_data_usage != 1, TRUE, daten$skipped)
  anzahl <- c(anzahl, nrow(daten[daten$skipped == FALSE,]))
  
  daten$skipped <- ifelse(daten$seriousness_check != 1, TRUE, daten$skipped)
  anzahl <- c(anzahl, nrow(daten[daten$skipped == FALSE,]))
  
  daten$skipped <- ifelse(daten$Attention_test != 3, TRUE, daten$skipped)
  anzahl <- c(anzahl, nrow(daten[daten$skipped == FALSE,]))
  
  ### Anzahl der ausgeschlossenen Testpersonen
  differenzen <- c(NA, diff(anzahl))
  
  ## Speichern des aufbereiteten Datensatzes
  write.csv2(daten, "../Daten/data_cleaned.csv", row.names = TRUE, quote = FALSE, fileEncoding = "UTF-16LE")
  
  ## Filtern des Datensatzes auf die nicht ausgeschlossenen Testpersonen
  daten_skipped <- daten %>% filter(skipped == TRUE)
  daten <- daten %>% filter(skipped == FALSE)
}  
