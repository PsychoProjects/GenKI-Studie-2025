
> source("InstallPackages.R")

> source("Read_Data.R")

> # Anzahl Teilnehmer (gesamt)
> nrow(daten) %>% print()
[1] 365

> # Anzahl Teilnehmer (je Gruppe)
> gruppen_groessen <- table(daten$Gruppe) %>% as.data.frame() %>% print()
                       Var1 Freq
1   Objektiv - Mit Maßnahme  103
2  Objektiv - Ohne Maßnahme   82
3  Subjektiv - Mit Maßnahme   76
4 Subjektiv - Ohne Maßnahme  104

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
1      91.25   92.5           14.36141      76     104 1.368421

> # Aufteilung nach Geschlecht
> geschlechter_statisik <- daten %>% group_by(Geschlecht) %>%
+   summarise(
+     Anzahl = n(),
+     Anteil = round(n() / nrow(daten) * 100, digits = 2)
+   ) %>% print()
# A tibble: 3 × 3
  Geschlecht Anzahl Anteil
  <fct>       <int>  <dbl>
1 weiblich      170  46.6 
2 männlich      193  52.9 
3 divers          2   0.55

> daten %>% group_by(Geschlecht, Gruppe) %>% count() %>% print()
# A tibble: 10 × 3
# Groups:   Geschlecht, Gruppe [10]
   Geschlecht Gruppe                        n
   <fct>      <chr>                     <int>
 1 weiblich   Objektiv - Mit Maßnahme      53
 2 weiblich   Objektiv - Ohne Maßnahme     42
 3 weiblich   Subjektiv - Mit Maßnahme     34
 4 weiblich   Subjektiv - Ohne Maßnahme    41
 5 männlich   Objektiv - Mit Maßnahme      50
 6 männlich   Objektiv - Ohne Maßnahme     39
 7 männlich   Subjektiv - Mit Maßnahme     42
 8 männlich   Subjektiv - Ohne Maßnahme    62
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
2 Mittlere Reife (Realschulabschluss)     26   7.12
3 Abitur oder Fachabitur                 144  39.4 
4 Hochschulabschluss                     187  51.2 
5 Promotion oder Habilitation              7   1.92

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
1   39.16164     38           13.27741      18      78

> # Aufteilung nach Altersgruppen
> altersgruppen <- cut(daten$Alter, 
+                      breaks = c(0, 18, 20, 30, 40, 50, 60, 70, 80, 90, 100), 
+                      right = FALSE) %>% table() %>% print()
.
  [0,18)  [18,20)  [20,30)  [30,40)  [40,50)  [50,60)  [60,70)  [70,80)  [80,90) [90,100) 
       0       11      100       82       75       71       25        1        0        0 

> # Aufteilung nach Berufsstatus
> berufsstatistik <- daten %>% group_by(Berufsstatus) %>% 
+   summarise(
+     Anzahl = n(),
+     Anteil = round(n() / nrow(daten) * 100, digits = 2)
+   ) %>% print()
# A tibble: 4 × 3
  Berufsstatus       Anzahl Anteil
  <fct>               <int>  <dbl>
1 nicht erwerbstätig     12   3.29
2 erwerbstätig          282  77.3 
3 im Studium             62  17.0 
4 in der Ausbildung       9   2.47

> # Aufteilung nach Berufserfahrung
> berufserfahrungsstatistik <- daten %>% group_by(Berufserfahrung) %>% count() %>% print()
# A tibble: 5 × 2
# Groups:   Berufserfahrung [5]
  Berufserfahrung        n
  <fct>              <int>
1 keine                  7
2 weniger als 1 Jahr     6
3 1-5 Jahre             74
4 5-10 Jahre            42
5 mehr als 10 Jahre    236
