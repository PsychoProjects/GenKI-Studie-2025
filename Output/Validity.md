
> source("InstallPackages.R")

> source("Read_Data.R")
[1] "Daten werden geladen..."

> # Analysen zur Einschätzung der Objektivität bzw. Subjektivität der Anwendungsfelder
> table_val <- table(daten$Anwendungsfeld, daten$objektiv_subjektiv)

> ## Umwandlung in DataFrame mit Prozentwerten innerhalb jedes Anwendungsfelds
> table_df <- as.data.frame(table_val) %>%
+   group_by(Var1) %>%  # Gruppierung nach Anwendungsfeld
+   mutate(Prozent = round(Freq / sum(Freq) * 100, 2)) %>%
+   arrange(Var1)  # Sortierung nach Anwendungsfeld

> ## Tabelle ausgeben mit Anwendungsfeld, Einschätzung, Häufigkeit und Prozentanteil
> kable(table_df, 
+       col.names = c("Anwendungsfeld", "Einschätzung", "Häufigkeit", "Prozent"),
+       caption = "Kreuztabelle der Übereinstimmung von Anwendungsfeld und objektiv-subjektiv-Einschätzung")


Table: Kreuztabelle der Übereinstimmung von Anwendungsfeld und objektiv-subjektiv-Einschätzung

|Anwendungsfeld |Einschätzung | Häufigkeit| Prozent|
|:--------------|:------------|----------:|-------:|
|Objektiv       |Objektiv     |        168|   87.96|
|Objektiv       |Subjektiv    |         23|   12.04|
|Subjektiv      |Objektiv     |         28|   15.22|
|Subjektiv      |Subjektiv    |        156|   84.78|

> ## Chi-Quadrat-Test zur Überprüfung der Verteilung
> chitest <- chisq.test(table_val) 

> print(chitest)

	Pearson's Chi-squared test with Yates' continuity correction

data:  table_val
X-squared = 195.85, df = 1, p-value < 2.2e-16


> ### Effektstärke Cramer's V berechnen
> cramers_v(chitest)
Cramer's V (adj.) |       95% CI
--------------------------------
0.73              | [0.64, 1.00]

- One-sided CIs: upper bound fixed at [1.00].
> ## Korrelationsanalyse zwischen Anwendungsfeld und objektiv-subjektiv-Einschätzung
> cor.test(as.numeric(daten$Anwendungsfeld), as.numeric(daten$objektiv_subjektiv), method = "kendall")

	Kendall's rank correlation tau

data:  as.numeric(daten$Anwendungsfeld) and as.numeric(daten$objektiv_subjektiv)
z = 14.079, p-value < 2.2e-16
alternative hypothesis: true tau is not equal to 0
sample estimates:
     tau 
0.728029 


> # Cronbach's Alpha, um zu prüfen, ob die Items zur Messung der Akzeptanz konsistent sind. Werte über 0.7 gelten als akzeptabel.
> ## Objektive Anwendungsfelder
> obj_daten <- daten %>% filter(Anwendungsfeld == "Objektiv") %>% select(starts_with("Akzeptanz_O"))

> ca <- alpha(obj_daten)

> ### Konfidenzintervall ergänzen
> ca_stats <- ca$total %>% mutate(
+   CI_lower = raw_alpha - 1.96 * ase,
+   CI_upper = raw_alpha + 1.96 * ase,
+   df = nrow(obj_daten) - 1
+ )

> kable(ca_stats, digits = 2, caption = "Gesamtergebnis der Reliabilitätsanalyse für objektive Anwendungsfelder")


Table: Gesamtergebnis der Reliabilitätsanalyse für objektive Anwendungsfelder

|   | raw_alpha| std.alpha| G6(smc)| average_r|  S/N|  ase| mean|   sd| median_r| CI_lower| CI_upper|  df|
|:--|---------:|---------:|-------:|---------:|----:|----:|----:|----:|--------:|--------:|--------:|---:|
|   |      0.71|      0.71|    0.63|      0.45| 2.44| 0.04| 3.82| 0.76|     0.47|     0.63|     0.78| 190|

> kable(ca$item.stats, digits = 2, caption = "Item-Statistiken der Reliabilitätsanalyse für objektive Anwendungsfelder")


Table: Item-Statistiken der Reliabilitätsanalyse für objektive Anwendungsfelder

|             |   n| raw.r| std.r| r.cor| r.drop| mean|   sd|
|:------------|---:|-----:|-----:|-----:|------:|----:|----:|
|Akzeptanz_O1 | 191|  0.81|  0.83|  0.70|   0.59| 4.15| 0.89|
|Akzeptanz_O2 | 191|  0.79|  0.78|  0.61|   0.50| 3.77| 0.99|
|Akzeptanz_O3 | 191|  0.78|  0.77|  0.58|   0.49| 3.54| 1.00|

> ## Subjektive Anwendungsfelder
> subj_daten <- daten %>% filter(Anwendungsfeld == "Subjektiv") %>% select(starts_with("Akzeptanz_S"))

> ca <- alpha(subj_daten)

> ### Konfidenzintervall ergänzen
> ca_stats <- ca$total %>% mutate(
+   CI_lower = raw_alpha - 1.96 * ase,
+   CI_upper = raw_alpha + 1.96 * ase,
+   df = nrow(subj_daten) - 1
+ )

> kable(ca_stats, digits = 2, caption = "Gesamtergebnis der Reliabilitätsanalyse für subjektive Anwendungsfelder")


Table: Gesamtergebnis der Reliabilitätsanalyse für subjektive Anwendungsfelder

|   | raw_alpha| std.alpha| G6(smc)| average_r|  S/N|  ase| mean|   sd| median_r| CI_lower| CI_upper|  df|
|:--|---------:|---------:|-------:|---------:|----:|----:|----:|----:|--------:|--------:|--------:|---:|
|   |      0.83|      0.83|    0.77|      0.61| 4.76| 0.02| 2.61| 1.01|     0.62|     0.78|     0.87| 183|

> kable(ca$item.stats, digits = 2, caption = "Item-Statistiken der Reliabilitätsanalyse für subjektive Anwendungsfelder")


Table: Item-Statistiken der Reliabilitätsanalyse für subjektive Anwendungsfelder

|             |   n| raw.r| std.r| r.cor| r.drop| mean|   sd|
|:------------|---:|-----:|-----:|-----:|------:|----:|----:|
|Akzeptanz_S1 | 184|  0.89|  0.89|  0.82|   0.74| 2.84| 1.19|
|Akzeptanz_S2 | 184|  0.86|  0.86|  0.75|   0.68| 2.57| 1.16|
|Akzeptanz_S3 | 184|  0.83|  0.83|  0.69|   0.63| 2.43| 1.16|

> # Korrelation zwischen den Akzeptanz-Items sollte hoch sein
> correlation_matrix <- cor(obj_daten, use = "complete.obs")

> kable(correlation_matrix, digits = 2, caption = "Korrelationsmatrix der Akzeptanz-Items (Objektive Anwendungsfelder)")


Table: Korrelationsmatrix der Akzeptanz-Items (Objektive Anwendungsfelder)

|             | Akzeptanz_O1| Akzeptanz_O2| Akzeptanz_O3|
|:------------|------------:|------------:|------------:|
|Akzeptanz_O1 |         1.00|         0.50|         0.47|
|Akzeptanz_O2 |         0.50|         1.00|         0.37|
|Akzeptanz_O3 |         0.47|         0.37|         1.00|

> correlation_matrix <- cor(subj_daten, use = "complete.obs")

> kable(correlation_matrix, digits = 2, caption = "Korrelationsmatrix der Akzeptanz-Items (Subjektive Anwendungsfelder)")


Table: Korrelationsmatrix der Akzeptanz-Items (Subjektive Anwendungsfelder)

|             | Akzeptanz_S1| Akzeptanz_S2| Akzeptanz_S3|
|:------------|------------:|------------:|------------:|
|Akzeptanz_S1 |         1.00|         0.68|         0.62|
|Akzeptanz_S2 |         0.68|         1.00|         0.54|
|Akzeptanz_S3 |         0.62|         0.54|         1.00|
