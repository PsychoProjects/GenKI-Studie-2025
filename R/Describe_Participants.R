source("InstallPackages.R")
source("Read_Data.R")

# Anzahl Teilnehmer (gesamt)
nrow(daten)

# Anzahl Teilnehmer (je Gruppe)
gruppen_groessen <- table(daten$Gruppe) %>% as.data.frame()

gruppen_statistik <- gruppen_groessen %>% 
  summarise(
    Mittelwert = mean(Freq),
    Median = median(Freq),
    Standardabweichung = sd(Freq),
    Minimum = min(Freq),
    Maximum = max(Freq),
    Relation = max(Freq) / min(Freq)
  ) %>% print()

# Aufteilung nach Geschlecht
geschlechter_statisik <- daten %>% group_by(Geschlecht) %>%
  summarise(
    Anzahl = n(),
    Anteil = round(n() / nrow(daten) * 100, digits = 2)
  ) %>% print()

daten %>% group_by(Geschlecht, Gruppe) %>% count()

# Aufteilung nach Bildungsabschluss (Anzahl und Anteil)
bildungsabschluss_statistik <- daten %>% group_by(Bildungsabschluss) %>%
  summarise(
    Anzahl = n(),
    Anteil = round(n() / nrow(daten) * 100, digits = 2)
  ) %>% print()

# Statistiken zum Alter
alter_statistik <- daten %>% 
  summarise(
    Mittelwert = mean(Alter, na.rm = TRUE),
    Median = median(Alter, na.rm = TRUE),
    Standardabweichung = sd(Alter, na.rm = TRUE),
    Minimum = min(Alter, na.rm = TRUE),
    Maximum = max(Alter, na.rm = TRUE),
  ) %>% print()

# Aufteilung nach Altersgruppen
altersgruppen <- cut(daten$Alter, 
                     breaks = c(0, 18, 20, 30, 40, 50, 60, 70, 80, 90, 100), 
                     right = FALSE) %>% table() %>% print()

# Aufteilung nach Berufsstatus
berufsstatistik <- daten %>% group_by(Berufsstatus) %>% 
  summarise(
    Anzahl = n(),
    Anteil = round(n() / nrow(daten) * 100, digits = 2)
  ) %>% print()

# Aufteilung nach Berufserfahrung
berufserfahrungsstatistik <- daten %>% group_by(Berufserfahrung) %>% count() %>% print()


