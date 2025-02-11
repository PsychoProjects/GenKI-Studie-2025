
> source("InstallPackages.R")

> source("Read_Data.R")
[1] "Daten werden geladen..."

> # Analysefunktion
> fn_Akzeptanz_Analyse <- function(daten, resp_var, input_var) {
+   cat("## Statistiken für", resp_var, " ~ ", input_var, "\n")
+   
+   if (!is.null(daten[[input_var]])) {
+     stats <- daten %>% group_by(!!sym(input_var)) %>%
+       summarise(
+         N = n(),
+         Perc = n() / nrow(daten) * 100,
+         M = mean(!!sym(resp_var), na.rm = TRUE)
+       )
+     print(kable(stats, caption = "Häufigkeiten", digits = 2), "\n")
+   }
+   
+   ## Analyseformel zusammensetzen
+   formula <- as.formula(paste(resp_var, input_var, sep = " ~ "))  
+ 
+   ## Lineares Modell erstellen
+   model <- lm(formula, data = daten)  # Regressionmodell
+   
+   cat("\n### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test\n")
+   bp_test <- bptest(model)
+   print(bp_test)
+ 
+   ## Falls Heteroskedastizität vorliegt, robuste Standardfehler und robuste ANOVA verwenden
+   if (bp_test$p.value < 0.05) {
+     cat("\n### Robuste Standardfehler:")
+     robust_se <- coeftest(model, vcov = vcovHC( .... [TRUNCATED] 

> # Akzeptanz-Analysen
> ## Analyse der Akzeptanz in Abhängigkeit von verschiedenen Variablen
> fn_Akzeptanz_Analyse(daten, "Akzeptanz", "GenKI_Erfahrung")
## Statistiken für Akzeptanz  ~  GenKI_Erfahrung 


Table: Häufigkeiten

|GenKI_Erfahrung |   N|  Perc|    M|
|:---------------|---:|-----:|----:|
|sehr gering     |  49| 13.07| 3.12|
|gering          |  95| 25.33| 3.21|
|mittel          | 145| 38.67| 3.24|
|hoch            |  69| 18.40| 3.29|
|sehr hoch       |  17|  4.53| 3.29|

### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 6.2066, df = 4, p-value = 0.1842


### Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.
### Modell-Koeffizienten


Table: Modell-Koeffizienten

|                         | coef(model)|
|:------------------------|-----------:|
|(Intercept)              |        3.12|
|GenKI_Erfahrunggering    |        0.09|
|GenKI_Erfahrungmittel    |        0.12|
|GenKI_Erfahrunghoch      |        0.18|
|GenKI_Erfahrungsehr hoch |        0.18|

### Zusammenfassung des Modells

Table: Zusammenfassung des ANOVA-Modells

|Parameter       | Sum_Squares|  df| Mean_Square|     F|     p|
|:---------------|-----------:|---:|-----------:|-----:|-----:|
|GenKI_Erfahrung |       1.052|   4|       0.263| 0.225| 0.924|
|Residuals       |     432.237| 370|       1.168|    NA|    NA|

### Effektgrößen

Table: Effektgrößen der ANOVA

|Parameter       |  Eta2|   CI| CI_low| CI_high|
|:---------------|-----:|----:|------:|-------:|
|GenKI_Erfahrung | 0.002| 0.95|      0|       1|

> fn_Akzeptanz_Analyse(daten, "Akzeptanz", "Geschlecht")
## Statistiken für Akzeptanz  ~  Geschlecht 


Table: Häufigkeiten

|Geschlecht |   N|  Perc|    M|
|:----------|---:|-----:|----:|
|weiblich   | 175| 46.67| 3.25|
|männlich   | 198| 52.80| 3.21|
|divers     |   2|  0.53| 3.67|

### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 3.7033, df = 2, p-value = 0.157


### Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.
### Modell-Koeffizienten


Table: Modell-Koeffizienten

|                   | coef(model)|
|:------------------|-----------:|
|(Intercept)        |        3.25|
|Geschlechtmännlich |       -0.04|
|Geschlechtdivers   |        0.42|

### Zusammenfassung des Modells

Table: Zusammenfassung des ANOVA-Modells

|Parameter  | Sum_Squares|  df| Mean_Square|     F|     p|
|:----------|-----------:|---:|-----------:|-----:|-----:|
|Geschlecht |       0.540|   2|       0.270| 0.232| 0.793|
|Residuals  |     432.749| 372|       1.163|    NA|    NA|

### Effektgrößen

Table: Effektgrößen der ANOVA

|Parameter  |  Eta2|   CI| CI_low| CI_high|
|:----------|-----:|----:|------:|-------:|
|Geschlecht | 0.001| 0.95|      0|       1|

> fn_Akzeptanz_Analyse(daten, "Akzeptanz", "Bildungsabschluss")
## Statistiken für Akzeptanz  ~  Bildungsabschluss 


Table: Häufigkeiten

|Bildungsabschluss                   |   N|  Perc|    M|
|:-----------------------------------|---:|-----:|----:|
|Volks- oder Hauptschulabschluss     |   1|  0.27| 4.33|
|Mittlere Reife (Realschulabschluss) |  27|  7.20| 3.32|
|Abitur oder Fachabitur              | 144| 38.40| 3.22|
|Hochschulabschluss                  | 196| 52.27| 3.23|
|Promotion oder Habilitation         |   7|  1.87| 2.62|

### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 3.8439, df = 4, p-value = 0.4275


### Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.
### Modell-Koeffizienten


Table: Modell-Koeffizienten

|                                                     | coef(model)|
|:----------------------------------------------------|-----------:|
|(Intercept)                                          |        4.33|
|BildungsabschlussMittlere Reife (Realschulabschluss) |       -1.01|
|BildungsabschlussAbitur oder Fachabitur              |       -1.11|
|BildungsabschlussHochschulabschluss                  |       -1.10|
|BildungsabschlussPromotion oder Habilitation         |       -1.71|

### Zusammenfassung des Modells

Table: Zusammenfassung des ANOVA-Modells

|Parameter         | Sum_Squares|  df| Mean_Square|     F|     p|
|:-----------------|-----------:|---:|-----------:|-----:|-----:|
|Bildungsabschluss |       4.069|   4|       1.017| 0.877| 0.478|
|Residuals         |     429.220| 370|       1.160|    NA|    NA|

### Effektgrößen

Table: Effektgrößen der ANOVA

|Parameter         |  Eta2|   CI| CI_low| CI_high|
|:-----------------|-----:|----:|------:|-------:|
|Bildungsabschluss | 0.009| 0.95|      0|       1|

> fn_Akzeptanz_Analyse(daten, "Akzeptanz", "Berufserfahrung")
## Statistiken für Akzeptanz  ~  Berufserfahrung 


Table: Häufigkeiten

|Berufserfahrung    |   N|  Perc|    M|
|:------------------|---:|-----:|----:|
|keine              |   7|  1.87| 3.05|
|weniger als 1 Jahr |   6|  1.60| 3.22|
|1-5 Jahre          |  75| 20.00| 3.25|
|5-10 Jahre         |  43| 11.47| 3.32|
|mehr als 10 Jahre  | 244| 65.07| 3.21|

### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 3.2715, df = 4, p-value = 0.5135


### Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.
### Modell-Koeffizienten


Table: Modell-Koeffizienten

|                                  | coef(model)|
|:---------------------------------|-----------:|
|(Intercept)                       |        3.05|
|Berufserfahrungweniger als 1 Jahr |        0.17|
|Berufserfahrung1-5 Jahre          |        0.21|
|Berufserfahrung5-10 Jahre         |        0.27|
|Berufserfahrungmehr als 10 Jahre  |        0.16|

### Zusammenfassung des Modells

Table: Zusammenfassung des ANOVA-Modells

|Parameter       | Sum_Squares|  df| Mean_Square|     F|     p|
|:---------------|-----------:|---:|-----------:|-----:|-----:|
|Berufserfahrung |       0.723|   4|       0.181| 0.155| 0.961|
|Residuals       |     432.565| 370|       1.169|    NA|    NA|

### Effektgrößen

Table: Effektgrößen der ANOVA

|Parameter       |  Eta2|   CI| CI_low| CI_high|
|:---------------|-----:|----:|------:|-------:|
|Berufserfahrung | 0.002| 0.95|      0|       1|

> fn_Akzeptanz_Analyse(daten, "Akzeptanz", "Berufsstatus")
## Statistiken für Akzeptanz  ~  Berufsstatus 


Table: Häufigkeiten

|Berufsstatus       |   N| Perc|    M|
|:------------------|---:|----:|----:|
|nicht erwerbstätig |  12|  3.2| 3.47|
|erwerbstätig       | 291| 77.6| 3.28|
|im Studium         |  63| 16.8| 3.01|
|in der Ausbildung  |   9|  2.4| 2.56|

### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 4.3073, df = 3, p-value = 0.2301


### Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.
### Modell-Koeffizienten


Table: Modell-Koeffizienten

|                              | coef(model)|
|:-----------------------------|-----------:|
|(Intercept)                   |        3.47|
|Berufsstatuserwerbstätig      |       -0.19|
|Berufsstatusim Studium        |       -0.46|
|Berufsstatusin der Ausbildung |       -0.92|

### Zusammenfassung des Modells

Table: Zusammenfassung des ANOVA-Modells

|Parameter    | Sum_Squares|  df| Mean_Square|     F|     p|
|:------------|-----------:|---:|-----------:|-----:|-----:|
|Berufsstatus |       8.678|   3|       2.893| 2.527| 0.057|
|Residuals    |     424.611| 371|       1.145|    NA|    NA|

### Effektgrößen

Table: Effektgrößen der ANOVA

|Parameter    | Eta2|   CI| CI_low| CI_high|
|:------------|----:|----:|------:|-------:|
|Berufsstatus | 0.02| 0.95|      0|       1|

> fn_Akzeptanz_Analyse(daten, "Akzeptanz", "Alter")
## Statistiken für Akzeptanz  ~  Alter 


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

### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 0.32741, df = 1, p-value = 0.5672


### Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.
### Modell-Koeffizienten


Table: Modell-Koeffizienten

|            | coef(model)|
|:-----------|-----------:|
|(Intercept) |        3.29|
|Alter       |        0.00|

### Zusammenfassung des Modells

Table: Zusammenfassung des ANOVA-Modells

|Parameter | Sum_Squares|  df| Mean_Square|     F|   p|
|:---------|-----------:|---:|-----------:|-----:|---:|
|Alter     |       0.173|   1|       0.173| 0.149| 0.7|
|Residuals |     433.116| 373|       1.161|    NA|  NA|

### Effektgrößen

Table: Effektgrößen der ANOVA

|Parameter | Eta2|   CI| CI_low| CI_high|
|:---------|----:|----:|------:|-------:|
|Alter     |    0| 0.95|      0|       1|

> ## Kombiniertes Modell
> fn_Akzeptanz_Analyse(daten, "Akzeptanz", "GenKI_Erfahrung * Anwendungsfeld")
## Statistiken für Akzeptanz  ~  GenKI_Erfahrung * Anwendungsfeld 

### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 32.665, df = 9, p-value = 0.0001527


### Robuste Standardfehler:
t test of coefficients:

                                                  Estimate Std. Error t value  Pr(>|t|)    
(Intercept)                                       3.690476   0.144954 25.4597 < 2.2e-16 ***
GenKI_Erfahrunggering                            -0.016865   0.195867 -0.0861    0.9314    
GenKI_Erfahrungmittel                             0.248120   0.163730  1.5154    0.1305    
GenKI_Erfahrunghoch                               0.163690   0.180442  0.9072    0.3649    
GenKI_Erfahrungsehr hoch                          0.214286   0.550635  0.3892    0.6974    
AnwendungsfeldSubjektiv                          -1.341270   0.259591 -5.1669 3.926e-07 ***
GenKI_Erfahrunggering:AnwendungsfeldSubjektiv     0.398155   0.322204  1.2357    0.2174    
GenKI_Erfahrungmittel:AnwendungsfeldSubjektiv    -0.133559   0.295179 -0.4525    0.6512    
GenKI_Erfahrunghoch:AnwendungsfeldSubjektiv       0.297914   0.331499  0.8987    0.3694    
GenKI_Erfahrungsehr hoch:AnwendungsfeldSubjektiv  0.303175   0.745576  0.4066    0.6845    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

### Robuste ANOVA-Ergebnisse:Analysis of Deviance Table (Type III tests)

Response: Akzeptanz
                                Df        F    Pr(>F)    
(Intercept)                      1 648.1949 < 2.2e-16 ***
GenKI_Erfahrung                  4   1.0901    0.3611    
Anwendungsfeld                   1  26.6965 3.926e-07 ***
GenKI_Erfahrung:Anwendungsfeld   4   1.5894    0.1765    
Residuals                      365                       
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> fn_Akzeptanz_Analyse(daten, "Akzeptanz", "GenKI_Erfahrung * Geschlecht")
## Statistiken für Akzeptanz  ~  GenKI_Erfahrung * Geschlecht 

### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 12.384, df = 10, p-value = 0.2602


### Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.
### Modell-Koeffizienten


Table: Modell-Koeffizienten

|                                            | coef(model)|
|:-------------------------------------------|-----------:|
|(Intercept)                                 |        3.23|
|GenKI_Erfahrunggering                       |       -0.04|
|GenKI_Erfahrungmittel                       |       -0.05|
|GenKI_Erfahrunghoch                         |        0.18|
|GenKI_Erfahrungsehr hoch                    |        0.68|
|Geschlechtmännlich                          |       -0.26|
|Geschlechtdivers                            |        0.48|
|GenKI_Erfahrunggering:Geschlechtmännlich    |        0.28|
|GenKI_Erfahrungmittel:Geschlechtmännlich    |        0.36|
|GenKI_Erfahrunghoch:Geschlechtmännlich      |        0.08|
|GenKI_Erfahrungsehr hoch:Geschlechtmännlich |       -0.55|
|GenKI_Erfahrunggering:Geschlechtdivers      |          NA|
|GenKI_Erfahrungmittel:Geschlechtdivers      |          NA|
|GenKI_Erfahrunghoch:Geschlechtdivers        |          NA|
|GenKI_Erfahrungsehr hoch:Geschlechtdivers   |          NA|

### Zusammenfassung des Modells

Table: Zusammenfassung des ANOVA-Modells

|Parameter                  | Sum_Squares|  df| Mean_Square|     F|     p|
|:--------------------------|-----------:|---:|-----------:|-----:|-----:|
|GenKI_Erfahrung            |       1.052|   4|       0.263| 0.224| 0.925|
|Geschlecht                 |       0.634|   2|       0.317| 0.270| 0.764|
|GenKI_Erfahrung:Geschlecht |       3.509|   4|       0.877| 0.746| 0.561|
|Residuals                  |     428.093| 364|       1.176|    NA|    NA|

### Effektgrößen

Table: Effektgrößen der ANOVA

|Parameter                  | Eta2_partial|   CI| CI_low| CI_high|
|:--------------------------|------------:|----:|------:|-------:|
|GenKI_Erfahrung            |        0.002| 0.95|      0|       1|
|Geschlecht                 |        0.001| 0.95|      0|       1|
|GenKI_Erfahrung:Geschlecht |        0.008| 0.95|      0|       1|

> # Einstellungs-Analysen
> ## Analyse der Einstellung gegenüber KI in Abhängigkeit von verschiedenen Variablen
> fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "GenKI_Erfahrung")
## Statistiken für Einstellung_KI  ~  GenKI_Erfahrung 


Table: Häufigkeiten

|GenKI_Erfahrung |   N|  Perc|    M|
|:---------------|---:|-----:|----:|
|sehr gering     |  49| 13.07| 3.25|
|gering          |  95| 25.33| 3.54|
|mittel          | 145| 38.67| 3.68|
|hoch            |  69| 18.40| 3.86|
|sehr hoch       |  17|  4.53| 4.28|

### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 9.032, df = 4, p-value = 0.0603


### Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.
### Modell-Koeffizienten


Table: Modell-Koeffizienten

|                         | coef(model)|
|:------------------------|-----------:|
|(Intercept)              |        3.25|
|GenKI_Erfahrunggering    |        0.30|
|GenKI_Erfahrungmittel    |        0.44|
|GenKI_Erfahrunghoch      |        0.62|
|GenKI_Erfahrungsehr hoch |        1.04|

### Zusammenfassung des Modells

Table: Zusammenfassung des ANOVA-Modells

|Parameter       | Sum_Squares|  df| Mean_Square|      F|  p|
|:---------------|-----------:|---:|-----------:|------:|--:|
|GenKI_Erfahrung |      19.262|   4|       4.816| 14.044|  0|
|Residuals       |     126.869| 370|       0.343|     NA| NA|

### Effektgrößen

Table: Effektgrößen der ANOVA

|Parameter       |  Eta2|   CI| CI_low| CI_high|
|:---------------|-----:|----:|------:|-------:|
|GenKI_Erfahrung | 0.132| 0.95|  0.077|       1|

> fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "Geschlecht")
## Statistiken für Einstellung_KI  ~  Geschlecht 


Table: Häufigkeiten

|Geschlecht |   N|  Perc|    M|
|:----------|---:|-----:|----:|
|weiblich   | 175| 46.67| 3.52|
|männlich   | 198| 52.80| 3.77|
|divers     |   2|  0.53| 2.92|

### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 0.30703, df = 2, p-value = 0.8577


### Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.
### Modell-Koeffizienten


Table: Modell-Koeffizienten

|                   | coef(model)|
|:------------------|-----------:|
|(Intercept)        |        3.52|
|Geschlechtmännlich |        0.25|
|Geschlechtdivers   |       -0.61|

### Zusammenfassung des Modells

Table: Zusammenfassung des ANOVA-Modells

|Parameter  | Sum_Squares|  df| Mean_Square|     F|  p|
|:----------|-----------:|---:|-----------:|-----:|--:|
|Geschlecht |       6.929|   2|       3.464| 9.258|  0|
|Residuals  |     139.203| 372|       0.374|    NA| NA|

### Effektgrößen

Table: Effektgrößen der ANOVA

|Parameter  |  Eta2|   CI| CI_low| CI_high|
|:----------|-----:|----:|------:|-------:|
|Geschlecht | 0.047| 0.95|  0.016|       1|

> fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "Bildungsabschluss")
## Statistiken für Einstellung_KI  ~  Bildungsabschluss 


Table: Häufigkeiten

|Bildungsabschluss                   |   N|  Perc|    M|
|:-----------------------------------|---:|-----:|----:|
|Volks- oder Hauptschulabschluss     |   1|  0.27| 3.75|
|Mittlere Reife (Realschulabschluss) |  27|  7.20| 3.79|
|Abitur oder Fachabitur              | 144| 38.40| 3.61|
|Hochschulabschluss                  | 196| 52.27| 3.67|
|Promotion oder Habilitation         |   7|  1.87| 3.45|

### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 2.4998, df = 4, p-value = 0.6447


### Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.
### Modell-Koeffizienten


Table: Modell-Koeffizienten

|                                                     | coef(model)|
|:----------------------------------------------------|-----------:|
|(Intercept)                                          |        3.75|
|BildungsabschlussMittlere Reife (Realschulabschluss) |        0.04|
|BildungsabschlussAbitur oder Fachabitur              |       -0.14|
|BildungsabschlussHochschulabschluss                  |       -0.08|
|BildungsabschlussPromotion oder Habilitation         |       -0.30|

### Zusammenfassung des Modells

Table: Zusammenfassung des ANOVA-Modells

|Parameter         | Sum_Squares|  df| Mean_Square|     F|    p|
|:-----------------|-----------:|---:|-----------:|-----:|----:|
|Bildungsabschluss |       1.195|   4|       0.299| 0.763| 0.55|
|Residuals         |     144.936| 370|       0.392|    NA|   NA|

### Effektgrößen

Table: Effektgrößen der ANOVA

|Parameter         |  Eta2|   CI| CI_low| CI_high|
|:-----------------|-----:|----:|------:|-------:|
|Bildungsabschluss | 0.008| 0.95|      0|       1|

> fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "Berufserfahrung")
## Statistiken für Einstellung_KI  ~  Berufserfahrung 


Table: Häufigkeiten

|Berufserfahrung    |   N|  Perc|    M|
|:------------------|---:|-----:|----:|
|keine              |   7|  1.87| 3.74|
|weniger als 1 Jahr |   6|  1.60| 3.40|
|1-5 Jahre          |  75| 20.00| 3.65|
|5-10 Jahre         |  43| 11.47| 3.72|
|mehr als 10 Jahre  | 244| 65.07| 3.64|

### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 2.3143, df = 4, p-value = 0.6782


### Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.
### Modell-Koeffizienten


Table: Modell-Koeffizienten

|                                  | coef(model)|
|:---------------------------------|-----------:|
|(Intercept)                       |        3.74|
|Berufserfahrungweniger als 1 Jahr |       -0.34|
|Berufserfahrung1-5 Jahre          |       -0.09|
|Berufserfahrung5-10 Jahre         |       -0.02|
|Berufserfahrungmehr als 10 Jahre  |       -0.10|

### Zusammenfassung des Modells

Table: Zusammenfassung des ANOVA-Modells

|Parameter       | Sum_Squares|  df| Mean_Square|     F|    p|
|:---------------|-----------:|---:|-----------:|-----:|----:|
|Berufserfahrung |       0.627|   4|       0.157| 0.399| 0.81|
|Residuals       |     145.504| 370|       0.393|    NA|   NA|

### Effektgrößen

Table: Effektgrößen der ANOVA

|Parameter       |  Eta2|   CI| CI_low| CI_high|
|:---------------|-----:|----:|------:|-------:|
|Berufserfahrung | 0.004| 0.95|      0|       1|

> fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "Berufsstatus")
## Statistiken für Einstellung_KI  ~  Berufsstatus 


Table: Häufigkeiten

|Berufsstatus       |   N| Perc|    M|
|:------------------|---:|----:|----:|
|nicht erwerbstätig |  12|  3.2| 3.41|
|erwerbstätig       | 291| 77.6| 3.67|
|im Studium         |  63| 16.8| 3.56|
|in der Ausbildung  |   9|  2.4| 3.85|

### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 2.5551, df = 3, p-value = 0.4654


### Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.
### Modell-Koeffizienten


Table: Modell-Koeffizienten

|                              | coef(model)|
|:-----------------------------|-----------:|
|(Intercept)                   |        3.41|
|Berufsstatuserwerbstätig      |        0.27|
|Berufsstatusim Studium        |        0.15|
|Berufsstatusin der Ausbildung |        0.44|

### Zusammenfassung des Modells

Table: Zusammenfassung des ANOVA-Modells

|Parameter    | Sum_Squares|  df| Mean_Square|     F|    p|
|:------------|-----------:|---:|-----------:|-----:|----:|
|Berufsstatus |       1.771|   3|       0.590| 1.517| 0.21|
|Residuals    |     144.360| 371|       0.389|    NA|   NA|

### Effektgrößen

Table: Effektgrößen der ANOVA

|Parameter    |  Eta2|   CI| CI_low| CI_high|
|:------------|-----:|----:|------:|-------:|
|Berufsstatus | 0.012| 0.95|      0|       1|

> fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "Alter")
## Statistiken für Einstellung_KI  ~  Alter 


Table: Häufigkeiten

| Alter|  N| Perc|    M|
|-----:|--:|----:|----:|
|    18|  4| 1.07| 3.40|
|    19|  7| 1.87| 3.55|
|    20|  8| 2.13| 3.96|
|    21| 12| 3.20| 3.50|
|    22|  9| 2.40| 3.65|
|    23|  7| 1.87| 3.81|
|    24| 12| 3.20| 3.81|
|    25| 14| 3.73| 3.64|
|    26|  9| 2.40| 3.58|
|    27| 16| 4.27| 3.97|
|    28|  7| 1.87| 3.65|
|    29|  6| 1.60| 3.71|
|    30|  9| 2.40| 3.59|
|    31|  7| 1.87| 3.36|
|    32| 13| 3.47| 3.61|
|    33|  5| 1.33| 3.80|
|    34|  9| 2.40| 3.61|
|    35|  7| 1.87| 3.39|
|    36| 14| 3.73| 3.93|
|    37|  5| 1.33| 3.70|
|    38| 11| 2.93| 3.80|
|    39|  9| 2.40| 3.33|
|    40| 10| 2.67| 3.48|
|    41|  6| 1.60| 3.82|
|    42|  7| 1.87| 3.57|
|    43|  6| 1.60| 3.51|
|    44|  8| 2.13| 3.88|
|    45| 11| 2.93| 3.71|
|    46| 11| 2.93| 3.68|
|    47|  6| 1.60| 3.65|
|    48|  8| 2.13| 3.61|
|    49|  5| 1.33| 3.87|
|    50|  9| 2.40| 3.37|
|    51|  8| 2.13| 3.74|
|    52| 11| 2.93| 3.42|
|    53|  7| 1.87| 3.51|
|    54|  4| 1.07| 3.67|
|    55|  3| 0.80| 4.17|
|    56| 12| 3.20| 3.77|
|    57|  7| 1.87| 3.15|
|    58|  4| 1.07| 2.98|
|    59|  6| 1.60| 3.76|
|    60|  6| 1.60| 3.33|
|    61|  3| 0.80| 3.97|
|    62|  3| 0.80| 4.36|
|    63|  3| 0.80| 3.94|
|    64|  4| 1.07| 3.81|
|    65|  2| 0.53| 3.29|
|    66|  2| 0.53| 4.00|
|    67|  1| 0.27| 4.33|
|    68|  1| 0.27| 2.67|
|    78|  1| 0.27| 2.58|

### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 2.2329, df = 1, p-value = 0.1351


### Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.
### Modell-Koeffizienten


Table: Modell-Koeffizienten

|            | coef(model)|
|:-----------|-----------:|
|(Intercept) |        3.74|
|Alter       |        0.00|

### Zusammenfassung des Modells

Table: Zusammenfassung des ANOVA-Modells

|Parameter | Sum_Squares|  df| Mean_Square|     F|     p|
|:---------|-----------:|---:|-----------:|-----:|-----:|
|Alter     |       0.316|   1|       0.316| 0.809| 0.369|
|Residuals |     145.815| 373|       0.391|    NA|    NA|

### Effektgrößen

Table: Effektgrößen der ANOVA

|Parameter |  Eta2|   CI| CI_low| CI_high|
|:---------|-----:|----:|------:|-------:|
|Alter     | 0.002| 0.95|      0|       1|

> ## Kombiniertes Modell
> fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "GenKI_Erfahrung * Geschlecht")
## Statistiken für Einstellung_KI  ~  GenKI_Erfahrung * Geschlecht 

### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 11.599, df = 10, p-value = 0.3128


### Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.
### Modell-Koeffizienten


Table: Modell-Koeffizienten

|                                            | coef(model)|
|:-------------------------------------------|-----------:|
|(Intercept)                                 |        3.12|
|GenKI_Erfahrunggering                       |        0.22|
|GenKI_Erfahrungmittel                       |        0.53|
|GenKI_Erfahrunghoch                         |        0.60|
|GenKI_Erfahrungsehr hoch                    |        1.31|
|Geschlechtmännlich                          |        0.27|
|Geschlechtdivers                            |       -0.74|
|GenKI_Erfahrunggering:Geschlechtmännlich    |        0.09|
|GenKI_Erfahrungmittel:Geschlechtmännlich    |       -0.19|
|GenKI_Erfahrunghoch:Geschlechtmännlich      |       -0.05|
|GenKI_Erfahrungsehr hoch:Geschlechtmännlich |       -0.47|
|GenKI_Erfahrunggering:Geschlechtdivers      |          NA|
|GenKI_Erfahrungmittel:Geschlechtdivers      |          NA|
|GenKI_Erfahrunghoch:Geschlechtdivers        |          NA|
|GenKI_Erfahrungsehr hoch:Geschlechtdivers   |          NA|

### Zusammenfassung des Modells

Table: Zusammenfassung des ANOVA-Modells

|Parameter                  | Sum_Squares|  df| Mean_Square|      F|     p|
|:--------------------------|-----------:|---:|-----------:|------:|-----:|
|GenKI_Erfahrung            |      19.262|   4|       4.816| 14.564| 0.000|
|Geschlecht                 |       4.827|   2|       2.413|  7.299| 0.001|
|GenKI_Erfahrung:Geschlecht |       1.687|   4|       0.422|  1.276| 0.279|
|Residuals                  |     120.356| 364|       0.331|     NA|    NA|

### Effektgrößen

Table: Effektgrößen der ANOVA

|Parameter                  | Eta2_partial|   CI| CI_low| CI_high|
|:--------------------------|------------:|----:|------:|-------:|
|GenKI_Erfahrung            |        0.138| 0.95|  0.082|       1|
|Geschlecht                 |        0.039| 0.95|  0.011|       1|
|GenKI_Erfahrung:Geschlecht |        0.014| 0.95|  0.000|       1|

> ### Verteilung der Einstellung nach Geschlecht und GenKI-Erfahrung 
> stats <- daten %>% filter(Geschlecht != "divers") %>% group_by(Geschlecht, GenKI_Erfahrung) %>%
+     summarise(
+       N = n(),
+       Perc = n() / nrow(daten) * 100,
+       M = mean(Einstellung_KI, na.rm = TRUE)
+     )

> print(kable(stats, caption = "Häufigkeiten", digits = 2), "\n")


Table: Häufigkeiten

|Geschlecht |GenKI_Erfahrung |  N|  Perc|    M|
|:----------|:---------------|--:|-----:|----:|
|weiblich   |sehr gering     | 27|  7.20| 3.12|
|weiblich   |gering          | 44| 11.73| 3.34|
|weiblich   |mittel          | 74| 19.73| 3.65|
|weiblich   |hoch            | 26|  6.93| 3.72|
|weiblich   |sehr hoch       |  4|  1.07| 4.44|
|männlich   |sehr gering     | 22|  5.87| 3.40|
|männlich   |gering          | 51| 13.60| 3.71|
|männlich   |mittel          | 69| 18.40| 3.74|
|männlich   |hoch            | 43| 11.47| 3.95|
|männlich   |sehr hoch       | 13|  3.47| 4.24|
