
> source("InstallPackages.R")

> source("Read_Data.R")
[1] "Daten werden geladen..."

> # Deskriptive Statistiken für jede Gruppe
> daten %>% group_by(Gruppe) %>%
+   summarise(
+     Mittelwert = mean(Akzeptanz, na.rm = TRUE),
+     Median = median(Akzeptanz, na.rm = TRUE),
+     Standardabweichung = sd(Akzeptanz, na.rm = TRUE),
+     Varianz = var(Akzeptanz, na.rm = TRUE),
+     Minimum = min(Akzeptanz, na.rm = TRUE),
+     Maximum = max(Akzeptanz, na.rm = TRUE),
+     Anzahl = n()
+   ) 
# A tibble: 4 × 8
  Gruppe                    Mittelwert Median Standardabweichung Varianz Minimum Maximum Anzahl
  <chr>                          <dbl>  <dbl>              <dbl>   <dbl>   <dbl>   <dbl>  <int>
1 Objektiv - Mit Maßnahme         3.86   4                 0.787   0.619    1.33       5    107
2 Objektiv - Ohne Maßnahme        3.77   4                 0.730   0.533    1.33       5     84
3 Subjektiv - Mit Maßnahme        2.63   2.67              1.01    1.02     1          5     78
4 Subjektiv - Ohne Maßnahme       2.60   2.67              1.01    1.02     1          5    106

> # Deskriptive Statistiken für jedes Anwendungsfeld
> daten %>% group_by(Anwendungsfeld) %>%
+   summarise(
+     Mittelwert = mean(Akzeptanz, na.rm = TRUE),
+     Median = median(Akzeptanz, na.rm = TRUE),
+     Standardabweichung = sd(Akzeptanz, na.rm = TRUE),
+     Varianz = var(Akzeptanz, na.rm = TRUE),
+     Minimum = min(Akzeptanz, na.rm = TRUE),
+     Maximum = max(Akzeptanz, na.rm = TRUE),
+     Anzahl = n()
+   ) 
# A tibble: 2 × 8
  Anwendungsfeld Mittelwert Median Standardabweichung Varianz Minimum Maximum Anzahl
  <fct>               <dbl>  <dbl>              <dbl>   <dbl>   <dbl>   <dbl>  <int>
1 Objektiv             3.82   4                 0.761   0.580    1.33       5    191
2 Subjektiv            2.61   2.67              1.01    1.02     1          5    184

> # Deskrptive Statistiken für die Maßnahmen
> daten %>% group_by(Vertrauensmassnahmen) %>%
+   summarise(
+     Mittelwert = mean(Akzeptanz, na.rm = TRUE),
+     Median = median(Akzeptanz, na.rm = TRUE),
+     Standardabweichung = sd(Akzeptanz, na.rm = TRUE),
+     Varianz = var(Akzeptanz, na.rm = TRUE),
+     Minimum = min(Akzeptanz, na.rm = TRUE),
+     Maximum = max(Akzeptanz, na.rm = TRUE),
+     Anzahl = n()
+   ) 
# A tibble: 2 × 8
  Vertrauensmassnahmen Mittelwert Median Standardabweichung Varianz Minimum Maximum Anzahl
  <fct>                     <dbl>  <dbl>              <dbl>   <dbl>   <dbl>   <dbl>  <int>
1 Ohne Maßnahme              3.12   3.33               1.07    1.14       1       5    190
2 Mit Maßnahme               3.34   3.33               1.07    1.16       1       5    185

> ### Grafische Aufbereitung
> # Histogramm der Verteilung der Akzeptanz mit Normalverteilungsanpassung
> ggplot(daten, aes(x = Akzeptanz)) +
+   geom_histogram(aes(y = ..density..), bins = 20, fill = "lightblue", color = "black") +
+   stat_function(fun = dnorm, 
+                 args = list(mean = mean(daten$Akzeptanz), sd = sd(daten$Akzeptanz)), 
+                 color = "darkblue", size = 1) +
+   labs(title = "Histogramm der Verteilung der Akzeptanz",
+        x = "Akzeptanz", y = "Dichte") +
+   theme_minimal()

> # Histogramm der Verteilung der Akzeptanz getrennt nach Anwendungsfeld
> daten %>%
+   group_by(Anwendungsfeld) %>%
+   ggplot(aes(x = Akzeptanz)) +
+   geom_histogram(aes(y = ..density..), bins = 20, fill = "lightblue", color = "black") +
+   stat_function(fun = dnorm, 
+                 args = list(mean = mean(daten$Akzeptanz), sd = sd(daten$Akzeptanz)), 
+                 color = "darkblue", lwd = 1) +
+   facet_wrap(~Anwendungsfeld, scales = "free_y") +
+   labs(title = "Histogramme der Verteilung der Akzeptanz je Gruppe",
+        x = "Akzeptanz", y = "Dichte") +
+   theme_minimal()

> # Histogramm der Verteilung der Akzeptanz getrennt nach Gruppe
> daten %>%
+   group_by(Gruppe) %>%
+   ggplot(aes(x = Akzeptanz)) +
+   geom_histogram(aes(y = ..density..), bins = 20, fill = "lightblue", color = "black") +
+   stat_function(fun = dnorm, 
+                 args = list(mean = mean(daten$Akzeptanz), sd = sd(daten$Akzeptanz)), 
+                 color = "darkblue", lwd = 1) +
+   facet_wrap(~Gruppe, scales = "free_y") +
+   labs(title = "Histogramme der Verteilung der Akzeptanz je Gruppe",
+        x = "Akzeptanz", y = "Dichte") +
+   theme_minimal()

> # Grafische Darstellung der Beziehung zwischen Einstellung_KI und Akzeptanz
> gp <- ggplot(daten, aes(x = Einstellung_KI, y = Akzeptanz)) +
+   geom_point() +
+   geom_smooth(method = "lm", col = "blue") +
+   labs(title = "Zusammenhang zwischen Einstellung_KI und Akzeptanz",
+        x = "Einstellung_KI", y = "Akzeptanz") +
+   theme_minimal()

> print(gp)

> # Interaktion zwischen Anwendungsfeld und Vertrauensmassnahmen
> gp <- ggplot(daten, aes(x = Anwendungsfeld, y = Akzeptanz, fill = Vertrauensmassnahmen)) +
+   stat_summary(fun = mean, geom = "bar", position = "dodge") +
+   stat_summary(fun.data = mean_cl_boot, geom = "errorbar", position = position_dodge(width = 0.9), width = 0.2) +
+   labs(title = "Interaktion zwischen Anwendungsfeld und Vertrauensmassnahmen",
+        x = "Anwendungsfeld", y = "Mittelwert von Akzeptanz") +
+   theme_minimal()

> print(gp)

> # Interaktion zwischen Einstellung_KI, Anwendungsfeld und Vertrauensmassnahmen
> gp <- ggplot(daten, aes(x = Einstellung_KI, y = Akzeptanz, color = Vertrauensmassnahmen)) +
+   geom_point() +
+   geom_smooth(method = "lm") +
+   facet_wrap(~ Anwendungsfeld) +
+   labs(title = "Interaktion zwischen Einstellung_KI, Anwendungsfeld und Vertrauensmassnahmen",
+        x = "Einstellung_KI", y = "Akzeptanz") +
+   theme_minimal()

> print(gp)

> # Boxplot zur Visualisierung der Verteilung der Akzeptanz in den vier Gruppen
> box_plot <- ggplot(daten, aes(x = Gruppe, y = Akzeptanz, fill = Gruppe)) +
+   geom_boxplot() +
+   scale_x_discrete(labels = c("O1", "o0", "s1", "S0")) +
+   labs(title = "Verteilung der Akzeptanz in den vier Gruppen",
+        x = "Gruppe", y = "Akzeptanz") +
+   theme_minimal()

> print(box_plot)

> # Barplot zur Visualisierung der Mittelwerte und Konfidenzintervalle der Akzeptanz in den vier Gruppen
> bar_plot <- ggplot(daten, aes(x = Gruppe, y = Akzeptanz, fill = Gruppe)) +
+   stat_summary(fun = mean, geom = "bar", position = "dodge") +
+   stat_summary(fun.data = mean_cl_boot, geom = "errorbar", position = position_dodge(width = 0.9), width = 0.2) +
+   scale_x_discrete(labels = c("O1", "o0", "s1", "S0")) +
+   labs(title = "Mittelwert der Akzeptanz in den vier Gruppen",
+        x = "Gruppe", y = "Mittelwert von Akzeptanz") +
+   theme_minimal()

> print(bar_plot)
