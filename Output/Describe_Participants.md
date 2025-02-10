
> source("InstallPackages.R")

> source("Read_Data.R")
[1] "Daten werden geladen..."

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
+   ) 

> kable(gruppen_statistik, caption = "Statistiken zur Gruppengröße", digits = 2)


Table: Statistiken zur Gruppengröße

| Mittelwert| Median| Standardabweichung| Minimum| Maximum| Relation|
|----------:|------:|------------------:|-------:|-------:|--------:|
|      93.75|     95|              14.93|      78|     107|     1.37|

> # Aufteilung nach Geschlecht
> geschlechter_statisik <- daten %>% group_by(Geschlecht) %>%
+   summarise(
+     Anzahl = n(),
+     Anteil = round(n() / nrow(daten) * 100, digits = 2)
+   ) 

> kable(geschlechter_statisik, caption = "Statistiken zur Geschlechterverteilung", digits = 2)


Table: Statistiken zur Geschlechterverteilung

|Geschlecht | Anzahl| Anteil|
|:----------|------:|------:|
|weiblich   |    175|  46.67|
|männlich   |    198|  52.80|
|divers     |      2|   0.53|

> t_geschl_gruppe <- daten %>% group_by(Geschlecht, Gruppe) %>% count()

> kable(t_geschl_gruppe, caption = "Kreuztabelle Geschlecht und Gruppe", digits = 2)


Table: Kreuztabelle Geschlecht und Gruppe

|Geschlecht |Gruppe                    |  n|
|:----------|:-------------------------|--:|
|weiblich   |Objektiv - Mit Maßnahme   | 54|
|weiblich   |Objektiv - Ohne Maßnahme  | 43|
|weiblich   |Subjektiv - Mit Maßnahme  | 36|
|weiblich   |Subjektiv - Ohne Maßnahme | 42|
|männlich   |Objektiv - Mit Maßnahme   | 53|
|männlich   |Objektiv - Ohne Maßnahme  | 40|
|männlich   |Subjektiv - Mit Maßnahme  | 42|
|männlich   |Subjektiv - Ohne Maßnahme | 63|
|divers     |Objektiv - Ohne Maßnahme  |  1|
|divers     |Subjektiv - Ohne Maßnahme |  1|

> # Aufteilung nach Bildungsabschluss (Anzahl und Anteil)
> bildungsabschluss_statistik <- daten %>% group_by(Bildungsabschluss) %>%
+   summarise(
+     Anzahl = n(),
+     Anteil = round(n() / nrow(daten) * 100, digits = 2)
+   ) 

> kable(bildungsabschluss_statistik, caption = "Statistiken zum Bildungsabschluss", digits = 2)


Table: Statistiken zum Bildungsabschluss

|Bildungsabschluss                   | Anzahl| Anteil|
|:-----------------------------------|------:|------:|
|Volks- oder Hauptschulabschluss     |      1|   0.27|
|Mittlere Reife (Realschulabschluss) |     27|   7.20|
|Abitur oder Fachabitur              |    144|  38.40|
|Hochschulabschluss                  |    196|  52.27|
|Promotion oder Habilitation         |      7|   1.87|

> # Statistiken zum Alter
> alter_statistik <- daten %>% 
+   summarise(
+     Mittelwert = mean(Alter, na.rm = TRUE),
+     Median = median(Alter, na.rm = TRUE),
+     Standardabweichung = sd(Alter, na.rm = TRUE),
+     Minimum = min(Alter, na.rm = TRUE),
+     Maximum = max(Alter, na.rm = TRUE),
+   ) 

> kable(alter_statistik, caption = "Statistiken zum Alter", digits = 2)


Table: Statistiken zum Alter

| Mittelwert| Median| Standardabweichung| Minimum| Maximum|
|----------:|------:|------------------:|-------:|-------:|
|      39.14|     38|              13.12|      18|      78|

> # Aufteilung nach Altersgruppen
> altersgruppen <- cut(daten$Alter, 
+                      breaks = c(0, 18, 20, 30, 40, 50, 60, 70, 80, 90, 100), 
+                      right = FALSE) %>% table() 

> altersgruppen_df <- as.data.frame(altersgruppen)

> altersgruppen_df$Anteil <- (altersgruppen_df$Freq / sum(altersgruppen_df$Freq)) * 100

> kable(altersgruppen_df, caption = "Statistiken zu den Altersgruppen", digits = 2)


Table: Statistiken zu den Altersgruppen

|.        | Freq| Anteil|
|:--------|----:|------:|
|[0,18)   |    0|   0.00|
|[18,20)  |   11|   2.93|
|[20,30)  |  100|  26.67|
|[30,40)  |   89|  23.73|
|[40,50)  |   78|  20.80|
|[50,60)  |   71|  18.93|
|[60,70)  |   25|   6.67|
|[70,80)  |    1|   0.27|
|[80,90)  |    0|   0.00|
|[90,100) |    0|   0.00|

> # Aufteilung nach Berufsstatus
> berufsstatistik <- daten %>% group_by(Berufsstatus) %>% 
+   summarise(
+     Anzahl = n(),
+     Anteil = round(n() / nrow(daten) * 100, digits = 2)
+   )

> kable(berufsstatistik, caption = "Statistiken zum Berufsstatus", digits = 2)


Table: Statistiken zum Berufsstatus

|Berufsstatus       | Anzahl| Anteil|
|:------------------|------:|------:|
|nicht erwerbstätig |     12|    3.2|
|erwerbstätig       |    291|   77.6|
|im Studium         |     63|   16.8|
|in der Ausbildung  |      9|    2.4|

> # Aufteilung nach Berufserfahrung
> berufserfahrungsstatistik <- daten %>% group_by(Berufserfahrung) %>% 
+   summarise(
+     Anzahl = n(),
+     Anteil = round(n() / nrow(daten) * 100, digits = 2)
+   ) 

> kable(berufserfahrungsstatistik, caption = "Statistiken zur Berufserfahrung", digits = 2)


Table: Statistiken zur Berufserfahrung

|Berufserfahrung    | Anzahl| Anteil|
|:------------------|------:|------:|
|keine              |      7|   1.87|
|weniger als 1 Jahr |      6|   1.60|
|1-5 Jahre          |     75|  20.00|
|5-10 Jahre         |     43|  11.47|
|mehr als 10 Jahre  |    244|  65.07|
