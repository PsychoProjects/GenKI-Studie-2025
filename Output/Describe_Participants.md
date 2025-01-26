
> source("InstallPackages.R")

> source("Read_Data.R")

> # Anzahl Teilnehmer (gesamt)
> nrow(daten)
[1] 375

> # Anzahl Teilnehmer (je Gruppe)
> gruppen_groessen <- table(daten$Gruppe) %>% as.data.frame()

> gruppen_statistik <- gruppen_groessen %>% 
+   summarise(
+     Mittelwert = mean(Freq),
+     Median = median(Freq),
+     Standardabweichung = sd(Freq),
+     Minimum = min(Freq),
+     Maximum = max(Freq),
+     Relation = max(Freq) / min(Freq)
+   ) %>% print()
  Mittelwert Median Standardabweichung Minimum Maximum Relation
1      93.75     95           14.93039      78     107 1.371795

> # Aufteilung nach Geschlecht
> geschlechter_statisik <- daten %>% group_by(Geschlecht) %>%
+   summarise(
+     Anzahl = n(),
+     Anteil = round(n() / nrow(daten) * 100, digits = 2)
+   ) %>% print()
# A tibble: 3 × 3
  Geschlecht Anzahl Anteil
  <fct>       <int>  <dbl>
1 weiblich      175  46.7 
2 männlich      198  52.8 
3 divers          2   0.53

> daten %>% group_by(Geschlecht, Gruppe) %>% count()
# A tibble: 10 × 3
# Groups:   Geschlecht, Gruppe [10]
   Geschlecht Gruppe                        n
   <fct>      <chr>                     <int>
 1 weiblich   Objektiv - Mit Maßnahme      54
 2 weiblich   Objektiv - Ohne Maßnahme     43
 3 weiblich   Subjektiv - Mit Maßnahme     36
 4 weiblich   Subjektiv - Ohne Maßnahme    42
 5 männlich   Objektiv - Mit Maßnahme      53
 6 männlich   Objektiv - Ohne Maßnahme     40
 7 männlich   Subjektiv - Mit Maßnahme     42
 8 männlich   Subjektiv - Ohne Maßnahme    63
 9 divers     Objektiv - Ohne Maßnahme      1
10 divers     Subjektiv - Ohne Maßnahme     1

> # Aufteilung nach Bildungsabschluss (Anzahl und Anteil)
> bildungsabschluss_statistik <- daten %>% group_by(Bildungsabschluss) %>%
+   summarise(
+     Anzahl = n(),
+     Anteil = round(n() / nrow(daten) * 100, digits = 2)
+   ) %>% print()
# A tibble: 5 × 3
  Bildungsabschluss                   Anzahl Anteil
  <fct>                                <int>  <dbl>
1 Volks- oder Hauptschulabschluss          1   0.27
2 Mittlere Reife (Realschulabschluss)     27   7.2 
3 Abitur oder Fachabitur                 144  38.4 
4 Hochschulabschluss                     196  52.3 
5 Promotion oder Habilitation              7   1.87

> # Statistiken zum Alter
> alter_statistik <- daten %>% 
+   summarise(
+     Mittelwert = mean(Alter, na.rm = TRUE),
+     Median = median(Alter, na.rm = TRUE),
+     Standardabweichung = sd(Alter, na.rm = TRUE),
+     Minimum = min(Alter, na.rm = TRUE),
+     Maximum = max(Alter, na.rm = TRUE),
+   ) %>% print()
  Mittelwert Median Standardabweichung Minimum Maximum
1   39.13867     38           13.12005      18      78

> # Aufteilung nach Altersgruppen
> altersgruppen <- cut(daten$Alter, 
+                      breaks = c(0, 18, 20, 30, 40, 50, 60, 70, 80, 90, 100), 
+                      right = FALSE) %>% table() %>% print()
.
  [0,18)  [18,20)  [20,30)  [30,40)  [40,50)  [50,60)  [60,70)  [70,80)  [80,90) [90,100) 
       0       11      100       89       78       71       25        1        0        0 

> # Aufteilung nach Berufsstatus
> berufsstatistik <- daten %>% group_by(Berufsstatus) %>% 
+   summarise(
+     Anzahl = n(),
+     Anteil = round(n() / nrow(daten) * 100, digits = 2)
+   ) %>% print()
# A tibble: 4 × 3
  Berufsstatus       Anzahl Anteil
  <fct>               <int>  <dbl>
1 nicht erwerbstätig     12    3.2
2 erwerbstätig          291   77.6
3 im Studium             63   16.8
4 in der Ausbildung       9    2.4

> # Aufteilung nach Berufserfahrung
> berufserfahrungsstatistik <- daten %>% group_by(Berufserfahrung) %>% 
+   summarise(
+     Anzahl = n(),
+     Anteil = round(n() / nrow(daten) * 100, digits = 2)
+   ) %>% print()
# A tibble: 5 × 3
  Berufserfahrung    Anzahl Anteil
  <fct>               <int>  <dbl>
1 keine                   7   1.87
2 weniger als 1 Jahr      6   1.6 
3 1-5 Jahre              75  20   
4 5-10 Jahre             43  11.5 
5 mehr als 10 Jahre     244  65.1 
