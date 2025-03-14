source("InstallPackages.R")
source("Read_Data.R")

# Akzeptanz-Analysen
## Hilfsfunktionen für die Berechnung der deskriptiven Statistiken
conf_int_low <- function(x) t.test(x, conf.level = 0.95)$conf.int[1]
conf_int_high <- function(x) t.test(x, conf.level = 0.95)$conf.int[2]

berechne_statistiken <- function(df, variable) {
  df %>%
    summarise(
      Mittelwert = mean({{ variable }}, na.rm = TRUE),
      KI_von = conf_int_low({{ variable }}),
      KI_bis = conf_int_high({{ variable }}),
      Median = median({{ variable }}, na.rm = TRUE),
      Standardabweichung = sd({{ variable }}, na.rm = TRUE),
      Varianz = var({{ variable }}, na.rm = TRUE),
      Minimum = min({{ variable }}, na.rm = TRUE),
      Maximum = max({{ variable }}, na.rm = TRUE),
      Anzahl = n()
    )
}

## Deskriptive Statistiken gesamt
daten %>%
  berechne_statistiken(Akzeptanz) %>%
  kable(caption = "Statistiken zur Akzeptanz", digits = 2)

## Deskriptive Statistiken für jede Gruppe
daten %>%
  group_by(Gruppe) %>%
  berechne_statistiken(Akzeptanz) %>%
  kable(caption = "Statistiken zur Akzeptanz je Gruppe", digits = 2)

## Deskriptive Statistiken für jedes Anwendungsfeld
daten %>%
  group_by(Anwendungsfeld) %>%
  berechne_statistiken(Akzeptanz) %>%
  kable(caption = "Statistiken zur Akzeptanz je Anwendungsfeld", digits = 2)

## Deskriptive Statistiken für die Maßnahmen
daten %>% 
  group_by(Vertrauensmassnahmen) %>%
  berechne_statistiken(Akzeptanz) %>%
  kable(caption = "Statistiken zur Akzeptanz je Vertrauensmaßnahme", digits = 2)

# Einstellungs-Analysen
## Deskriptive Statistiken gesamt
daten %>%
  berechne_statistiken(Einstellung_KI) %>%
  kable(caption = "Statistiken zur Einstellung_KI", digits = 2)

## Deskriptive Statistiken für jede Gruppe
daten %>% 
  group_by(Gruppe) %>%
  berechne_statistiken(Einstellung_KI) %>%
  kable(caption = "Statistiken zur Einstellung_KI je Gruppe", digits = 2)

## Deskriptive Statistiken für jedes Anwendungsfeld
daten %>% 
  group_by(Anwendungsfeld) %>%
  berechne_statistiken(Einstellung_KI) %>%
  kable(caption = "Statistiken zur Einstellung_KI je Anwendungsfeld", digits = 2)

## Deskrptive Statistiken für die Maßnahmen
daten %>% 
  group_by(Vertrauensmassnahmen) %>%
  berechne_statistiken(Einstellung_KI) %>%
  kable(caption = "Statistiken zur Einstellung_KI je Vertrauensmaßnahme", digits = 2)


# Grafische Aufbereitung
## Histogramm der Verteilung der Akzeptanz mit Normalverteilungsanpassung
ggplot(daten, aes(x = Akzeptanz)) +
  geom_histogram(aes(y = after_stat(density)), bins = 20, fill = "lightblue", color = "black") +
  stat_function(fun = dnorm, 
                args = list(mean = mean(daten$Akzeptanz), sd = sd(daten$Akzeptanz)), 
                color = "darkblue", linewidth = 1) +
  labs(title = "Histogramm der Verteilung der Akzeptanz",
       x = "Akzeptanz", y = "Dichte") +
  theme_minimal()

## Histogramm der Verteilung der Akzeptanz getrennt nach Anwendungsfeld
daten %>%
  group_by(Anwendungsfeld) %>%
  ggplot(aes(x = Akzeptanz)) +
  geom_histogram(aes(y = after_stat(density)), bins = 20, fill = "lightblue", color = "black") +
  stat_function(fun = dnorm, 
                args = list(mean = mean(daten$Akzeptanz), sd = sd(daten$Akzeptanz)), 
                color = "darkblue", lwd = 1) +
  facet_wrap(~Anwendungsfeld, scales = "free_y") +
  labs(title = "Histogramme der Verteilung der Akzeptanz je Gruppe",
       x = "Akzeptanz", y = "Dichte") +
  theme_minimal()

## Histogramm der Verteilung der Akzeptanz getrennt nach Gruppe
daten %>%
  group_by(Gruppe) %>%
  ggplot(aes(x = Akzeptanz)) +
  geom_histogram(aes(y = after_stat(density)), bins = 20, fill = "lightblue", color = "black") +
  stat_function(fun = dnorm, 
                args = list(mean = mean(daten$Akzeptanz), sd = sd(daten$Akzeptanz)), 
                color = "darkblue", lwd = 1) +
  facet_wrap(~Gruppe, scales = "free_y") +
  labs(title = "Histogramme der Verteilung der Akzeptanz je Gruppe",
       x = "Akzeptanz", y = "Dichte") +
  theme_minimal()

## Grafische Darstellung der Beziehung zwischen Einstellung_KI und Akzeptanz
gp <- ggplot(daten, aes(x = Einstellung_KI, y = Akzeptanz)) +
  geom_point() +
  geom_smooth(method = "lm", col = "blue") +
  labs(title = "Zusammenhang zwischen Einstellung_KI und Akzeptanz",
       x = "Einstellung_KI", y = "Akzeptanz") +
  theme_minimal()
print(gp)

## Interaktion zwischen Einstellung_KI, Anwendungsfeld und Vertrauensmassnahmen
gp <- ggplot(daten, aes(x = Einstellung_KI, y = Akzeptanz, color = Vertrauensmassnahmen)) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap(~ Anwendungsfeld) +
  labs(title = "Interaktion zwischen Einstellung_KI, Anwendungsfeld und Vertrauensmassnahmen",
       x = "Einstellung_KI", y = "Akzeptanz") +
  theme_minimal()
print(gp)

## Boxplot zur Visualisierung der Verteilung der Akzeptanz in den vier Gruppen
xlables <- c("o0", "o1", "s0", "s1")

box_plot <- ggplot(daten, aes(x = Gruppe, y = Akzeptanz, fill = Gruppe)) +
  geom_boxplot() +
  stat_summary(fun = mean, geom = "point", shape = 4, size = 4, color = "black") +  # Mittelwert als rotes "X"
  scale_fill_manual(values = c("grey70", "grey80", "grey90", "white")) +  # Verschiedene Grautöne
  scale_x_discrete(labels = xlables) +
  labs(title = "Verteilung der Akzeptanz in den vier Gruppen",
       x = "Gruppe", y = "Akzeptanz") +
  theme_minimal()
print(box_plot)


