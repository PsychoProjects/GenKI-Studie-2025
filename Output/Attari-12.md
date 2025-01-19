
> source("InstallPackages.R")

> source("Read_Data.R")

> # Analyse der Einstellung_KI (ATTARI-12)
> daten %>% skim(Einstellung_KI) 
── Data Summary ────────────────────────
                           Values    
Name                       Piped data
Number of rows             365       
Number of columns          17        
_______________________              
Column type frequency:               
  numeric                  1         
________________________             
Group variables            None      

── Variable type: numeric ────────────────────────────────────────────────────────────────────────────────────────────────────
  skim_variable  n_missing complete_rate mean    sd   p0  p25  p50  p75 p100 hist 
1 Einstellung_KI         0             1 3.65 0.631 1.17 3.33 3.75 4.08    5 ▁▁▃▇▃

> daten %>% summarise(
+   Schiefe = skewness(Einstellung_KI), 
+   Kurtosis = kurtosis(Einstellung_KI)) 
     Schiefe  Kurtosis
1 -0.6814127 0.7800833

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
Number of rows             365       
Number of columns          17        
_______________________              
Column type frequency:               
  numeric                  1         
________________________             
Group variables            Geschlecht

── Variable type: numeric ────────────────────────────────────────────────────────────────────────────────────────────────────
  skim_variable  Geschlecht n_missing complete_rate mean    sd   p0  p25  p50  p75 p100 hist 
1 Einstellung_KI weiblich           0             1 3.53 0.634 1.17 3.25 3.58 3.92  5   ▁▁▅▇▂
2 Einstellung_KI männlich           0             1 3.77 0.603 1.83 3.5  3.83 4.17  5   ▁▂▅▇▃
3 Einstellung_KI divers             0             1 2.92 0.825 2.33 2.62 2.92 3.21  3.5 ▇▁▁▁▇

> daten %>% group_by(Geschlecht) %>% 
+   summarise(
+     Schiefe = skewness(Einstellung_KI), 
+     Kurtosis = kurtosis(Einstellung_KI)) 
# A tibble: 3 × 3
  Geschlecht   Schiefe Kurtosis
  <fct>          <dbl>    <dbl>
1 weiblich   -7.15e- 1    1.02 
2 männlich   -6.70e- 1    0.554
3 divers     -3.95e-16   -2.75 

> # Histogramm der Verteilung der Einstellung_KI mit Normalverteilungsanpassung gruppiert nach Geschlecht
> ggplot(daten, aes(x = Einstellung_KI, fill = Geschlecht)) +
+   geom_histogram(aes(y = ..density..), bins = 10, color = "black", position = "dodge") +
+   geom_density(alpha = 0.2, position = "dodge") +
+   labs(title = "Verteilung der Einstellung KI",
+        x = "Einstellung",
+        y = "Dichte") +
+   theme_minimal()
