source("InstallPackages.R")
source("Read_Data.R")

# Cronbachs Alpha sollte hoch (>=0.9) sein (Stein et al. 2024)
attari_daten <- rohdaten %>% select(starts_with("ATTARI"))
attari_daten$Einstellung_KI <- daten$Einstellung_KI
alpha(attari_daten)

# Es ist zu erwarten, dass das Histogramm links-schief ist (Stein et al. 2024)
# Analyse der Einstellung_KI (ATTARI-12)
daten %>% skim(Einstellung_KI) 

daten %>% summarise(
  Schiefe = skewness(Einstellung_KI), 
  Kurtosis = kurtosis(Einstellung_KI)) 

# Histogramm der Verteilung der Einstellung_KI mit Normalverteilungsanpassung
ggplot(daten, aes(x = Einstellung_KI)) +
  geom_histogram(aes(y = ..density..), bins = 10, fill = "lightblue", color = "black") +
  geom_density(alpha = 0.2, fill = "red") +
  labs(title = "Verteilung der Einstellung KI",
       x = "Einstellung",
       y = "Dichte") +
  theme_minimal()

# Vereilung nach Geschlecht
daten %>% group_by(Geschlecht) %>% skim(Einstellung_KI) 

daten %>% group_by(Geschlecht) %>% 
  summarise(
    Schiefe = skewness(Einstellung_KI), 
    Kurtosis = kurtosis(Einstellung_KI)) 

# Histogramm der Verteilung der Einstellung_KI mit Normalverteilungsanpassung gruppiert nach Geschlecht
ggplot(daten, aes(x = Einstellung_KI, fill = Geschlecht)) +
  geom_histogram(aes(y = ..density..), bins = 10, color = "black", position = "dodge") +
  geom_density(alpha = 0.2, position = "dodge") +
  labs(title = "Verteilung der Einstellung KI",
       x = "Einstellung",
       y = "Dichte") +
  theme_minimal()

