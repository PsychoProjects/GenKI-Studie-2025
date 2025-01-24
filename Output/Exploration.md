
> source("InstallPackages.R")

> source("Read_Data.R")

> ### Analysen zur Verteilung bezüglich der Geschlechter
> # Statistiken nach Geschlecht
> daten %>% group_by(Geschlecht) %>% count()
# A tibble: 3 × 2
# Groups:   Geschlecht [3]
  Geschlecht     n
  <fct>      <int>
1 weiblich     175
2 männlich     198
3 divers         2

> daten %>% group_by(Geschlecht, Gruppe) %>% skim(Akzeptanz)
── Data Summary ────────────────────────
                           Values            
Name                       Piped data        
Number of rows             375               
Number of columns          24                
_______________________                      
Column type frequency:                       
  numeric                  1                 
________________________                     
Group variables            Geschlecht, Gruppe

── Variable type: numeric ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   skim_variable Geschlecht Gruppe                    n_missing complete_rate mean     sd   p0  p25  p50  p75 p100 hist 
 1 Akzeptanz     weiblich   Objektiv - Mit Maßnahme           0             1 3.78  0.822 1.33 3.33 4    4.33 5    ▁▂▅▇▇
 2 Akzeptanz     weiblich   Objektiv - Ohne Maßnahme          0             1 3.71  0.657 1.67 3.33 4    4    5    ▁▂▅▇▁
 3 Akzeptanz     weiblich   Subjektiv - Mit Maßnahme          0             1 2.70  1.01  1    2    3    3.08 5    ▃▃▇▂▂
 4 Akzeptanz     weiblich   Subjektiv - Ohne Maßnahme         0             1 2.55  0.916 1    2    2.67 3.33 4    ▅▇▅▇▅
 5 Akzeptanz     männlich   Objektiv - Mit Maßnahme           0             1 3.94  0.748 2    3.33 4    4.67 5    ▁▃▃▇▆
 6 Akzeptanz     männlich   Objektiv - Ohne Maßnahme          0             1 3.82  0.809 1.33 3.33 4    4.33 5    ▂▁▃▇▆
 7 Akzeptanz     männlich   Subjektiv - Mit Maßnahme          0             1 2.56  1.02  1    1.75 2.67 3.25 5    ▆▅▇▃▁
 8 Akzeptanz     männlich   Subjektiv - Ohne Maßnahme         0             1 2.62  1.08  1    2    2.67 3.5  5    ▇▇▇▆▂
 9 Akzeptanz     divers     Objektiv - Ohne Maßnahme          0             1 4.33 NA     4.33 4.33 4.33 4.33 4.33 ▁▁▇▁▁
10 Akzeptanz     divers     Subjektiv - Ohne Maßnahme         0             1 3    NA     3    3    3    3    3    ▁▁▇▁▁

> ### Analysen zur Verteilung bezüglich der Bildungsabschlüsse
> # Statistiken nach Bildungsabschluss
> daten %>% group_by(Bildungsabschluss) %>% count()
# A tibble: 5 × 2
# Groups:   Bildungsabschluss [5]
  Bildungsabschluss                       n
  <fct>                               <int>
1 Volks- oder Hauptschulabschluss         1
2 Mittlere Reife (Realschulabschluss)    27
3 Abitur oder Fachabitur                144
4 Hochschulabschluss                    196
5 Promotion oder Habilitation             7

> daten %>% group_by(Bildungsabschluss, Gruppe) %>% skim(Akzeptanz)
── Data Summary ────────────────────────
                           Values                   
Name                       Piped data               
Number of rows             375                      
Number of columns          24                       
_______________________                             
Column type frequency:                              
  numeric                  1                        
________________________                            
Group variables            Bildungsabschluss, Gruppe

── Variable type: numeric ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   skim_variable Bildungsabschluss                   Gruppe                    n_missing complete_rate mean     sd   p0  p25  p50  p75 p100 hist 
 1 Akzeptanz     Volks- oder Hauptschulabschluss     Objektiv - Mit Maßnahme           0             1 4.33 NA     4.33 4.33 4.33 4.33 4.33 ▁▁▇▁▁
 2 Akzeptanz     Mittlere Reife (Realschulabschluss) Objektiv - Mit Maßnahme           0             1 4.15  0.626 3    4    4.33 4.67 4.67 ▃▁▃▂▇
 3 Akzeptanz     Mittlere Reife (Realschulabschluss) Objektiv - Ohne Maßnahme          0             1 3.6   0.723 2.67 3    4    4    4.33 ▇▁▁▇▃
 4 Akzeptanz     Mittlere Reife (Realschulabschluss) Subjektiv - Mit Maßnahme          0             1 2.28  1.06  1    1.33 2.5  3.17 3.33 ▇▁▃▃▇
 5 Akzeptanz     Mittlere Reife (Realschulabschluss) Subjektiv - Ohne Maßnahme         0             1 2.95  1.03  1.33 2.33 3    3.83 4    ▂▂▂▂▇
 6 Akzeptanz     Abitur oder Fachabitur              Objektiv - Mit Maßnahme           0             1 3.76  0.876 1.33 3.25 3.83 4.33 5    ▂▂▃▇▇
 7 Akzeptanz     Abitur oder Fachabitur              Objektiv - Ohne Maßnahme          0             1 3.8   0.585 2    3.33 4    4    5    ▁▁▅▇▁
 8 Akzeptanz     Abitur oder Fachabitur              Subjektiv - Mit Maßnahme          0             1 2.71  0.929 1    2.33 3    3    5    ▂▂▇▂▁
 9 Akzeptanz     Abitur oder Fachabitur              Subjektiv - Ohne Maßnahme         0             1 2.71  1.04  1    2    3    3.33 5    ▅▂▇▅▁
10 Akzeptanz     Hochschulabschluss                  Objektiv - Mit Maßnahme           0             1 3.90  0.731 2    3.33 4    4.33 5    ▁▂▃▇▃
11 Akzeptanz     Hochschulabschluss                  Objektiv - Ohne Maßnahme          0             1 3.78  0.798 1.33 3.33 4    4.33 5    ▁▂▃▇▆
12 Akzeptanz     Hochschulabschluss                  Subjektiv - Mit Maßnahme          0             1 2.62  1.10  1    1.67 2.67 3.67 5    ▇▅▇▆▂
13 Akzeptanz     Hochschulabschluss                  Subjektiv - Ohne Maßnahme         0             1 2.45  0.984 1    2    2    3    5    ▆▇▇▃▁
14 Akzeptanz     Promotion oder Habilitation         Objektiv - Mit Maßnahme           0             1 3    NA     3    3    3    3    3    ▁▁▇▁▁
15 Akzeptanz     Promotion oder Habilitation         Subjektiv - Mit Maßnahme          0             1 2.5   0.236 2.33 2.42 2.5  2.58 2.67 ▇▁▁▁▇
16 Akzeptanz     Promotion oder Habilitation         Subjektiv - Ohne Maßnahme         0             1 2.58  0.957 2    2    2.17 2.75 4    ▇▁▁▁▂

> ### Analysen zur Einschätzung der Objektivität bzw. Subjektivität der Anwendungsfelder
> # Korrelationsanalyse zwischen Anwendungsfeld und objektiv-subjektiv-Einschätzung
> cor.test(as.numeric(daten$Anwendungsfeld), as.numeric(daten$objektiv_subjektiv), method = "kendall")

	Kendall's rank correlation tau

data:  as.numeric(daten$Anwendungsfeld) and as.numeric(daten$objektiv_subjektiv)
z = 14.079, p-value < 2.2e-16
alternative hypothesis: true tau is not equal to 0
sample estimates:
     tau 
0.728029 


> # Anzahl übereinstimmender Werte ermitteln
> fn_analyse_uebereinstimmung <- function(daten) {
+   daten %>% summarise(
+     gleich = sum(Anwendungsfeld == objektiv_subjektiv),
+     ungleich = sum(Anwendungsfeld != objektiv_subjektiv),
+     uebereinstimmung = round((gleich / nrow(daten)) * 100.0,2))
+ }

> # Gesamt
> fn_analyse_uebereinstimmung(daten)
  gleich ungleich uebereinstimmung
1    324       51             86.4

> # Objektive Anwendungsfelder
> fn_analyse_uebereinstimmung(daten %>% filter(Anwendungsfeld == "Objektiv"))
  gleich ungleich uebereinstimmung
1    168       23            87.96

> # Subjektive Anwendungsfelder
> fn_analyse_uebereinstimmung(daten %>% filter(Anwendungsfeld == "Subjektiv"))
  gleich ungleich uebereinstimmung
1    156       28            84.78
