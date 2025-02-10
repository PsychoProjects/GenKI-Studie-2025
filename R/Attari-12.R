source("InstallPackages.R")
source("Read_Data.R")

# Cronbachs Alpha sollte hoch (>=0.9) sein (Stein et al. 2024)
attari_daten <- rohdaten %>% select(starts_with("ATTARI"))
ca <- alpha(attari_daten)

# Konfidenzintervall ergänzen
ca_stats <- ca$total %>% mutate(
  CI_lower = raw_alpha - 1.96 * ase,
  CI_upper = raw_alpha + 1.96 * ase,
  df = nrow(attari_daten) - 1
)
## Extraktion der wichtigsten Werte für die Tabelle
kable(ca_stats, digits = 2, caption = "Gesamtergebnis der Reliabilitätsanalyse")

## Ausgabe aller Items
kable(ca$item.stats, digits = 2, caption = "Item-Statistiken der Reliabilitätsanalyse")


## Es ist zu erwarten, dass das Histogramm links-schief ist (Stein et al. 2024)
daten %>% skim(Einstellung_KI) 

daten %>% summarise(
  Schiefe = skewness(Einstellung_KI), 
  Kurtosis = kurtosis(Einstellung_KI)) 

# Histogramm der Verteilung der Einstellung_KI mit Normalverteilungsanpassung
ggplot(daten, aes(x = Einstellung_KI)) +
  geom_histogram(aes(y = after_stat(density)), bins = 10, fill = "lightblue", color = "black") +
  geom_density(alpha = 0.2, fill = "red") +
  labs(title = "Verteilung der Einstellung KI",
       x = "Einstellung",
       y = "Dichte") +
  theme_minimal()


