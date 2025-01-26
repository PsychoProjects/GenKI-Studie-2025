
> source("InstallPackages.R")

> source("Read_Data.R")

> ### Analysen zur Verteilung bezüglich der Geschlechter
> # Statistiken nach Geschlecht
> daten %>% group_by(Geschlecht) %>% skim(Akzeptanz)
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
  skim_variable Geschlecht n_missing complete_rate mean    sd p0  p25  p50 p75 p100 hist 
1 Akzeptanz     weiblich           0             1 3.25 1.02   1 2.67 3.33   4 5    ▂▃▇▇▅
2 Akzeptanz     männlich           0             1 3.21 1.13   1 2.33 3.33   4 5    ▅▅▇▇▆
3 Akzeptanz     divers             0             1 3.67 0.943  3 3.33 3.67   4 4.33 ▇▁▁▁▇

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

── Variable type: numeric ────────────────────────────────────────────────────────────────────────────────────────────────────
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
> daten %>% group_by(Bildungsabschluss) %>% skim(Akzeptanz)
── Data Summary ────────────────────────
                           Values           
Name                       Piped data       
Number of rows             375              
Number of columns          24               
_______________________                     
Column type frequency:                      
  numeric                  1                
________________________                    
Group variables            Bildungsabschluss

── Variable type: numeric ────────────────────────────────────────────────────────────────────────────────────────────────────
  skim_variable Bildungsabschluss                   n_missing complete_rate mean     sd   p0  p25  p50  p75 p100 hist 
1 Akzeptanz     Volks- oder Hauptschulabschluss             0             1 4.33 NA     4.33 4.33 4.33 4.33 4.33 ▁▁▇▁▁
2 Akzeptanz     Mittlere Reife (Realschulabschluss)         0             1 3.32  1.10  1    2.67 3.33 4    4.67 ▂▁▃▂▇
3 Akzeptanz     Abitur oder Fachabitur                      0             1 3.22  1.04  1    2.67 3.33 4    5    ▂▂▇▇▃
4 Akzeptanz     Hochschulabschluss                          0             1 3.23  1.11  1    2.33 3.33 4    5    ▃▅▇▇▆
5 Akzeptanz     Promotion oder Habilitation                 0             1 2.62  0.705 2    2.17 2.33 2.83 4    ▇▂▂▁▂

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

── Variable type: numeric ────────────────────────────────────────────────────────────────────────────────────────────────────
   skim_variable Bildungsabschluss                   Gruppe                    n_missing complete_rate mean     sd   p0  p25
 1 Akzeptanz     Volks- oder Hauptschulabschluss     Objektiv - Mit Maßnahme           0             1 4.33 NA     4.33 4.33
 2 Akzeptanz     Mittlere Reife (Realschulabschluss) Objektiv - Mit Maßnahme           0             1 4.15  0.626 3    4   
 3 Akzeptanz     Mittlere Reife (Realschulabschluss) Objektiv - Ohne Maßnahme          0             1 3.6   0.723 2.67 3   
 4 Akzeptanz     Mittlere Reife (Realschulabschluss) Subjektiv - Mit Maßnahme          0             1 2.28  1.06  1    1.33
 5 Akzeptanz     Mittlere Reife (Realschulabschluss) Subjektiv - Ohne Maßnahme         0             1 2.95  1.03  1.33 2.33
 6 Akzeptanz     Abitur oder Fachabitur              Objektiv - Mit Maßnahme           0             1 3.76  0.876 1.33 3.25
 7 Akzeptanz     Abitur oder Fachabitur              Objektiv - Ohne Maßnahme          0             1 3.8   0.585 2    3.33
 8 Akzeptanz     Abitur oder Fachabitur              Subjektiv - Mit Maßnahme          0             1 2.71  0.929 1    2.33
 9 Akzeptanz     Abitur oder Fachabitur              Subjektiv - Ohne Maßnahme         0             1 2.71  1.04  1    2   
10 Akzeptanz     Hochschulabschluss                  Objektiv - Mit Maßnahme           0             1 3.90  0.731 2    3.33
11 Akzeptanz     Hochschulabschluss                  Objektiv - Ohne Maßnahme          0             1 3.78  0.798 1.33 3.33
12 Akzeptanz     Hochschulabschluss                  Subjektiv - Mit Maßnahme          0             1 2.62  1.10  1    1.67
13 Akzeptanz     Hochschulabschluss                  Subjektiv - Ohne Maßnahme         0             1 2.45  0.984 1    2   
14 Akzeptanz     Promotion oder Habilitation         Objektiv - Mit Maßnahme           0             1 3    NA     3    3   
15 Akzeptanz     Promotion oder Habilitation         Subjektiv - Mit Maßnahme          0             1 2.5   0.236 2.33 2.42
16 Akzeptanz     Promotion oder Habilitation         Subjektiv - Ohne Maßnahme         0             1 2.58  0.957 2    2   
    p50  p75 p100 hist 
 1 4.33 4.33 4.33 ▁▁▇▁▁
 2 4.33 4.67 4.67 ▃▁▃▂▇
 3 4    4    4.33 ▇▁▁▇▃
 4 2.5  3.17 3.33 ▇▁▃▃▇
 5 3    3.83 4    ▂▂▂▂▇
 6 3.83 4.33 5    ▂▂▃▇▇
 7 4    4    5    ▁▁▅▇▁
 8 3    3    5    ▂▂▇▂▁
 9 3    3.33 5    ▅▂▇▅▁
10 4    4.33 5    ▁▂▃▇▃
11 4    4.33 5    ▁▂▃▇▆
12 2.67 3.67 5    ▇▅▇▆▂
13 2    3    5    ▆▇▇▃▁
14 3    3    3    ▁▁▇▁▁
15 2.5  2.58 2.67 ▇▁▁▁▇
16 2.17 2.75 4    ▇▁▁▁▂

> ### Analysen zur Verteilung bezüglich der Berufserfahrung
> # Statistiken nach Berufserfahrung
> daten %>% group_by(Berufserfahrung) %>% skim(Akzeptanz)
── Data Summary ────────────────────────
                           Values         
Name                       Piped data     
Number of rows             375            
Number of columns          24             
_______________________                   
Column type frequency:                    
  numeric                  1              
________________________                  
Group variables            Berufserfahrung

── Variable type: numeric ────────────────────────────────────────────────────────────────────────────────────────────────────
  skim_variable Berufserfahrung    n_missing complete_rate mean    sd   p0  p25  p50  p75 p100 hist 
1 Akzeptanz     keine                      0             1 3.05 0.932 1.67 2.33 3.67 3.67 4    ▃▁▂▁▇
2 Akzeptanz     weniger als 1 Jahr         0             1 3.22 0.750 2    3.08 3.33 3.33 4.33 ▂▁▇▁▂
3 Akzeptanz     1-5 Jahre                  0             1 3.25 1.04  1    2.83 3.33 4    5    ▃▁▇▇▃
4 Akzeptanz     5-10 Jahre                 0             1 3.32 1.06  1    2.67 3.33 4    5    ▂▁▇▆▃
5 Akzeptanz     mehr als 10 Jahre          0             1 3.21 1.11  1    2.33 3.33 4    5    ▃▅▇▇▆

> daten %>% group_by(Berufserfahrung, Gruppe) %>% skim(Akzeptanz)
── Data Summary ────────────────────────
                           Values                 
Name                       Piped data             
Number of rows             375                    
Number of columns          24                     
_______________________                           
Column type frequency:                            
  numeric                  1                      
________________________                          
Group variables            Berufserfahrung, Gruppe

── Variable type: numeric ────────────────────────────────────────────────────────────────────────────────────────────────────
   skim_variable Berufserfahrung    Gruppe                    n_missing complete_rate mean     sd   p0  p25  p50  p75 p100
 1 Akzeptanz     keine              Objektiv - Mit Maßnahme           0             1 3.67 NA     3.67 3.67 3.67 3.67 3.67
 2 Akzeptanz     keine              Objektiv - Ohne Maßnahme          0             1 4    NA     4    4    4    4    4   
 3 Akzeptanz     keine              Subjektiv - Mit Maßnahme          0             1 2.67  1.41  1.67 2.17 2.67 3.17 3.67
 4 Akzeptanz     keine              Subjektiv - Ohne Maßnahme         0             1 2.78  0.839 2    2.33 2.67 3.17 3.67
 5 Akzeptanz     weniger als 1 Jahr Objektiv - Mit Maßnahme           0             1 3.33 NA     3.33 3.33 3.33 3.33 3.33
 6 Akzeptanz     weniger als 1 Jahr Objektiv - Ohne Maßnahme          0             1 3.67  0.577 3.33 3.33 3.33 3.83 4.33
 7 Akzeptanz     weniger als 1 Jahr Subjektiv - Ohne Maßnahme         0             1 2.5   0.707 2    2.25 2.5  2.75 3   
 8 Akzeptanz     1-5 Jahre          Objektiv - Mit Maßnahme           0             1 3.82  0.546 2.67 3.58 3.83 4    5   
 9 Akzeptanz     1-5 Jahre          Objektiv - Ohne Maßnahme          0             1 3.88  0.552 2.67 3.67 4    4    5   
10 Akzeptanz     1-5 Jahre          Subjektiv - Mit Maßnahme          0             1 2.78  1.06  1    2.17 3    3.08 5   
11 Akzeptanz     1-5 Jahre          Subjektiv - Ohne Maßnahme         0             1 2.56  1.13  1    1.5  2.83 3.5  4   
12 Akzeptanz     5-10 Jahre         Objektiv - Mit Maßnahme           0             1 4.25  0.698 3    3.67 4.5  4.75 5   
13 Akzeptanz     5-10 Jahre         Objektiv - Ohne Maßnahme          0             1 3.36  0.767 1.67 3    3.33 4    4.33
14 Akzeptanz     5-10 Jahre         Subjektiv - Mit Maßnahme          0             1 2.73  1.18  1    1.67 3.17 3.67 4   
15 Akzeptanz     5-10 Jahre         Subjektiv - Ohne Maßnahme         0             1 2.73  0.813 1    2.67 2.67 3.25 4   
16 Akzeptanz     mehr als 10 Jahre  Objektiv - Mit Maßnahme           0             1 3.81  0.852 1.33 3.33 4    4.33 5   
17 Akzeptanz     mehr als 10 Jahre  Objektiv - Ohne Maßnahme          0             1 3.83  0.774 1.33 3.67 4    4.33 5   
18 Akzeptanz     mehr als 10 Jahre  Subjektiv - Mit Maßnahme          0             1 2.54  0.965 1    2    2.67 3    5   
19 Akzeptanz     mehr als 10 Jahre  Subjektiv - Ohne Maßnahme         0             1 2.58  1.04  1    2    2.33 3.33 5   
   hist 
 1 ▁▁▇▁▁
 2 ▁▁▇▁▁
 3 ▇▁▁▁▇
 4 ▇▇▁▁▇
 5 ▁▁▇▁▁
 6 ▇▁▁▁▃
 7 ▇▁▁▁▇
 8 ▂▂▇▂▂
 9 ▁▂▇▂▂
10 ▃▁▇▂▂
11 ▇▅▂▆▇
12 ▂▂▁▁▇
13 ▂▂▃▆▇
14 ▆▁▂▃▇
15 ▂▂▇▆▂
16 ▁▂▃▆▇
17 ▁▁▂▇▅
18 ▅▆▇▂▂
19 ▇▇▇▅▁

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
