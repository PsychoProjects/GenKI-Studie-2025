
> source("InstallPackages.R")

> source("Read_Data.R")

> # Cronbachs Alpha sollte hoch (>=0.9) sein (Stein et al. 2024)
> attari_daten <- rohdaten %>% select(starts_with("ATTARI"))

> attari_daten$Einstellung_KI <- daten$Einstellung_KI

> alpha(attari_daten)

Reliability analysis   
Call: alpha(x = attari_daten)

  raw_alpha std.alpha G6(smc) average_r S/N    ase mean   sd median_r
      0.92      0.92    0.92      0.48  12 0.0065  3.7 0.63     0.48

    95% confidence boundaries 
         lower alpha upper
Feldt      0.9  0.92  0.93
Duhachek   0.9  0.92  0.93

 Reliability if an item is dropped:
               raw_alpha std.alpha G6(smc) average_r  S/N alpha se var.r med.r
ATTARI12_1          0.91      0.92    0.97      0.48 11.1   0.0070 0.022  0.48
ATTARI12_2          0.91      0.92    0.97      0.48 11.1   0.0070 0.021  0.47
ATTARI12_3          0.91      0.92    0.97      0.48 11.1   0.0070 0.021  0.49
ATTARI12_4          0.91      0.92    0.96      0.48 11.1   0.0071 0.022  0.47
ATTARI12_5          0.91      0.91    0.97      0.47 10.7   0.0072 0.021  0.47
ATTARI12_6          0.92      0.92    0.96      0.50 12.2   0.0064 0.018  0.51
ATTARI12_7          0.91      0.92    0.96      0.48 10.9   0.0071 0.021  0.48
ATTARI12_8          0.92      0.93    0.95      0.51 12.4   0.0061 0.016  0.50
ATTARI12_9          0.91      0.92    0.96      0.49 11.8   0.0067 0.021  0.50
ATTARI12_10         0.91      0.92    0.97      0.48 10.9   0.0071 0.022  0.47
ATTARI12_11         0.91      0.92    0.97      0.48 10.9   0.0072 0.022  0.47
ATTARI12_12         0.91      0.91    0.97      0.47 10.7   0.0072 0.021  0.47
Einstellung_KI      0.90      0.90    0.91      0.44  9.4   0.0076 0.012  0.46

 Item statistics 
                 n raw.r std.r r.cor r.drop mean   sd
ATTARI12_1     375  0.71  0.72  0.69   0.65  3.6 0.85
ATTARI12_2     375  0.73  0.72  0.70   0.66  3.8 0.91
ATTARI12_3     375  0.70  0.71  0.69   0.65  4.0 0.76
ATTARI12_4     375  0.72  0.72  0.70   0.66  3.5 0.93
ATTARI12_5     375  0.78  0.78  0.77   0.73  3.9 0.88
ATTARI12_6     375  0.55  0.55  0.49   0.46  3.6 0.95
ATTARI12_7     375  0.74  0.75  0.72   0.69  3.5 0.94
ATTARI12_8     375  0.55  0.53  0.47   0.44  3.6 1.11
ATTARI12_9     375  0.61  0.62  0.57   0.54  3.2 0.90
ATTARI12_10    375  0.74  0.75  0.73   0.69  3.7 0.83
ATTARI12_11    375  0.76  0.75  0.73   0.70  3.1 0.92
ATTARI12_12    375  0.78  0.78  0.77   0.73  4.1 0.84
Einstellung_KI 375  1.00  1.00  0.93   1.00  3.7 0.63

> # Es ist zu erwarten, dass das Histogramm links-schief ist (Stein et al. 2024)
> # Analyse der Einstellung_KI (ATTARI-12)
> daten %>% skim(Einstellung_KI) 
── Data Summary ────────────────────────
                           Values    
Name                       Piped data
Number of rows             375       
Number of columns          24        
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
     Schiefe Kurtosis
1 -0.6776902 3.835465

> # Histogramm der Verteilung der Einstellung_KI mit Normalverteilungsanpassung
> ggplot(daten, aes(x = Einstellung_KI)) +
+   geom_histogram(aes(y = ..density..), bins = 10, fill = "lightblue", color = "black") +
+   geom_density(alpha = 0.2, fill = "red") +
+   labs(title = "Verteilung der Einstellung KI",
+        x = "Einstellung",
+        y = "Dichte") +
+   theme_minimal()

> # Vereilung nach Geschlecht
> daten %>% group_by(Geschlecht) %>% skim(Einstellung_KI) 
── Data Summary ────────────────────────
                           Values    
Name                       Piped data
Number of rows             375       
Number of columns          24        
_______________________              
Column type frequency:               
  numeric                  1         
________________________             
Group variables            Geschlecht

── Variable type: numeric ────────────────────────────────────────────────────────────────────────────────────────────────────
  skim_variable  Geschlecht n_missing complete_rate mean    sd   p0  p25  p50  p75 p100 hist 
1 Einstellung_KI weiblich           0             1 3.52 0.627 1.17 3.21 3.58 3.92  5   ▁▁▅▇▂
2 Einstellung_KI männlich           0             1 3.77 0.597 1.83 3.5  3.83 4.17  5   ▁▂▅▇▃
3 Einstellung_KI divers             0             1 2.92 0.825 2.33 2.62 2.92 3.21  3.5 ▇▁▁▁▇

> daten %>% group_by(Geschlecht) %>% 
+   summarise(
+     Schiefe = skewness(Einstellung_KI), 
+     Kurtosis = kurtosis(Einstellung_KI)) 
# A tibble: 3 × 3
  Geschlecht   Schiefe Kurtosis
  <fct>          <dbl>    <dbl>
1 weiblich   -7.02e- 1     4.11
2 männlich   -6.86e- 1     3.65
3 divers     -1.12e-15     1   

> # Histogramm der Verteilung der Einstellung_KI mit Normalverteilungsanpassung gruppiert nach Geschlecht
> ggplot(daten, aes(x = Einstellung_KI, fill = Geschlecht)) +
+   geom_histogram(aes(y = ..density..), bins = 10, color = "black", position = "dodge") +
+   geom_density(alpha = 0.2, position = "dodge") +
+   labs(title = "Verteilung der Einstellung KI",
+        x = "Einstellung",
+        y = "Dichte") +
+   theme_minimal()
