
> source("InstallPackages.R")

> source("Read_Data.R")
[1] "Daten werden geladen..."

> # Cronbachs Alpha sollte hoch (>=0.9) sein (Stein et al. 2024)
> attari_daten <- daten %>% select(starts_with("ATTARI"))

> ca <- alpha(attari_daten)

> # Konfidenzintervall ergänzen
> ca_stats <- ca$total %>% mutate(
+   CI_lower = raw_alpha - 1.96 * ase,
+   CI_upper = raw_alpha + 1.96 * ase,
+   df = nrow(attari_daten) - 1
+ )

> ## Extraktion der wichtigsten Werte für die Tabelle
> kable(ca_stats, digits = 2, caption = "Gesamtergebnis der Reliabilitätsanalyse")


Table: Gesamtergebnis der Reliabilitätsanalyse

|   | raw_alpha| std.alpha| G6(smc)| average_r|  S/N|  ase| mean|   sd| median_r| CI_lower| CI_upper|  df|
|:--|---------:|---------:|-------:|---------:|----:|----:|----:|----:|--------:|--------:|--------:|---:|
|   |       0.9|       0.9|    0.91|      0.44| 9.45| 0.01| 3.65| 0.63|     0.46|     0.89|     0.92| 374|

> ## Ausgabe aller Items
> kable(ca$item.stats, digits = 2, caption = "Item-Statistiken der Reliabilitätsanalyse")


Table: Item-Statistiken der Reliabilitätsanalyse

|            |   n| raw.r| std.r| r.cor| r.drop| mean|   sd|
|:-----------|---:|-----:|-----:|-----:|------:|----:|----:|
|ATTARI12_1  | 375|  0.71|  0.72|  0.69|   0.65| 3.61| 0.85|
|ATTARI12_2  | 375|  0.73|  0.72|  0.70|   0.66| 3.76| 0.91|
|ATTARI12_3  | 375|  0.70|  0.72|  0.69|   0.64| 4.04| 0.76|
|ATTARI12_4  | 375|  0.72|  0.72|  0.69|   0.66| 3.55| 0.93|
|ATTARI12_5  | 375|  0.78|  0.78|  0.77|   0.72| 3.94| 0.88|
|ATTARI12_6  | 375|  0.55|  0.55|  0.49|   0.45| 3.59| 0.95|
|ATTARI12_7  | 375|  0.74|  0.75|  0.72|   0.68| 3.54| 0.94|
|ATTARI12_8  | 375|  0.55|  0.52|  0.46|   0.43| 3.65| 1.11|
|ATTARI12_9  | 375|  0.61|  0.62|  0.56|   0.53| 3.21| 0.90|
|ATTARI12_10 | 375|  0.74|  0.75|  0.72|   0.69| 3.71| 0.83|
|ATTARI12_11 | 375|  0.76|  0.75|  0.73|   0.70| 3.13| 0.92|
|ATTARI12_12 | 375|  0.78|  0.78|  0.77|   0.73| 4.11| 0.84|

> ## Es ist zu erwarten, dass das Histogramm links-schief ist (Stein et al. 2024)
> daten %>% skim(Einstellung_KI) 
── Data Summary ────────────────────────
                           Values    
Name                       Piped data
Number of rows             375       
Number of columns          37        
_______________________              
Column type frequency:               
  numeric                  1         
________________________             
Group variables            None      

── Variable type: numeric ────────────────────────────────────────────────────────────────────────────────────────────────────
  skim_variable  n_missing complete_rate mean    sd   p0  p25  p50  p75 p100 hist 
1 Einstellung_KI         0             1 3.65 0.625 1.17 3.33 3.75 4.08    5 ▁▁▃▇▃

> daten %>% summarise(
+   Schiefe = skewness(Einstellung_KI), 
+   Kurtosis = kurtosis(Einstellung_KI)) 
  Schiefe.Skewness Schiefe.SE Kurtosis.Kurtosis Kurtosis.SE
1       -0.6804149  0.1254845         0.8628851   0.2479828

> # Histogramm der Verteilung der Einstellung_KI mit Normalverteilungsanpassung
> ggplot(daten, aes(x = Einstellung_KI)) +
+   geom_histogram(aes(y = after_stat(density)), bins = 10, fill = "lightblue", color = "black") +
+   geom_density(alpha = 0.2, fill = "red") +
+   labs(title = "Verteilung der Einstellung KI",
+        x = "Einstellung",
+        y = "Dichte") +
+   theme_minimal()
