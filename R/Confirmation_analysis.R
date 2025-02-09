source("InstallPackages.R")
source("Read_Data.R")

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

