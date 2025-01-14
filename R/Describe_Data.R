source("R/InstallPackages.R")
source("R/Read_Data.R")

cat("\n*** Deskriptive Statistiken\n")
summary(daten) %>% print()
skim(daten) %>% print()

cat("\n***  Deskriptive Statistiken für jede Gruppe\n") 
daten %>% group_by(Gruppe) %>% skim(Akzeptanz) %>% print()

descriptive_stats <- daten %>%
  group_by(Gruppe) %>%
  summarise(
    Mittelwert = mean(Akzeptanz, na.rm = TRUE),
    Median = median(Akzeptanz, na.rm = TRUE),
    Standardabweichung = sd(Akzeptanz, na.rm = TRUE),
    Minimum = min(Akzeptanz, na.rm = TRUE),
    Maximum = max(Akzeptanz, na.rm = TRUE),
    Anzahl = n()
  )
print(descriptive_stats)

cat("\n***  Anzahl der Teilnehmer nach Aufmerksamkeitstest\n")
daten %>% group_by(Attention_test) %>% summarise(Anzahl = n()) %>% print()

cat("\n*** Aufteilung nach Geschlecht\n")
daten %>% group_by(Geschlecht) %>% count() %>% print()

cat("\n***  Histogramm der Verteilung der Akzeptanz mit Normalverteilungsanpassung\n")
ggplot(daten, aes(x = Akzeptanz)) +
  geom_histogram(aes(y = ..density..), bins = 20, fill = "lightblue", color = "black") +
  stat_function(fun = dnorm, 
                args = list(mean = mean(daten$Akzeptanz), sd = sd(daten$Akzeptanz)), 
                color = "darkblue", size = 1) +
  labs(title = "Histogramm der Verteilung der Akzeptanz",
       x = "Akzeptanz", y = "Dichte") +
  theme_minimal()

cat("\n***  Histogramm der Verteilung der Akzeptanz getrennt nach Anwendungsfeld\n")
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

cat("\n***  Histogramm der Verteilung der Akzeptanz getrennt nach Gruppe\n")
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

cat("\n***  Grafische Darstellung der Beziehung zwischen Einstellung_KI und Akzeptanz\n")
gp <- ggplot(daten, aes(x = Einstellung_KI, y = Akzeptanz)) +
  geom_point() +
  geom_smooth(method = "lm", col = "blue") +
  labs(title = "Zusammenhang zwischen normierter Einstellung_KI und Akzeptanz",
       x = "Normierte Einstellung_KI", y = "Akzeptanz") +
  theme_minimal()
print(gp)

cat("\n***  Interaktion zwischen Anwendungsfeld und Vertrauensmassnahmen\n")
gp <- ggplot(daten, aes(x = Anwendungsfeld, y = Akzeptanz, fill = Vertrauensmassnahmen)) +
  stat_summary(fun = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_cl_boot, geom = "errorbar", position = position_dodge(width = 0.9), width = 0.2) +
  labs(title = "Interaktion zwischen Anwendungsfeld und Vertrauensmassnahmen",
       x = "Anwendungsfeld", y = "Mittelwert von Akzeptanz") +
  theme_minimal()
print(gp)

cat("\n***  Interaktion zwischen Einstellung_KI, Anwendungsfeld und Vertrauensmassnahmen\n")
gp <- ggplot(daten, aes(x = Einstellung_KI, y = Akzeptanz, color = Vertrauensmassnahmen)) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap(~ Anwendungsfeld) +
  labs(title = "Interaktion zwischen normierter Einstellung_KI, Anwendungsfeld und Vertrauensmassnahmen",
       x = "Normierte Einstellung_KI", y = "Akzeptanz") +
  theme_minimal()
print(gp)

cat("\n***  Boxplot zur Visualisierung der Verteilung der Akzeptanz in den vier Gruppen\n")
box_plot <- ggplot(daten, aes(x = Gruppe, y = Akzeptanz, fill = Gruppe)) +
  geom_boxplot() +
  scale_x_discrete(labels = c("O1", "o0", "s1", "S0")) +
  labs(title = "Verteilung der Akzeptanz in den vier Gruppen",
       x = "Gruppe", y = "Akzeptanz") +
  theme_minimal()
print(box_plot)

cat("\n***  Barplot zur Visualisierung der Mittelwerte und Konfidenzintervalle der Akzeptanz in den vier Gruppen\n")
bar_plot <- ggplot(daten, aes(x = Gruppe, y = Akzeptanz, fill = Gruppe)) +
  stat_summary(fun = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_cl_boot, geom = "errorbar", position = position_dodge(width = 0.9), width = 0.2) +
  scale_x_discrete(labels = c("O1", "o0", "s1", "S0")) +
  labs(title = "Mittelwert der Akzeptanz in den vier Gruppen",
       x = "Gruppe", y = "Mittelwert von Akzeptanz") +
  theme_minimal()
print(bar_plot)



