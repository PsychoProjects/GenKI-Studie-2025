
> source("InstallPackages.R")

> source("Read_Data.R")

> cat("\n*** Statistiken nach Geschlecht\n")

*** Statistiken nach Geschlecht

> daten %>% group_by(Geschlecht) %>% count() %>% print()
# A tibble: 3 × 2
# Groups:   Geschlecht [3]
  Geschlecht     n
  <fct>      <int>
1 weiblich     170
2 männlich     193
3 divers         2

> daten %>% group_by(Geschlecht, Gruppe) %>% skim(Akzeptanz) %>% print()
── Data Summary ────────────────────────
                           Values            
Name                       Piped data        
Number of rows             365               
Number of columns          17                
_______________________                      
Column type frequency:                       
  numeric                  1                 
________________________                     
Group variables            Geschlecht, Gruppe

── Variable type: numeric ────────────────────────────────────────────────────────────────────────────────────────────────────
   skim_variable Geschlecht Gruppe                    n_missing complete_rate mean     sd   p0  p25  p50  p75 p100 hist 
 1 Akzeptanz     weiblich   Objektiv - Mit Maßnahme           0             1 3.77  0.826 1.33 3.33 4    4.33 5    ▁▂▅▇▇
 2 Akzeptanz     weiblich   Objektiv - Ohne Maßnahme          0             1 3.74  0.644 1.67 3.33 4    4    5    ▁▂▅▇▁
 3 Akzeptanz     weiblich   Subjektiv - Mit Maßnahme          0             1 2.77  0.991 1    2.08 3    3.25 5    ▃▂▇▂▂
 4 Akzeptanz     weiblich   Subjektiv - Ohne Maßnahme         0             1 2.56  0.923 1    2    2.67 3.33 4    ▅▇▅▇▅
 5 Akzeptanz     männlich   Objektiv - Mit Maßnahme           0             1 3.93  0.757 2    3.42 4    4.58 5    ▁▃▃▇▆
 6 Akzeptanz     männlich   Objektiv - Ohne Maßnahme          0             1 3.79  0.797 1.33 3.33 4    4.33 5    ▂▁▃▇▆
 7 Akzeptanz     männlich   Subjektiv - Mit Maßnahme          0             1 2.56  1.02  1    1.75 2.67 3.25 5    ▆▅▇▃▁
 8 Akzeptanz     männlich   Subjektiv - Ohne Maßnahme         0             1 2.64  1.08  1    2    2.67 3.58 5    ▆▇▇▆▂
 9 Akzeptanz     divers     Objektiv - Ohne Maßnahme          0             1 4.33 NA     4.33 4.33 4.33 4.33 4.33 ▁▁▇▁▁
10 Akzeptanz     divers     Subjektiv - Ohne Maßnahme         0             1 3    NA     3    3    3    3    3    ▁▁▇▁▁

> cat("\n*** Statistiken nach Bildungsabschluss\n")

*** Statistiken nach Bildungsabschluss

> daten %>% group_by(Bildungsabschluss) %>% count() %>% print()
# A tibble: 5 × 2
# Groups:   Bildungsabschluss [5]
  Bildungsabschluss                       n
  <fct>                               <int>
1 Volks- oder Hauptschulabschluss         1
2 Mittlere Reife (Realschulabschluss)    26
3 Abitur oder Fachabitur                144
4 Hochschulabschluss                    187
5 Promotion oder Habilitation             7

> daten %>% group_by(Bildungsabschluss, Gruppe) %>% skim(Akzeptanz) %>% print()
── Data Summary ────────────────────────
                           Values                   
Name                       Piped data               
Number of rows             365                      
Number of columns          17                       
_______________________                             
Column type frequency:                              
  numeric                  1                        
________________________                            
Group variables            Bildungsabschluss, Gruppe

── Variable type: numeric ────────────────────────────────────────────────────────────────────────────────────────────────────
   skim_variable Bildungsabschluss                   Gruppe                    n_missing complete_rate mean     sd   p0  p25
 1 Akzeptanz     Volks- oder Hauptschulabschluss     Objektiv - Mit Maßnahme           0             1 4.33 NA     4.33 4.33
 2 Akzeptanz     Mittlere Reife (Realschulabschluss) Objektiv - Mit Maßnahme           0             1 4.12  0.665 3    3.83
 3 Akzeptanz     Mittlere Reife (Realschulabschluss) Objektiv - Ohne Maßnahme          0             1 3.6   0.723 2.67 3   
 4 Akzeptanz     Mittlere Reife (Realschulabschluss) Subjektiv - Mit Maßnahme          0             1 2.28  1.06  1    1.33
 5 Akzeptanz     Mittlere Reife (Realschulabschluss) Subjektiv - Ohne Maßnahme         0             1 2.95  1.03  1.33 2.33
 6 Akzeptanz     Abitur oder Fachabitur              Objektiv - Mit Maßnahme           0             1 3.76  0.876 1.33 3.25
 7 Akzeptanz     Abitur oder Fachabitur              Objektiv - Ohne Maßnahme          0             1 3.8   0.585 2    3.33
 8 Akzeptanz     Abitur oder Fachabitur              Subjektiv - Mit Maßnahme          0             1 2.71  0.929 1    2.33
 9 Akzeptanz     Abitur oder Fachabitur              Subjektiv - Ohne Maßnahme         0             1 2.71  1.04  1    2   
10 Akzeptanz     Hochschulabschluss                  Objektiv - Mit Maßnahme           0             1 3.88  0.738 2    3.33
11 Akzeptanz     Hochschulabschluss                  Objektiv - Ohne Maßnahme          0             1 3.78  0.780 1.33 3.33
12 Akzeptanz     Hochschulabschluss                  Subjektiv - Mit Maßnahme          0             1 2.68  1.09  1    1.75
13 Akzeptanz     Hochschulabschluss                  Subjektiv - Ohne Maßnahme         0             1 2.47  0.996 1    2   
14 Akzeptanz     Promotion oder Habilitation         Objektiv - Mit Maßnahme           0             1 3    NA     3    3   
15 Akzeptanz     Promotion oder Habilitation         Subjektiv - Mit Maßnahme          0             1 2.5   0.236 2.33 2.42
16 Akzeptanz     Promotion oder Habilitation         Subjektiv - Ohne Maßnahme         0             1 2.58  0.957 2    2   
    p50  p75 p100 hist 
 1 4.33 4.33 4.33 ▁▁▇▁▁
 2 4.33 4.67 4.67 ▃▁▃▁▇
 3 4    4    4.33 ▇▁▁▇▃
 4 2.5  3.17 3.33 ▇▁▃▃▇
 5 3    3.83 4    ▂▂▂▂▇
 6 3.83 4.33 5    ▂▂▃▇▇
 7 4    4    5    ▁▁▅▇▁
 8 3    3    5    ▂▂▇▂▁
 9 3    3.33 5    ▅▂▇▅▁
10 4    4.33 5    ▁▂▃▇▃
11 4    4.33 5    ▁▁▃▇▆
12 2.67 3.67 5    ▇▅▇▆▂
13 2    3    5    ▆▇▇▃▁
14 3    3    3    ▁▁▇▁▁
15 2.5  2.58 2.67 ▇▁▁▁▇
16 2.17 2.75 4    ▇▁▁▁▂
