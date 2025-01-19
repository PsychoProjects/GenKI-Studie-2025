
> source("InstallPackages.R")

> source("Read_Data.R")

> # Deskriptive Statistiken
> summary(daten)
      lfdn          duration      Experimentalgruppe Attention_test   Anwendungsfeld    Vertrauensmassnahmen
 Min.   : 57.0   Min.   :  -1.0   Min.   :1.000      Min.   :3      Objektiv :185    Ohne Maßnahme:186      
 1st Qu.:216.0   1st Qu.: 221.0   1st Qu.:2.000      1st Qu.:3      Subjektiv:180    Mit Maßnahme :179      
 Median :352.0   Median : 287.0   Median :2.000      Median :3                                              
 Mean   :354.9   Mean   : 371.4   Mean   :2.477      Mean   :3                                              
 3rd Qu.:502.0   3rd Qu.: 401.0   3rd Qu.:3.000      3rd Qu.:3                                              
 Max.   :638.0   Max.   :2205.0   Max.   :4.000      Max.   :3                                              
    Gruppe            Akzeptanz      Akzeptanz_norm.V1   Akzeptanz_binär Einstellung_KI      Alter          Geschlecht 
 Length:365         Min.   :1.000   Min.   :-2.0888891   niedrig:163     Min.   :1.167   Min.   :18.00   weiblich:170  
 Class :character   1st Qu.:2.667   1st Qu.:-0.5277824   hoch   :202     1st Qu.:3.333   1st Qu.:27.00   männlich:193  
 Mode  :character   Median :3.333   Median : 0.0966603                   Median :3.750   Median :38.00   divers  :  2  
                    Mean   :3.230   Mean   : 0.0000000                   Mean   :3.653   Mean   :39.16                 
                    3rd Qu.:4.000   3rd Qu.: 0.7211030                   3rd Qu.:4.083   3rd Qu.:50.00                 
                    Max.   :5.000   Max.   : 1.6577670                   Max.   :5.000   Max.   :78.00                 
                           Bildungsabschluss             Berufsstatus    GenKI_Erfahrung           Berufserfahrung
 Ohne Schulabschluss                :  0     nicht erwerbstätig: 12   sehr gering: 48    keine             :  7   
 Volks- oder Hauptschulabschluss    :  1     erwerbstätig      :282   gering     : 94    weniger als 1 Jahr:  6   
 Mittlere Reife (Realschulabschluss): 26     im Studium        : 62   mittel     :139    1-5 Jahre         : 74   
 Abitur oder Fachabitur             :144     in der Ausbildung :  9   hoch       : 67    5-10 Jahre        : 42   
 Hochschulabschluss                 :187                              sehr hoch  : 17    mehr als 10 Jahre :236   
 Promotion oder Habilitation        :  7                                                                          

> skim(daten)
── Data Summary ────────────────────────
                           Values
Name                       daten 
Number of rows             365   
Number of columns          17    
_______________________          
Column type frequency:           
  character                1     
  factor                   8     
  numeric                  8     
________________________         
Group variables            None  

── Variable type: character ──────────────────────────────────────────────────────────────────────────────────────────────────
  skim_variable n_missing complete_rate min max empty n_unique whitespace
1 Gruppe                0             1  23  25     0        4          0

── Variable type: factor ─────────────────────────────────────────────────────────────────────────────────────────────────────
  skim_variable        n_missing complete_rate ordered n_unique top_counts                         
1 Anwendungsfeld               0             1 FALSE          2 Obj: 185, Sub: 180                 
2 Vertrauensmassnahmen         0             1 FALSE          2 Ohn: 186, Mit: 179                 
3 Akzeptanz_binär              0             1 FALSE          2 hoc: 202, nie: 163                 
4 Geschlecht                   0             1 FALSE          3 män: 193, wei: 170, div: 2         
5 Bildungsabschluss            0             1 FALSE          5 Hoc: 187, Abi: 144, Mit: 26, Pro: 7
6 Berufsstatus                 0             1 FALSE          4 erw: 282, im : 62, nic: 12, in : 9 
7 GenKI_Erfahrung              0             1 FALSE          5 mit: 139, ger: 94, hoc: 67, seh: 48
8 Berufserfahrung              0             1 FALSE          5 meh: 236, 1-5: 74, 5-1: 42, kei: 7 

── Variable type: numeric ────────────────────────────────────────────────────────────────────────────────────────────────────
  skim_variable      n_missing complete_rate     mean      sd    p0     p25      p50     p75    p100 hist 
1 lfdn                       0             1 3.55e+ 2 167.    57    216     352      502      638    ▇▇▇▇▇
2 duration                   0             1 3.71e+ 2 308.    -1    221     287      401     2205    ▇▂▁▁▁
3 Experimentalgruppe         0             1 2.48e+ 0   1.06   1      2       2        3        4    ▆▇▁▇▆
4 Attention_test             0             1 3   e+ 0   0      3      3       3        3        3    ▁▁▇▁▁
5 Akzeptanz                  0             1 3.23e+ 0   1.07   1      2.67    3.33     4        5    ▃▃▇▇▅
6 Akzeptanz_norm             0             1 2.00e-17   1     -2.09  -0.528   0.0967   0.721    1.66 ▃▃▇▇▅
7 Einstellung_KI             0             1 3.65e+ 0   0.631  1.17   3.33    3.75     4.08     5    ▁▁▃▇▃
8 Alter                      0             1 3.92e+ 1  13.3   18     27      38       50       78    ▇▆▆▃▁

> # Deskriptive Statistiken für jede Gruppe
> daten %>% group_by(Gruppe) %>% skim(Akzeptanz)
── Data Summary ────────────────────────
                           Values    
Name                       Piped data
Number of rows             365       
Number of columns          17        
_______________________              
Column type frequency:               
  numeric                  1         
________________________             
Group variables            Gruppe    

── Variable type: numeric ────────────────────────────────────────────────────────────────────────────────────────────────────
  skim_variable Gruppe                    n_missing complete_rate mean    sd   p0  p25  p50  p75 p100 hist 
1 Akzeptanz     Objektiv - Mit Maßnahme           0             1 3.84 0.793 1.33 3.33 4    4.33    5 ▁▂▅▇▇
2 Akzeptanz     Objektiv - Ohne Maßnahme          0             1 3.77 0.716 1.33 3.33 4    4.25    5 ▁▁▃▇▅
3 Akzeptanz     Subjektiv - Mit Maßnahme          0             1 2.66 1.01  1    2    2.67 3.33    5 ▅▃▇▃▁
4 Akzeptanz     Subjektiv - Ohne Maßnahme         0             1 2.61 1.01  1    2    2.67 3.33    5 ▅▆▇▅▁

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
+   )

> print(descriptive_stats)
# A tibble: 4 × 8
  Gruppe                    Mittelwert Median Standardabweichung Varianz Minimum Maximum Anzahl
  <chr>                          <dbl>  <dbl>              <dbl>   <dbl>   <dbl>   <dbl>  <int>
1 Objektiv - Mit Maßnahme         3.84   4                 0.793   0.629    1.33       5    103
2 Objektiv - Ohne Maßnahme        3.77   4                 0.716   0.513    1.33       5     82
3 Subjektiv - Mit Maßnahme        2.66   2.67              1.01    1.01     1          5     76
4 Subjektiv - Ohne Maßnahme       2.61   2.67              1.01    1.03     1          5    104

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
