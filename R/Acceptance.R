source("InstallPackages.R")
source("Read_Data.R")

# Cronbachs Alpha für objektive Anwendungsfelder
akzeptanz_daten_objektiv <- daten %>% 
  filter(Anwendungsfeld == "Objektiv") %>%
  select(starts_with("Akzeptanz_O"))

alpha(akzeptanz_daten_objektiv)

# Berechnung der Korrelationsmatrix nur obere Diagonale
cor(akzeptanz_daten_objektiv)

# Faktorenanalyse mit 2 Faktoren fpr objektive Anwendungsfelder
fa(akzeptanz_daten_objektiv, nfactors = 3, rotate = "varimax")
fa(akzeptanz_daten_objektiv, nfactors = 2, rotate = "varimax")
fa(akzeptanz_daten_objektiv, nfactors = 1, rotate = "varimax")

# Cronbachs Alpha für subjektive Anwendungsfelder
akzeptanz_daten_subjektiv <- daten %>% 
  filter(Anwendungsfeld == "Subjektiv") %>%
  select(starts_with("Akzeptanz_S"))

alpha(akzeptanz_daten_subjektiv)

# Berechnung der Korrelationsmatrix
cor(akzeptanz_daten_subjektiv)

# Faktorenanalyse mit 2 Faktoren für subjektive Anwendungsfelder
fa(akzeptanz_daten_subjektiv, nfactors = 3, rotate = "varimax")
fa(akzeptanz_daten_subjektiv, nfactors = 2, rotate = "varimax")
fa(akzeptanz_daten_subjektiv, nfactors = 1, rotate = "varimax")

# Analyse der Werteverteilung
plot_histograms <- function(data) {
  data %>%
    select(starts_with("Akzeptanz")) %>%
    gather(variable, value) %>%
    ggplot(aes(x = value)) +
    geom_histogram(aes(y = ..density..), bins = 10, fill = "lightblue", color = "black") +
    geom_density(alpha = 0.2, fill = "red") +
    facet_wrap(~ variable, scales = "free") +
    labs(x = "Wert", y = "Häufigkeit")
}

# Histogramme für objektive Anwendungsfelder
plot_histograms(akzeptanz_daten_objektiv)

# Histogramme für subjektive Anwendungsfelder
plot_histograms(akzeptanz_daten_subjektiv)
