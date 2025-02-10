
> source("InstallPackages.R")

> source("Read_Data.R")
[1] "Daten werden geladen..."

> # Analysefunktion
> fn_Akzeptanz_Analyse <- function(daten, var) {
+   cat("# Statistiken für", deparse(substitute(var)), "\n")
+   
+   if (!is.null(daten[[var]])) {
+     stats <- daten %>% group_by(!!sym(var)) %>%
+       summarise(
+         N = n(),
+         Perc = n() / nrow(daten) * 100,
+         M = mean(Akzeptanz, na.rm = TRUE)
+       )
+     print(kable(stats, caption = "Häufigkeiten", digits = 2), "\n")
+   }
+   
+   ## Analyseformel zusammensetzen
+   formula <- as.formula(paste("Akzeptanz", var, sep = " ~ "))  
+ 
+   ## Lineares Modell erstellen
+   model <- lm(formula, data = daten)  # Regressionmodell
+   
+   cat("\n## Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test\n")
+   bp_test <- bptest(model)
+   print(bp_test)
+ 
+   ## Falls Heteroskedastizität vorliegt, robuste Standardfehler und robuste ANOVA verwenden
+   if (bp_test$p.value < 0.05) {
+     cat("\n## Robuste Standardfehler:")
+     robust_se <- coeftest(model, vcov = vcovHC(model, type = "HC3"))
+     print(kable(as .... [TRUNCATED] 

> # Analyse der Akzeptanz in Abhängigkeit von verschiedenen Variablen
> fn_Akzeptanz_Analyse(daten, "GenKI_Erfahrung")
# Statistiken für "GenKI_Erfahrung" 


Table: Häufigkeiten

|GenKI_Erfahrung |   N|  Perc|    M|
|:---------------|---:|-----:|----:|
|sehr gering     |  49| 13.07| 3.12|
|gering          |  95| 25.33| 3.21|
|mittel          | 145| 38.67| 3.24|
|hoch            |  69| 18.40| 3.29|
|sehr hoch       |  17|  4.53| 3.29|

## Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 6.2066, df = 4, p-value = 0.1842


## Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.
### Modell-Koeffizienten


Table: Modell-Koeffizienten

|                         | coef(model)|
|:------------------------|-----------:|
|(Intercept)              |       3.116|
|GenKI_Erfahrunggering    |       0.091|
|GenKI_Erfahrungmittel    |       0.121|
|GenKI_Erfahrunghoch      |       0.179|
|GenKI_Erfahrungsehr hoch |       0.178|

### Zusammenfassung des Modells

Table: Zusammenfassung des ANOVA-Modells

|Parameter       | Sum_Squares|  df| Mean_Square|    F|    p|
|:---------------|-----------:|---:|-----------:|----:|----:|
|GenKI_Erfahrung |        1.05|   4|        0.26| 0.23| 0.92|
|Residuals       |      432.24| 370|        1.17|   NA|   NA|

### Effektgrößen

Table: Effektgrößen der ANOVA

|Parameter       | Eta2|   CI| CI_low| CI_high|
|:---------------|----:|----:|------:|-------:|
|GenKI_Erfahrung |    0| 0.95|      0|       1|

> fn_Akzeptanz_Analyse(daten, "Geschlecht")
# Statistiken für "Geschlecht" 


Table: Häufigkeiten

|Geschlecht |   N|  Perc|    M|
|:----------|---:|-----:|----:|
|weiblich   | 175| 46.67| 3.25|
|männlich   | 198| 52.80| 3.21|
|divers     |   2|  0.53| 3.67|

## Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 3.7033, df = 2, p-value = 0.157


## Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.
### Modell-Koeffizienten


Table: Modell-Koeffizienten

|                   | coef(model)|
|:------------------|-----------:|
|(Intercept)        |       3.246|
|Geschlechtmännlich |      -0.040|
|Geschlechtdivers   |       0.421|

### Zusammenfassung des Modells

Table: Zusammenfassung des ANOVA-Modells

|Parameter  | Sum_Squares|  df| Mean_Square|    F|    p|
|:----------|-----------:|---:|-----------:|----:|----:|
|Geschlecht |        0.54|   2|        0.27| 0.23| 0.79|
|Residuals  |      432.75| 372|        1.16|   NA|   NA|

### Effektgrößen

Table: Effektgrößen der ANOVA

|Parameter  | Eta2|   CI| CI_low| CI_high|
|:----------|----:|----:|------:|-------:|
|Geschlecht |    0| 0.95|      0|       1|

> fn_Akzeptanz_Analyse(daten, "Bildungsabschluss")
# Statistiken für "Bildungsabschluss" 


Table: Häufigkeiten

|Bildungsabschluss                   |   N|  Perc|    M|
|:-----------------------------------|---:|-----:|----:|
|Volks- oder Hauptschulabschluss     |   1|  0.27| 4.33|
|Mittlere Reife (Realschulabschluss) |  27|  7.20| 3.32|
|Abitur oder Fachabitur              | 144| 38.40| 3.22|
|Hochschulabschluss                  | 196| 52.27| 3.23|
|Promotion oder Habilitation         |   7|  1.87| 2.62|

## Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 3.8439, df = 4, p-value = 0.4275


## Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.
### Modell-Koeffizienten


Table: Modell-Koeffizienten

|                                                     | coef(model)|
|:----------------------------------------------------|-----------:|
|(Intercept)                                          |       4.333|
|BildungsabschlussMittlere Reife (Realschulabschluss) |      -1.012|
|BildungsabschlussAbitur oder Fachabitur              |      -1.113|
|BildungsabschlussHochschulabschluss                  |      -1.099|
|BildungsabschlussPromotion oder Habilitation         |      -1.714|

### Zusammenfassung des Modells

Table: Zusammenfassung des ANOVA-Modells

|Parameter         | Sum_Squares|  df| Mean_Square|    F|    p|
|:-----------------|-----------:|---:|-----------:|----:|----:|
|Bildungsabschluss |        4.07|   4|        1.02| 0.88| 0.48|
|Residuals         |      429.22| 370|        1.16|   NA|   NA|

### Effektgrößen

Table: Effektgrößen der ANOVA

|Parameter         | Eta2|   CI| CI_low| CI_high|
|:-----------------|----:|----:|------:|-------:|
|Bildungsabschluss | 0.01| 0.95|      0|       1|

> fn_Akzeptanz_Analyse(daten, "Berufserfahrung")
# Statistiken für "Berufserfahrung" 


Table: Häufigkeiten

|Berufserfahrung    |   N|  Perc|    M|
|:------------------|---:|-----:|----:|
|keine              |   7|  1.87| 3.05|
|weniger als 1 Jahr |   6|  1.60| 3.22|
|1-5 Jahre          |  75| 20.00| 3.25|
|5-10 Jahre         |  43| 11.47| 3.32|
|mehr als 10 Jahre  | 244| 65.07| 3.21|

## Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 3.2715, df = 4, p-value = 0.5135


## Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.
### Modell-Koeffizienten


Table: Modell-Koeffizienten

|                                  | coef(model)|
|:---------------------------------|-----------:|
|(Intercept)                       |       3.048|
|Berufserfahrungweniger als 1 Jahr |       0.175|
|Berufserfahrung1-5 Jahre          |       0.206|
|Berufserfahrung5-10 Jahre         |       0.270|
|Berufserfahrungmehr als 10 Jahre  |       0.160|

### Zusammenfassung des Modells

Table: Zusammenfassung des ANOVA-Modells

|Parameter       | Sum_Squares|  df| Mean_Square|    F|    p|
|:---------------|-----------:|---:|-----------:|----:|----:|
|Berufserfahrung |        0.72|   4|        0.18| 0.15| 0.96|
|Residuals       |      432.57| 370|        1.17|   NA|   NA|

### Effektgrößen

Table: Effektgrößen der ANOVA

|Parameter       | Eta2|   CI| CI_low| CI_high|
|:---------------|----:|----:|------:|-------:|
|Berufserfahrung |    0| 0.95|      0|       1|

> fn_Akzeptanz_Analyse(daten, "Berufsstatus")
# Statistiken für "Berufsstatus" 


Table: Häufigkeiten

|Berufsstatus       |   N| Perc|    M|
|:------------------|---:|----:|----:|
|nicht erwerbstätig |  12|  3.2| 3.47|
|erwerbstätig       | 291| 77.6| 3.28|
|im Studium         |  63| 16.8| 3.01|
|in der Ausbildung  |   9|  2.4| 2.56|

## Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 4.3073, df = 3, p-value = 0.2301


## Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.
### Modell-Koeffizienten


Table: Modell-Koeffizienten

|                              | coef(model)|
|:-----------------------------|-----------:|
|(Intercept)                   |       3.472|
|Berufsstatuserwerbstätig      |      -0.188|
|Berufsstatusim Studium        |      -0.462|
|Berufsstatusin der Ausbildung |      -0.917|

### Zusammenfassung des Modells

Table: Zusammenfassung des ANOVA-Modells

|Parameter    | Sum_Squares|  df| Mean_Square|    F|    p|
|:------------|-----------:|---:|-----------:|----:|----:|
|Berufsstatus |        8.68|   3|        2.89| 2.53| 0.06|
|Residuals    |      424.61| 371|        1.14|   NA|   NA|

### Effektgrößen

Table: Effektgrößen der ANOVA

|Parameter    | Eta2|   CI| CI_low| CI_high|
|:------------|----:|----:|------:|-------:|
|Berufsstatus | 0.02| 0.95|      0|       1|

> fn_Akzeptanz_Analyse(daten, "Alter")
# Statistiken für "Alter" 


Table: Häufigkeiten

| Alter|  N| Perc|    M|
|-----:|--:|----:|----:|
|    18|  4| 1.07| 3.25|
|    19|  7| 1.87| 2.33|
|    20|  8| 2.13| 3.50|
|    21| 12| 3.20| 3.25|
|    22|  9| 2.40| 3.04|
|    23|  7| 1.87| 3.57|
|    24| 12| 3.20| 3.39|
|    25| 14| 3.73| 3.45|
|    26|  9| 2.40| 2.48|
|    27| 16| 4.27| 3.27|
|    28|  7| 1.87| 3.29|
|    29|  6| 1.60| 3.61|
|    30|  9| 2.40| 3.56|
|    31|  7| 1.87| 2.71|
|    32| 13| 3.47| 3.62|
|    33|  5| 1.33| 3.60|
|    34|  9| 2.40| 3.19|
|    35|  7| 1.87| 2.38|
|    36| 14| 3.73| 3.14|
|    37|  5| 1.33| 3.27|
|    38| 11| 2.93| 3.52|
|    39|  9| 2.40| 2.78|
|    40| 10| 2.67| 3.27|
|    41|  6| 1.60| 3.94|
|    42|  7| 1.87| 3.52|
|    43|  6| 1.60| 3.50|
|    44|  8| 2.13| 4.08|
|    45| 11| 2.93| 3.52|
|    46| 11| 2.93| 3.48|
|    47|  6| 1.60| 3.28|
|    48|  8| 2.13| 2.50|
|    49|  5| 1.33| 3.53|
|    50|  9| 2.40| 3.78|
|    51|  8| 2.13| 3.12|
|    52| 11| 2.93| 2.73|
|    53|  7| 1.87| 2.71|
|    54|  4| 1.07| 2.08|
|    55|  3| 0.80| 2.89|
|    56| 12| 3.20| 2.83|
|    57|  7| 1.87| 2.57|
|    58|  4| 1.07| 2.00|
|    59|  6| 1.60| 3.78|
|    60|  6| 1.60| 3.56|
|    61|  3| 0.80| 4.00|
|    62|  3| 0.80| 3.89|
|    63|  3| 0.80| 3.22|
|    64|  4| 1.07| 3.25|
|    65|  2| 0.53| 2.67|
|    66|  2| 0.53| 4.00|
|    67|  1| 0.27| 3.00|
|    68|  1| 0.27| 4.00|
|    78|  1| 0.27| 3.00|

## Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 0.32741, df = 1, p-value = 0.5672


## Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.
### Modell-Koeffizienten


Table: Modell-Koeffizienten

|            | coef(model)|
|:-----------|-----------:|
|(Intercept) |       3.291|
|Alter       |      -0.002|

### Zusammenfassung des Modells

Table: Zusammenfassung des ANOVA-Modells

|Parameter | Sum_Squares|  df| Mean_Square|    F|   p|
|:---------|-----------:|---:|-----------:|----:|---:|
|Alter     |        0.17|   1|        0.17| 0.15| 0.7|
|Residuals |      433.12| 373|        1.16|   NA|  NA|

### Effektgrößen

Table: Effektgrößen der ANOVA

|Parameter | Eta2|   CI| CI_low| CI_high|
|:---------|----:|----:|------:|-------:|
|Alter     |    0| 0.95|      0|       1|

> # Kombiniertes Modell
> fn_Akzeptanz_Analyse(daten, "GenKI_Erfahrung + Geschlecht + Bildungsabschluss + Berufserfahrung + Berufsstatus + Alter")
# Statistiken für "GenKI_Erfahrung + Geschlecht + Bildungsabschluss + Berufserfahrung + Berufsstatus + Alter" 

## Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 17.589, df = 18, p-value = 0.483


## Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.
### Modell-Koeffizienten


Table: Modell-Koeffizienten

|                                                     | coef(model)|
|:----------------------------------------------------|-----------:|
|(Intercept)                                          |       4.613|
|GenKI_Erfahrunggering                                |       0.170|
|GenKI_Erfahrungmittel                                |       0.191|
|GenKI_Erfahrunghoch                                  |       0.229|
|GenKI_Erfahrungsehr hoch                             |       0.312|
|Geschlechtmännlich                                   |      -0.064|
|Geschlechtdivers                                     |       0.303|
|BildungsabschlussMittlere Reife (Realschulabschluss) |      -1.156|
|BildungsabschlussAbitur oder Fachabitur              |      -1.245|
|BildungsabschlussHochschulabschluss                  |      -1.309|
|BildungsabschlussPromotion oder Habilitation         |      -1.933|
|Berufserfahrungweniger als 1 Jahr                    |       0.339|
|Berufserfahrung1-5 Jahre                             |       0.316|
|Berufserfahrung5-10 Jahre                            |       0.129|
|Berufserfahrungmehr als 10 Jahre                     |       0.035|
|Berufsstatuserwerbstätig                             |      -0.181|
|Berufsstatusim Studium                               |      -0.716|
|Berufsstatusin der Ausbildung                        |      -1.216|
|Alter                                                |      -0.002|

### Zusammenfassung des Modells

Table: Zusammenfassung des ANOVA-Modells

|Parameter         | Sum_Squares|  df| Mean_Square|    F|    p|
|:-----------------|-----------:|---:|-----------:|----:|----:|
|GenKI_Erfahrung   |        1.05|   4|        0.26| 0.23| 0.92|
|Geschlecht        |        0.63|   2|        0.32| 0.27| 0.76|
|Bildungsabschluss |        4.41|   4|        1.10| 0.95| 0.43|
|Berufserfahrung   |        0.65|   4|        0.16| 0.14| 0.97|
|Berufsstatus      |       14.77|   3|        4.92| 4.26| 0.01|
|Alter             |        0.06|   1|        0.06| 0.05| 0.82|
|Residuals         |      411.72| 356|        1.16|   NA|   NA|

### Effektgrößen

Table: Effektgrößen der ANOVA

|Parameter         | Eta2_partial|   CI| CI_low| CI_high|
|:-----------------|------------:|----:|------:|-------:|
|GenKI_Erfahrung   |         0.00| 0.95|   0.00|       1|
|Geschlecht        |         0.00| 0.95|   0.00|       1|
|Bildungsabschluss |         0.01| 0.95|   0.00|       1|
|Berufserfahrung   |         0.00| 0.95|   0.00|       1|
|Berufsstatus      |         0.03| 0.95|   0.01|       1|
|Alter             |         0.00| 0.95|   0.00|       1|
