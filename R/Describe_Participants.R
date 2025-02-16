source("InstallPackages.R")
source("Read_Data.R")

# Anzahl Teilnehmer (gesamt)
nrow(daten)

# Anzahl Teilnehmer (je Gruppe)
gruppen_groessen <- table(daten$Gruppe) %>% as.data.frame()

gruppen_statistik <- gruppen_groessen %>% 
  summarise(
    Mittelwert = mean(Freq),
    KI_von = t.test(Freq)$conf.int[1],
    KI_bis = t.test(Freq)$conf.int[2],
    Median = median(Freq),
    Standardabweichung = sd(Freq),
    Minimum = min(Freq),
    Maximum = max(Freq),
    Relation = max(Freq) / min(Freq)
  ) 
kable(gruppen_statistik, caption = "Statistiken zur Gruppengröße", digits = 2)

# Aufteilung nach Geschlecht
geschlechter_statisik <- daten %>% group_by(Geschlecht) %>%
  summarise(
    Anzahl = n(),
    Anteil = round(n() / nrow(daten) * 100, digits = 2)
  ) 
kable(geschlechter_statisik, caption = "Statistiken zur Geschlechterverteilung", digits = 2)

t_geschl_gruppe <- daten %>% group_by(Geschlecht, Gruppe) %>% count()
kable(t_geschl_gruppe, caption = "Kreuztabelle Geschlecht und Gruppe", digits = 2)

# Aufteilung nach Bildungsabschluss (Anzahl und Anteil)
bildungsabschluss_statistik <- daten %>% group_by(Bildungsabschluss) %>%
  summarise(
    Anzahl = n(),
    Anteil = round(n() / nrow(daten) * 100, digits = 2)
  ) 
kable(bildungsabschluss_statistik, caption = "Statistiken zum Bildungsabschluss", digits = 2)

# Statistiken zum Alter
alter_statistik <- daten %>% 
  summarise(
    Mittelwert = mean(Alter, na.rm = TRUE),
    KI_von = t.test(Alter)$conf.int[1],
    KI_bis = t.test(Alter)$conf.int[2],
    Median = median(Alter, na.rm = TRUE),
    Standardabweichung = sd(Alter, na.rm = TRUE),
    Minimum = min(Alter, na.rm = TRUE),
    Maximum = max(Alter, na.rm = TRUE),
  ) 
kable(alter_statistik, caption = "Statistiken zum Alter", digits = 2)

## Aufteilung nach Altersgruppen
altersgruppen <- cut(daten$Alter, 
                     breaks = c(0, 18, 20, 30, 40, 50, 60, 70, 80, 90, 100), 
                     right = FALSE) %>% table() 
altersgruppen_df <- as.data.frame(altersgruppen)
altersgruppen_df$Anteil <- (altersgruppen_df$Freq / sum(altersgruppen_df$Freq)) * 100

kable(altersgruppen_df, caption = "Statistiken zu den Altersgruppen", digits = 2)

# Aufteilung nach Berufsstatus
berufsstatistik <- daten %>% group_by(Berufsstatus) %>% 
  summarise(
    Anzahl = n(),
    Anteil = round(n() / nrow(daten) * 100, digits = 2)
  )
kable(berufsstatistik, caption = "Statistiken zum Berufsstatus", digits = 2)

# Aufteilung nach Berufserfahrung
berufserfahrungsstatistik <- daten %>% group_by(Berufserfahrung) %>% 
  summarise(
    Anzahl = n(),
    Anteil = round(n() / nrow(daten) * 100, digits = 2)
  ) 
kable(berufserfahrungsstatistik, caption = "Statistiken zur Berufserfahrung", digits = 2)

# Statistiken nach Erfahrung mit GenKI
genki_statistik <- daten %>% group_by(GenKI_Erfahrung) %>% 
  summarise(
    Anzahl = n(),
    Anteil = round(n() / nrow(daten) * 100, digits = 2)
  )
kable(genki_statistik, caption = "Statistiken zur Erfahrung mit GenKI", digits = 2)

## Histogramm der Verteilung der GenKI-Erfahrung
ggplot(genki_statistik, aes(x = GenKI_Erfahrung, y = Anzahl)) +
  geom_bar(stat = "identity", fill = "grey80", color = "black") + 
  theme_minimal() +  # Minimalistisches Design
  labs(title = "Verteilung der GenKI-Erfahrung",
       x = "GenKI-Erfahrung",
       y = "Anzahl")

