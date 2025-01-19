source("InstallPackages.R")
source("Read_Data.R")

# Deskriptive Statistiken
summary(daten) %>% print()
skim(daten) %>% print()

# Deskriptive Statistiken für jede Gruppe
daten %>% group_by(Gruppe) %>% skim(Akzeptanz) %>% print()

descriptive_stats <- daten %>%
  group_by(Gruppe) %>%
  summarise(
    Mittelwert = mean(Akzeptanz, na.rm = TRUE),
    Median = median(Akzeptanz, na.rm = TRUE),
    Standardabweichung = sd(Akzeptanz, na.rm = TRUE),
    Varianz = var(Akzeptanz, na.rm = TRUE),
    Minimum = min(Akzeptanz, na.rm = TRUE),
    Maximum = max(Akzeptanz, na.rm = TRUE),
    Anzahl = n()
  )
print(descriptive_stats)

# Histogramm der Verteilung der Akzeptanz mit Normalverteilungsanpassung
ggplot(daten, aes(x = Akzeptanz)) +
  geom_histogram(aes(y = ..density..), bins = 20, fill = "lightblue", color = "black") +
  stat_function(fun = dnorm, 
                args = list(mean = mean(daten$Akzeptanz), sd = sd(daten$Akzeptanz)), 
                color = "darkblue", size = 1) +
  labs(title = "Histogramm der Verteilung der Akzeptanz",
       x = "Akzeptanz", y = "Dichte") +
  theme_minimal()

# Histogramm der Verteilung der Akzeptanz getrennt nach Anwendungsfeld
daten %>%
  group_by(Anwendungsfeld) %>%
  ggplot(aes(x = Akzeptanz)) +
  geom_histogram(aes(y = ..density..), bins = 20, fill = "lightblue", color = "black") +
  stat_function(fun = dnorm, 
                args = list(mean = mean(daten$Akzeptanz), sd = sd(daten$Akzeptanz)), 
                color = "darkblue", lwd = 1) +
  facet_wrap(~Anwendungsfeld, scales = "free_y") +
  labs(title = "Histogramme der Verteilung der Akzeptanz je Gruppe",
       x = "Akzeptanz", y = "Dichte") +
  theme_minimal()

# Histogramm der Verteilung der Akzeptanz getrennt nach Gruppe
daten %>%
  group_by(Gruppe) %>%
  ggplot(aes(x = Akzeptanz)) +
  geom_histogram(aes(y = ..density..), bins = 20, fill = "lightblue", color = "black") +
  stat_function(fun = dnorm, 
                args = list(mean = mean(daten$Akzeptanz), sd = sd(daten$Akzeptanz)), 
                color = "darkblue", lwd = 1) +
  facet_wrap(~Gruppe, scales = "free_y") +
  labs(title = "Histogramme der Verteilung der Akzeptanz je Gruppe",
       x = "Akzeptanz", y = "Dichte") +
  theme_minimal()

# Grafische Darstellung der Beziehung zwischen Einstellung_KI und Akzeptanz
gp <- ggplot(daten, aes(x = Einstellung_KI, y = Akzeptanz)) +
  geom_point() +
  geom_smooth(method = "lm", col = "blue") +
  labs(title = "Zusammenhang zwischen Einstellung_KI und Akzeptanz",
       x = "Einstellung_KI", y = "Akzeptanz") +
  theme_minimal()
print(gp)

# Interaktion zwischen Anwendungsfeld und Vertrauensmassnahmen
gp <- ggplot(daten, aes(x = Anwendungsfeld, y = Akzeptanz, fill = Vertrauensmassnahmen)) +
  stat_summary(fun = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_cl_boot, geom = "errorbar", position = position_dodge(width = 0.9), width = 0.2) +
  labs(title = "Interaktion zwischen Anwendungsfeld und Vertrauensmassnahmen",
       x = "Anwendungsfeld", y = "Mittelwert von Akzeptanz") +
  theme_minimal()
print(gp)

# Interaktion zwischen Einstellung_KI, Anwendungsfeld und Vertrauensmassnahmen
gp <- ggplot(daten, aes(x = Einstellung_KI, y = Akzeptanz, color = Vertrauensmassnahmen)) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap(~ Anwendungsfeld) +
  labs(title = "Interaktion zwischen Einstellung_KI, Anwendungsfeld und Vertrauensmassnahmen",
       x = "Einstellung_KI", y = "Akzeptanz") +
  theme_minimal()
print(gp)

# Boxplot zur Visualisierung der Verteilung der Akzeptanz in den vier Gruppen
box_plot <- ggplot(daten, aes(x = Gruppe, y = Akzeptanz, fill = Gruppe)) +
  geom_boxplot() +
  scale_x_discrete(labels = c("O1", "o0", "s1", "S0")) +
  labs(title = "Verteilung der Akzeptanz in den vier Gruppen",
       x = "Gruppe", y = "Akzeptanz") +
  theme_minimal()
print(box_plot)

# Barplot zur Visualisierung der Mittelwerte und Konfidenzintervalle der Akzeptanz in den vier Gruppen
bar_plot <- ggplot(daten, aes(x = Gruppe, y = Akzeptanz, fill = Gruppe)) +
  stat_summary(fun = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_cl_boot, geom = "errorbar", position = position_dodge(width = 0.9), width = 0.2) +
  scale_x_discrete(labels = c("O1", "o0", "s1", "S0")) +
  labs(title = "Mittelwert der Akzeptanz in den vier Gruppen",
       x = "Gruppe", y = "Mittelwert von Akzeptanz") +
  theme_minimal()
print(bar_plot)
