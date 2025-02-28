
> source("InstallPackages.R")

> source("Read_Data.R")
[1] "Daten werden geladen..."

> # Akzeptanz-Analysen
> conf_int_low <- function(x) t.test(x, conf.level = 0.95)$conf.int[1]

> conf_int_high <- function(x) t.test(x, conf.level = 0.95)$conf.int[2]

> berechne_statistiken <- function(df, variable) {
+   df %>%
+     summarise(
+       Mittelwert = mean({{ variable }}, na.rm = TRUE),
+       KI_von = conf_int_low({{ variable }}),
+       KI_bis = conf_int_high({{ variable }}),
+       Median = median({{ variable }}, na.rm = TRUE),
+       Standardabweichung = sd({{ variable }}, na.rm = TRUE),
+       Varianz = var({{ variable }}, na.rm = TRUE),
+       Minimum = min({{ variable }}, na.rm = TRUE),
+       Maximum = max({{ variable }}, na.rm = TRUE),
+       Anzahl = n()
+     )
+ }

> ## Deskriptive Statistiken gesamt
> daten %>%
+   berechne_statistiken(Akzeptanz) %>%
+   kable(caption = "Statistiken zur Akzeptanz", digits = 2)


Table: Statistiken zur Akzeptanz

| Mittelwert| KI_von| KI_bis| Median| Standardabweichung| Varianz| Minimum| Maximum| Anzahl|
|----------:|------:|------:|------:|------------------:|-------:|-------:|-------:|------:|
|       3.23|   3.12|   3.34|   3.33|               1.08|    1.16|       1|       5|    375|

> ## Deskriptive Statistiken für jede Gruppe
> daten %>%
+   group_by(Gruppe) %>%
+   berechne_statistiken(Akzeptanz) %>%
+   kable(caption = "Statistiken zur Akzeptanz je Gruppe", digits = 2)


Table: Statistiken zur Akzeptanz je Gruppe

|Gruppe                    | Mittelwert| KI_von| KI_bis| Median| Standardabweichung| Varianz| Minimum| Maximum| Anzahl|
|:-------------------------|----------:|------:|------:|------:|------------------:|-------:|-------:|-------:|------:|
|Objektiv - Mit Maßnahme   |       3.86|   3.71|   4.01|   4.00|               0.79|    0.62|    1.33|       5|    107|
|Objektiv - Ohne Maßnahme  |       3.77|   3.62|   3.93|   4.00|               0.73|    0.53|    1.33|       5|     84|
|Subjektiv - Mit Maßnahme  |       2.63|   2.40|   2.86|   2.67|               1.01|    1.02|    1.00|       5|     78|
|Subjektiv - Ohne Maßnahme |       2.60|   2.40|   2.79|   2.67|               1.01|    1.02|    1.00|       5|    106|

> ## Deskriptive Statistiken für jedes Anwendungsfeld
> daten %>%
+   group_by(Anwendungsfeld) %>%
+   berechne_statistiken(Akzeptanz) %>%
+   kable(caption = "Statistiken zur Akzeptanz je Anwendungsfeld", digits = 2)


Table: Statistiken zur Akzeptanz je Anwendungsfeld

|Anwendungsfeld | Mittelwert| KI_von| KI_bis| Median| Standardabweichung| Varianz| Minimum| Maximum| Anzahl|
|:--------------|----------:|------:|------:|------:|------------------:|-------:|-------:|-------:|------:|
|Objektiv       |       3.82|   3.71|   3.93|   4.00|               0.76|    0.58|    1.33|       5|    191|
|Subjektiv      |       2.61|   2.46|   2.76|   2.67|               1.01|    1.02|    1.00|       5|    184|

> ## Deskriptive Statistiken für die Maßnahmen
> daten %>% 
+   group_by(Vertrauensmassnahmen) %>%
+   berechne_statistiken(Akzeptanz) %>%
+   kable(caption = "Statistiken zur Akzeptanz je Vertrauensmaßnahme", digits = 2)


Table: Statistiken zur Akzeptanz je Vertrauensmaßnahme

|Vertrauensmassnahmen | Mittelwert| KI_von| KI_bis| Median| Standardabweichung| Varianz| Minimum| Maximum| Anzahl|
|:--------------------|----------:|------:|------:|------:|------------------:|-------:|-------:|-------:|------:|
|Ohne Maßnahme        |       3.12|   2.96|   3.27|   3.33|               1.07|    1.14|       1|       5|    190|
|Mit Maßnahme         |       3.34|   3.18|   3.49|   3.33|               1.07|    1.16|       1|       5|    185|

> # Einstellungs-Analysen
> ## Deskriptive Statistiken gesamt
> daten %>%
+   berechne_statistiken(Einstellung_KI) %>%
+   kable(caption = "Statistiken zur Einstellung_KI", digits = 2)


Table: Statistiken zur Einstellung_KI

| Mittelwert| KI_von| KI_bis| Median| Standardabweichung| Varianz| Minimum| Maximum| Anzahl|
|----------:|------:|------:|------:|------------------:|-------:|-------:|-------:|------:|
|       3.65|   3.59|   3.71|   3.75|               0.63|    0.39|    1.17|       5|    375|

> ## Deskriptive Statistiken für jede Gruppe
> daten %>% 
+   group_by(Gruppe) %>%
+   berechne_statistiken(Einstellung_KI) %>%
+   kable(caption = "Statistiken zur Einstellung_KI je Gruppe", digits = 2)


Table: Statistiken zur Einstellung_KI je Gruppe

|Gruppe                    | Mittelwert| KI_von| KI_bis| Median| Standardabweichung| Varianz| Minimum| Maximum| Anzahl|
|:-------------------------|----------:|------:|------:|------:|------------------:|-------:|-------:|-------:|------:|
|Objektiv - Mit Maßnahme   |       3.70|   3.59|   3.82|   3.75|               0.61|    0.38|    2.00|    5.00|    107|
|Objektiv - Ohne Maßnahme  |       3.57|   3.43|   3.71|   3.58|               0.64|    0.42|    1.17|    4.83|     84|
|Subjektiv - Mit Maßnahme  |       3.71|   3.56|   3.85|   3.75|               0.64|    0.41|    1.50|    5.00|     78|
|Subjektiv - Ohne Maßnahme |       3.62|   3.50|   3.73|   3.75|               0.61|    0.37|    1.83|    4.92|    106|

> ## Deskriptive Statistiken für jedes Anwendungsfeld
> daten %>% 
+   group_by(Anwendungsfeld) %>%
+   berechne_statistiken(Einstellung_KI) %>%
+   kable(caption = "Statistiken zur Einstellung_KI je Anwendungsfeld", digits = 2)


Table: Statistiken zur Einstellung_KI je Anwendungsfeld

|Anwendungsfeld | Mittelwert| KI_von| KI_bis| Median| Standardabweichung| Varianz| Minimum| Maximum| Anzahl|
|:--------------|----------:|------:|------:|------:|------------------:|-------:|-------:|-------:|------:|
|Objektiv       |       3.65|   3.56|   3.74|   3.67|               0.63|    0.40|    1.17|       5|    191|
|Subjektiv      |       3.65|   3.56|   3.75|   3.75|               0.62|    0.39|    1.50|       5|    184|

> ## Deskrptive Statistiken für die Maßnahmen
> daten %>% 
+   group_by(Vertrauensmassnahmen) %>%
+   berechne_statistiken(Einstellung_KI) %>%
+   kable(caption = "Statistiken zur Einstellung_KI je Vertrauensmaßnahme", digits = 2)


Table: Statistiken zur Einstellung_KI je Vertrauensmaßnahme

|Vertrauensmassnahmen | Mittelwert| KI_von| KI_bis| Median| Standardabweichung| Varianz| Minimum| Maximum| Anzahl|
|:--------------------|----------:|------:|------:|------:|------------------:|-------:|-------:|-------:|------:|
|Ohne Maßnahme        |       3.60|   3.51|   3.69|   3.67|               0.62|    0.39|    1.17|    4.92|    190|
|Mit Maßnahme         |       3.71|   3.62|   3.80|   3.75|               0.62|    0.39|    1.50|    5.00|    185|

> # Grafische Aufbereitung
> ## Histogramm der Verteilung der Akzeptanz mit Normalverteilungsanpassung
> ggplot(daten, aes(x = Akzeptanz)) +
+   geom_histogram(aes(y = after_stat(density)), bins = 20, fill = "lightblue", color = "black") +
+   stat_function(fun = dnorm, 
+                 args = list(mean = mean(daten$Akzeptanz), sd = sd(daten$Akzeptanz)), 
+                 color = "darkblue", linewidth = 1) +
+   labs(title = "Histogramm der Verteilung der Akzeptanz",
+        x = "Akzeptanz", y = "Dichte") +
+   theme_minimal()

> ## Histogramm der Verteilung der Akzeptanz getrennt nach Anwendungsfeld
> daten %>%
+   group_by(Anwendungsfeld) %>%
+   ggplot(aes(x = Akzeptanz)) +
+   geom_histogram(aes(y = after_stat(density)), bins = 20, fill = "lightblue", color = "black") +
+   stat_function(fun = dnorm, 
+                 args = list(mean = mean(daten$Akzeptanz), sd = sd(daten$Akzeptanz)), 
+                 color = "darkblue", lwd = 1) +
+   facet_wrap(~Anwendungsfeld, scales = "free_y") +
+   labs(title = "Histogramme der Verteilung der Akzeptanz je Gruppe",
+        x = "Akzeptanz", y = "Dichte") +
+   theme_minimal()

> ## Histogramm der Verteilung der Akzeptanz getrennt nach Gruppe
> daten %>%
+   group_by(Gruppe) %>%
+   ggplot(aes(x = Akzeptanz)) +
+   geom_histogram(aes(y = after_stat(density)), bins = 20, fill = "lightblue", color = "black") +
+   stat_function(fun = dnorm, 
+                 args = list(mean = mean(daten$Akzeptanz), sd = sd(daten$Akzeptanz)), 
+                 color = "darkblue", lwd = 1) +
+   facet_wrap(~Gruppe, scales = "free_y") +
+   labs(title = "Histogramme der Verteilung der Akzeptanz je Gruppe",
+        x = "Akzeptanz", y = "Dichte") +
+   theme_minimal()

> ## Grafische Darstellung der Beziehung zwischen Einstellung_KI und Akzeptanz
> gp <- ggplot(daten, aes(x = Einstellung_KI, y = Akzeptanz)) +
+   geom_point() +
+   geom_smooth(method = "lm", col = "blue") +
+   labs(title = "Zusammenhang zwischen Einstellung_KI und Akzeptanz",
+        x = "Einstellung_KI", y = "Akzeptanz") +
+   theme_minimal()

> print(gp)

> ## Interaktion zwischen Anwendungsfeld und Vertrauensmassnahmen
> gp <- ggplot(daten, aes(x = Anwendungsfeld, y = Akzeptanz, fill = Vertrauensmassnahmen)) +
+   stat_summary(fun = mean, geom = "bar", position = "dodge") +
+   stat_summary(fun.data = mean_cl_boot, geom = "errorbar", position = position_dodge(width = 0.9), width = 0.2) +
+   labs(title = "Interaktion zwischen Anwendungsfeld und Vertrauensmassnahmen",
+        x = "Anwendungsfeld", y = "Mittelwert von Akzeptanz") +
+   theme_minimal()

> print(gp)

> ## Interaktion zwischen Einstellung_KI, Anwendungsfeld und Vertrauensmassnahmen
> gp <- ggplot(daten, aes(x = Einstellung_KI, y = Akzeptanz, color = Vertrauensmassnahmen)) +
+   geom_point() +
+   geom_smooth(method = "lm") +
+   facet_wrap(~ Anwendungsfeld) +
+   labs(title = "Interaktion zwischen Einstellung_KI, Anwendungsfeld und Vertrauensmassnahmen",
+        x = "Einstellung_KI", y = "Akzeptanz") +
+   theme_minimal()

> print(gp)

> ## Boxplot zur Visualisierung der Verteilung der Akzeptanz in den vier Gruppen
> box_plot <- ggplot(daten, aes(x = Gruppe, y = Akzeptanz, fill = Gruppe)) +
+   geom_boxplot() +
+   scale_x_discrete(labels = c("O1", "o0", "s1", "S0")) +
+   labs(title = "Verteilung der Akzeptanz in den vier Gruppen",
+        x = "Gruppe", y = "Akzeptanz") +
+   theme_minimal()

> print(box_plot)

> ## Barplot zur Visualisierung der Mittelwerte und Konfidenzintervalle der Akzeptanz in den vier Gruppen
> bar_plot <- ggplot(daten, aes(x = Gruppe, y = Akzeptanz, fill = Gruppe)) +
+   stat_summary(fun = mean, geom = "bar", position = "dodge") +
+   stat_summary(fun.data = mean_cl_boot, geom = "errorbar", position = position_dodge(width = 0.9), width = 0.2) +
+   scale_x_discrete(labels = c("O1", "o0", "s1", "S0")) +
+   labs(title = "Mittelwert der Akzeptanz in den vier Gruppen",
+        x = "Gruppe", y = "Mittelwert von Akzeptanz") +
+   theme_minimal()

> print(bar_plot)
