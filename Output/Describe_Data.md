
> source("InstallPackages.R")

> source("Read_Data.R")

> # Deskriptive Statistiken
> summary(daten)
      lfdn          duration      Experimentalgruppe Attention_test   Anwendungsfeld    Vertrauensmassnahmen    Gruppe           Akzeptanz_O1   
 Min.   : 57.0   Min.   :  -1.0   Min.   :1.000      Min.   :3      Objektiv :191    Ohne Maßnahme:190       Length:375         Min.   :-77.00  
 1st Qu.:221.0   1st Qu.: 221.0   1st Qu.:2.000      1st Qu.:3      Subjektiv:184    Mit Maßnahme :185       Class :character   1st Qu.:-77.00  
 Median :360.0   Median : 285.0   Median :2.000      Median :3                                               Mode  :character   Median :  2.00  
 Mean   :362.7   Mean   : 368.1   Mean   :2.475      Mean   :3                                                                  Mean   :-35.67  
 3rd Qu.:511.0   3rd Qu.: 396.0   3rd Qu.:3.000      3rd Qu.:3                                                                  3rd Qu.:  4.00  
 Max.   :662.0   Max.   :2205.0   Max.   :4.000      Max.   :3                                                                  Max.   :  5.00  
  Akzeptanz_O2     Akzeptanz_O3     Akzeptanz_S1     Akzeptanz_S2     Akzeptanz_S3      Akzeptanz      Akzeptanz_norm.V1   Akzeptanz_binär
 Min.   :-77.00   Min.   :-77.00   Min.   :-77.00   Min.   :-77.00   Min.   :-77.00   Min.   :1.000   Min.   :-2.0687225   niedrig:168    
 1st Qu.:-77.00   1st Qu.:-77.00   1st Qu.:-77.00   1st Qu.:-77.00   1st Qu.:-77.00   1st Qu.:2.667   1st Qu.:-0.5202775   hoch   :207    
 Median :  1.00   Median :  1.00   Median :-77.00   Median :-77.00   Median :-77.00   Median :3.333   Median : 0.0991005                  
 Mean   :-35.86   Mean   :-35.98   Mean   :-37.83   Mean   :-37.96   Mean   :-38.03   Mean   :3.227   Mean   : 0.0000000                  
 3rd Qu.:  4.00   3rd Qu.:  4.00   3rd Qu.:  3.00   3rd Qu.:  2.00   3rd Qu.:  2.00   3rd Qu.:4.000   3rd Qu.: 0.7184785                  
 Max.   :  5.00   Max.   :  5.00   Max.   :  5.00   Max.   :  5.00   Max.   :  5.00   Max.   :5.000   Max.   : 1.6475454                  
 Einstellung_KI      Alter          Geschlecht                            Bildungsabschluss             Berufsstatus    GenKI_Erfahrung
 Min.   :1.167   Min.   :18.00   weiblich:175   Ohne Schulabschluss                :  0     nicht erwerbstätig: 12   sehr gering: 49   
 1st Qu.:3.333   1st Qu.:27.00   männlich:198   Volks- oder Hauptschulabschluss    :  1     erwerbstätig      :291   gering     : 95   
 Median :3.750   Median :38.00   divers  :  2   Mittlere Reife (Realschulabschluss): 27     im Studium        : 63   mittel     :145   
 Mean   :3.651   Mean   :39.14                  Abitur oder Fachabitur             :144     in der Ausbildung :  9   hoch       : 69   
 3rd Qu.:4.083   3rd Qu.:50.00                  Hochschulabschluss                 :196                              sehr hoch  : 17   
 Max.   :5.000   Max.   :78.00                  Promotion oder Habilitation        :  7                                                
           Berufserfahrung objektiv_subjektiv
 keine             :  7    Objektiv :196     
 weniger als 1 Jahr:  6    Subjektiv:179     
 1-5 Jahre         : 75                      
 5-10 Jahre        : 43                      
 mehr als 10 Jahre :244                      
                                             

> skim(daten)
── Data Summary ────────────────────────
                           Values
Name                       daten 
Number of rows             375   
Number of columns          24    
_______________________          
Column type frequency:           
  character                1     
  factor                   9     
  numeric                  14    
________________________         
Group variables            None  

── Variable type: character ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  skim_variable n_missing complete_rate min max empty n_unique whitespace
1 Gruppe                0             1  23  25     0        4          0

── Variable type: factor ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  skim_variable        n_missing complete_rate ordered n_unique top_counts                         
1 Anwendungsfeld               0             1 FALSE          2 Obj: 191, Sub: 184                 
2 Vertrauensmassnahmen         0             1 FALSE          2 Ohn: 190, Mit: 185                 
3 Akzeptanz_binär              0             1 FALSE          2 hoc: 207, nie: 168                 
4 Geschlecht                   0             1 FALSE          3 män: 198, wei: 175, div: 2         
5 Bildungsabschluss            0             1 FALSE          5 Hoc: 196, Abi: 144, Mit: 27, Pro: 7
6 Berufsstatus                 0             1 FALSE          4 erw: 291, im : 63, nic: 12, in : 9 
7 GenKI_Erfahrung              0             1 FALSE          5 mit: 145, ger: 95, hoc: 69, seh: 49
8 Berufserfahrung              0             1 FALSE          5 meh: 244, 1-5: 75, 5-1: 43, kei: 7 
9 objektiv_subjektiv           0             1 FALSE          2 Obj: 196, Sub: 179                 

── Variable type: numeric ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   skim_variable      n_missing complete_rate      mean      sd     p0     p25      p50     p75    p100 hist 
 1 lfdn                       0             1  3.63e+ 2 172.     57    221     360      511      662    ▇▇▇▇▇
 2 duration                   0             1  3.68e+ 2 304.     -1    221     285      396     2205    ▇▂▁▁▁
 3 Experimentalgruppe         0             1  2.47e+ 0   1.06    1      2       2        3        4    ▆▇▁▇▆
 4 Attention_test             0             1  3   e+ 0   0       3      3       3        3        3    ▁▁▇▁▁
 5 Akzeptanz_O1               0             1 -3.57e+ 1  40.6   -77    -77       2        4        5    ▇▁▁▁▇
 6 Akzeptanz_O2               0             1 -3.59e+ 1  40.4   -77    -77       1        4        5    ▇▁▁▁▇
 7 Akzeptanz_O3               0             1 -3.60e+ 1  40.3   -77    -77       1        4        5    ▇▁▁▁▇
 8 Akzeptanz_S1               0             1 -3.78e+ 1  40.0   -77    -77     -77        3        5    ▇▁▁▁▇
 9 Akzeptanz_S2               0             1 -3.80e+ 1  39.8   -77    -77     -77        2        5    ▇▁▁▁▇
10 Akzeptanz_S3               0             1 -3.80e+ 1  39.8   -77    -77     -77        2        5    ▇▁▁▁▇
11 Akzeptanz                  0             1  3.23e+ 0   1.08    1      2.67    3.33     4        5    ▃▃▇▇▅
12 Akzeptanz_norm             0             1  6.98e-17   1      -2.07  -0.520   0.0991   0.718    1.65 ▃▃▇▇▅
13 Einstellung_KI             0             1  3.65e+ 0   0.625   1.17   3.33    3.75     4.08     5    ▁▁▃▇▃
14 Alter                      0             1  3.91e+ 1  13.1    18     27      38       50       78    ▇▇▆▃▁

> # Deskriptive Statistiken für jede Gruppe
> daten %>% group_by(Gruppe) %>% skim(Akzeptanz)
── Data Summary ────────────────────────
                           Values    
Name                       Piped data
Number of rows             375       
Number of columns          24        
_______________________              
Column type frequency:               
  numeric                  1         
________________________             
Group variables            Gruppe    

── Variable type: numeric ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  skim_variable Gruppe                    n_missing complete_rate mean    sd   p0  p25  p50  p75 p100 hist 
1 Akzeptanz     Objektiv - Mit Maßnahme           0             1 3.86 0.787 1.33 3.33 4    4.33    5 ▁▂▃▇▇
2 Akzeptanz     Objektiv - Ohne Maßnahme          0             1 3.77 0.730 1.33 3.33 4    4.33    5 ▁▁▃▇▅
3 Akzeptanz     Subjektiv - Mit Maßnahme          0             1 2.63 1.01  1    2    2.67 3.25    5 ▅▃▇▃▁
4 Akzeptanz     Subjektiv - Ohne Maßnahme         0             1 2.60 1.01  1    2    2.67 3.33    5 ▆▆▇▅▁

> descriptive_stats <- daten %>%
+   group_by(Gruppe) %>%
+   summarise(
+     Mittelwert = mean(Akzeptanz, na.rm = TRUE),
+     Median = median(Akzeptanz, na.rm = TRUE),
+     Standardabweichung = sd(Akzeptanz, na.rm = TRUE),
+     Varianz = var(Akzeptanz, na.rm = TRUE),
+     Minimum = min(Akzeptanz, na.rm = TRUE),
+     Maximum = max(Akzeptanz, na.rm = TRUE),
+     Anzahl = n()
+   ) %>% print()
# A tibble: 4 × 8
  Gruppe                    Mittelwert Median Standardabweichung Varianz Minimum Maximum Anzahl
  <chr>                          <dbl>  <dbl>              <dbl>   <dbl>   <dbl>   <dbl>  <int>
1 Objektiv - Mit Maßnahme         3.86   4                 0.787   0.619    1.33       5    107
2 Objektiv - Ohne Maßnahme        3.77   4                 0.730   0.533    1.33       5     84
3 Subjektiv - Mit Maßnahme        2.63   2.67              1.01    1.02     1          5     78
4 Subjektiv - Ohne Maßnahme       2.60   2.67              1.01    1.02     1          5    106

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
