source("InstallPackages.R")
source("Read_Data.R")

### Analysen zur Verteilung bezüglich der Geschlechter
# Statistiken nach Geschlecht
daten %>% group_by(Geschlecht) %>% skim(Akzeptanz)
daten %>% group_by(Geschlecht, Gruppe) %>% skim(Akzeptanz)

### Analysen zur Verteilung bezüglich der Bildungsabschlüsse
# Statistiken nach Bildungsabschluss
daten %>% group_by(Bildungsabschluss) %>% skim(Akzeptanz)
daten %>% group_by(Bildungsabschluss, Gruppe) %>% skim(Akzeptanz)

### Analysen zur Verteilung bezüglich der Berufserfahrung
# Statistiken nach Berufserfahrung
daten %>% group_by(Berufserfahrung) %>% skim(Akzeptanz)
daten %>% group_by(Berufserfahrung, Gruppe) %>% skim(Akzeptanz)


### Analysen zur Einschätzung der Objektivität bzw. Subjektivität der Anwendungsfelder
# Korrelationsanalyse zwischen Anwendungsfeld und objektiv-subjektiv-Einschätzung
cor.test(as.numeric(daten$Anwendungsfeld), as.numeric(daten$objektiv_subjektiv), method = "kendall")

# Anzahl übereinstimmender Werte ermitteln
fn_analyse_uebereinstimmung <- function(daten) {
  daten %>% summarise(
    gleich = sum(Anwendungsfeld == objektiv_subjektiv),
    ungleich = sum(Anwendungsfeld != objektiv_subjektiv),
    uebereinstimmung = round((gleich / nrow(daten)) * 100.0,2))
}

# Gesamt
fn_analyse_uebereinstimmung(daten)

# Objektive Anwendungsfelder
fn_analyse_uebereinstimmung(daten %>% filter(Anwendungsfeld == "Objektiv"))

# Subjektive Anwendungsfelder
fn_analyse_uebereinstimmung(daten %>% filter(Anwendungsfeld == "Subjektiv"))

