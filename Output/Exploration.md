
> source("InstallPackages.R")

> source("Read_Data.R")
[1] "Daten werden geladen..."

> # Analysefunktion
> fn_Akzeptanz_Analyse <- function(daten, resp_var, input_var) {
+   cat("## Statistiken für", resp_var, " ~ ", input_var, "\n")
+   
+   ## Prädiktoren aufteilen (unterstützt sowohl "+" als auch "*")
+   input_vars <- unlist(strsplit(input_var, " \\+|\\* "))  # Trennung durch "+" oder "*"
+   input_vars <- unique(trimws(input_vars))  # Entfernt doppelte & überflüssige Leerzeichen
+   
+   print(kable(input_vars, caption = "Prädiktoren", col.names = c("Prädiktor")))
+   
+   ## Gruppierte Statistik berechnen
+   if (all(input_vars %in% colnames(daten))) {
+     stats <- daten %>% 
+       group_by(across(all_of(input_vars), .names = "{col}")) %>% 
+       summarise(
+         N = n(),
+         Perc = n() / nrow(daten) * 100,
+         M = mean(!!sym(resp_var), na.rm = TRUE),
+         .groups = "drop"
+       )
+     print(kable(stats, caption = "Häufigkeiten", digits = 2), "\n")
+   }  
+   
+   ## Analyseformel zusammensetzen
+   formula <- as.formula(paste(resp_var, input_var, sep = "  ..." ... [TRUNCATED] 

> # Akzeptanz-Analysen
> ## Analyse der Akzeptanz in Abhängigkeit von verschiedenen Variablen
> fn_Akzeptanz_Analyse(daten, "Akzeptanz", "GenKI_Erfahrung")
## Statistiken für Akzeptanz  ~  GenKI_Erfahrung 


Table: Prädiktoren

|Prädiktor       |
|:---------------|
|GenKI_Erfahrung |


Table: Häufigkeiten

|GenKI_Erfahrung |   N|  Perc|    M|
|:---------------|---:|-----:|----:|
|sehr gering     |  49| 13.07| 3.12|
|gering          |  95| 25.33| 3.21|
|mittel          | 145| 38.67| 3.24|
|hoch            |  69| 18.40| 3.29|
|sehr hoch       |  17|  4.53| 3.29|

### Test auf Normalverteilung der Residuen

	Shapiro-Wilk normality test

data:  model$residuals
W = 0.95982, p-value = 1.311e-08


### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 6.2066, df = 4, p-value = 0.1842


### Lineares Modell mit robusten Standardfehlern:

Table: Robuste Standardfehler

|                         | Estimate| Std..Error| t.value| Pr...t..|
|:------------------------|--------:|----------:|-------:|--------:|
|(Intercept)              |    3.116|      0.155|  20.082|    0.000|
|GenKI_Erfahrunggering    |    0.091|      0.188|   0.486|    0.627|
|GenKI_Erfahrungmittel    |    0.121|      0.180|   0.671|    0.502|
|GenKI_Erfahrunghoch      |    0.179|      0.198|   0.904|    0.366|
|GenKI_Erfahrungsehr hoch |    0.178|      0.383|   0.467|    0.641|

### Robuste ANOVA-Ergebnisse:

Table: Robuste ANOVA-Ergebnisse

|Var             |  Df|       F| Pr(>F)|  Eta2|
|:---------------|---:|-------:|------:|-----:|
|(Intercept)     |   1| 403.303|  0.000|    NA|
|GenKI_Erfahrung |   4|   0.225|  0.924| 0.002|
|Residuals       | 370|      NA|     NA|    NA|

> fn_Akzeptanz_Analyse(daten, "Akzeptanz", "Geschlecht")
## Statistiken für Akzeptanz  ~  Geschlecht 


Table: Prädiktoren

|Prädiktor  |
|:----------|
|Geschlecht |


Table: Häufigkeiten

|Geschlecht |   N|  Perc|    M|
|:----------|---:|-----:|----:|
|weiblich   | 175| 46.67| 3.25|
|männlich   | 198| 52.80| 3.21|
|divers     |   2|  0.53| 3.67|

### Test auf Normalverteilung der Residuen

	Shapiro-Wilk normality test

data:  model$residuals
W = 0.95639, p-value = 4.227e-09


### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 3.7033, df = 2, p-value = 0.157


### Lineares Modell mit robusten Standardfehlern:

Table: Robuste Standardfehler

|                   | Estimate| Std..Error| t.value| Pr...t..|
|:------------------|--------:|----------:|-------:|--------:|
|(Intercept)        |    3.246|      0.077|  42.095|    0.000|
|Geschlechtmännlich |   -0.040|      0.112|  -0.362|    0.718|
|Geschlechtdivers   |    0.421|      0.946|   0.445|    0.657|

### Robuste ANOVA-Ergebnisse:

Table: Robuste ANOVA-Ergebnisse

|Var         |  Df|        F| Pr(>F)|  Eta2|
|:-----------|---:|--------:|------:|-----:|
|(Intercept) |   1| 1772.030|   0.00|    NA|
|Geschlecht  |   2|    0.174|   0.84| 0.001|
|Residuals   | 372|       NA|     NA|    NA|

> #fn_Akzeptanz_Analyse(daten, "Akzeptanz", "Bildungsabschluss")
> fn_Akzeptanz_Analyse(daten, "Akzeptanz", "Berufserfahrung")
## Statistiken für Akzeptanz  ~  Berufserfahrung 


Table: Prädiktoren

|Prädiktor       |
|:---------------|
|Berufserfahrung |


Table: Häufigkeiten

|Berufserfahrung    |   N|  Perc|    M|
|:------------------|---:|-----:|----:|
|keine              |   7|  1.87| 3.05|
|weniger als 1 Jahr |   6|  1.60| 3.22|
|1-5 Jahre          |  75| 20.00| 3.25|
|5-10 Jahre         |  43| 11.47| 3.32|
|mehr als 10 Jahre  | 244| 65.07| 3.21|

### Test auf Normalverteilung der Residuen

	Shapiro-Wilk normality test

data:  model$residuals
W = 0.95836, p-value = 8.04e-09


### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 3.2715, df = 4, p-value = 0.5135


### Lineares Modell mit robusten Standardfehlern:

Table: Robuste Standardfehler

|                                  | Estimate| Std..Error| t.value| Pr...t..|
|:---------------------------------|--------:|----------:|-------:|--------:|
|(Intercept)                       |    3.048|      0.380|   8.014|    0.000|
|Berufserfahrungweniger als 1 Jahr |    0.175|      0.507|   0.344|    0.731|
|Berufserfahrung1-5 Jahre          |    0.206|      0.399|   0.516|    0.606|
|Berufserfahrung5-10 Jahre         |    0.270|      0.414|   0.653|    0.514|
|Berufserfahrungmehr als 10 Jahre  |    0.160|      0.387|   0.414|    0.679|

### Robuste ANOVA-Ergebnisse:

Table: Robuste ANOVA-Ergebnisse

|Var             |  Df|      F| Pr(>F)|  Eta2|
|:---------------|---:|------:|------:|-----:|
|(Intercept)     |   1| 64.223|  0.000|    NA|
|Berufserfahrung |   4|  0.163|  0.957| 0.002|
|Residuals       | 370|     NA|     NA|    NA|

> fn_Akzeptanz_Analyse(daten, "Akzeptanz", "Berufsstatus")
## Statistiken für Akzeptanz  ~  Berufsstatus 


Table: Prädiktoren

|Prädiktor    |
|:------------|
|Berufsstatus |


Table: Häufigkeiten

|Berufsstatus       |   N| Perc|    M|
|:------------------|---:|----:|----:|
|nicht erwerbstätig |  12|  3.2| 3.47|
|erwerbstätig       | 291| 77.6| 3.28|
|im Studium         |  63| 16.8| 3.01|
|in der Ausbildung  |   9|  2.4| 2.56|

### Test auf Normalverteilung der Residuen

	Shapiro-Wilk normality test

data:  model$residuals
W = 0.95868, p-value = 8.945e-09


### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 4.3073, df = 3, p-value = 0.2301


### Lineares Modell mit robusten Standardfehlern:

Table: Robuste Standardfehler

|                              | Estimate| Std..Error| t.value| Pr...t..|
|:-----------------------------|--------:|----------:|-------:|--------:|
|(Intercept)                   |    3.472|      0.194|  17.913|    0.000|
|Berufsstatuserwerbstätig      |   -0.188|      0.204|  -0.923|    0.357|
|Berufsstatusim Studium        |   -0.462|      0.238|  -1.941|    0.053|
|Berufsstatusin der Ausbildung |   -0.917|      0.460|  -1.995|    0.047|

### Robuste ANOVA-Ergebnisse:

Table: Robuste ANOVA-Ergebnisse

|Var          |  Df|       F| Pr(>F)| Eta2|
|:------------|---:|-------:|------:|----:|
|(Intercept)  |   1| 320.880|  0.000|   NA|
|Berufsstatus |   3|   2.461|  0.062| 0.02|
|Residuals    | 371|      NA|     NA|   NA|

> fn_Akzeptanz_Analyse(daten, "Akzeptanz", "Alter")
## Statistiken für Akzeptanz  ~  Alter 


Table: Prädiktoren

|Prädiktor |
|:---------|
|Alter     |


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

### Test auf Normalverteilung der Residuen

	Shapiro-Wilk normality test

data:  model$residuals
W = 0.95704, p-value = 5.221e-09


### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 0.32741, df = 1, p-value = 0.5672


### Lineares Modell mit robusten Standardfehlern:

Table: Robuste Standardfehler

|            | Estimate| Std..Error| t.value| Pr...t..|
|:-----------|--------:|----------:|-------:|--------:|
|(Intercept) |    3.291|      0.165|  19.945|    0.000|
|Alter       |   -0.002|      0.004|  -0.407|    0.684|

### Robuste ANOVA-Ergebnisse:

Table: Robuste ANOVA-Ergebnisse

|Var         |  Df|       F| Pr(>F)| Eta2|
|:-----------|---:|-------:|------:|----:|
|(Intercept) |   1| 397.789|  0.000|   NA|
|Alter       |   1|   0.166|  0.684|    0|
|Residuals   | 373|      NA|     NA|   NA|

> ## Kombiniertes Modell
> fn_Akzeptanz_Analyse(daten, "Akzeptanz", "GenKI_Erfahrung + Anwendungsfeld")
## Statistiken für Akzeptanz  ~  GenKI_Erfahrung + Anwendungsfeld 


Table: Prädiktoren

|Prädiktor       |
|:---------------|
|GenKI_Erfahrung |
|Anwendungsfeld  |


Table: Häufigkeiten

|GenKI_Erfahrung |Anwendungsfeld |  N|  Perc|    M|
|:---------------|:--------------|--:|-----:|----:|
|sehr gering     |Objektiv       | 28|  7.47| 3.69|
|sehr gering     |Subjektiv      | 21|  5.60| 2.35|
|gering          |Objektiv       | 48| 12.80| 3.67|
|gering          |Subjektiv      | 47| 12.53| 2.73|
|mittel          |Objektiv       | 76| 20.27| 3.94|
|mittel          |Subjektiv      | 69| 18.40| 2.46|
|hoch            |Objektiv       | 32|  8.53| 3.85|
|hoch            |Subjektiv      | 37|  9.87| 2.81|
|sehr hoch       |Objektiv       |  7|  1.87| 3.90|
|sehr hoch       |Subjektiv      | 10|  2.67| 2.87|

### Test auf Normalverteilung der Residuen

	Shapiro-Wilk normality test

data:  model$residuals
W = 0.98842, p-value = 0.004487


### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 25.588, df = 5, p-value = 0.0001073


### Lineares Modell mit robusten Standardfehlern:

Table: Robuste Standardfehler

|                         | Estimate| Std..Error| t.value| Pr...t..|
|:------------------------|--------:|----------:|-------:|--------:|
|(Intercept)              |    3.640|      0.125|  29.089|    0.000|
|GenKI_Erfahrunggering    |    0.172|      0.155|   1.109|    0.268|
|GenKI_Erfahrungmittel    |    0.179|      0.140|   1.277|    0.202|
|GenKI_Erfahrunghoch      |    0.311|      0.161|   1.928|    0.055|
|GenKI_Erfahrungsehr hoch |    0.374|      0.348|   1.073|    0.284|
|AnwendungsfeldSubjektiv  |   -1.223|      0.093| -13.090|    0.000|

### Robuste ANOVA-Ergebnisse:

Table: Robuste ANOVA-Ergebnisse

|Var             |  Df|       F| Pr(>F)|  Eta2|
|:---------------|---:|-------:|------:|-----:|
|(Intercept)     |   1| 846.187|  0.000|    NA|
|GenKI_Erfahrung |   4|   1.020|  0.397| 0.002|
|Anwendungsfeld  |   1| 171.342|  0.000| 0.322|
|Residuals       | 369|      NA|     NA|    NA|

> fn_Akzeptanz_Analyse(daten, "Akzeptanz", "GenKI_Erfahrung + Geschlecht")
## Statistiken für Akzeptanz  ~  GenKI_Erfahrung + Geschlecht 


Table: Prädiktoren

|Prädiktor       |
|:---------------|
|GenKI_Erfahrung |
|Geschlecht      |


Table: Häufigkeiten

|GenKI_Erfahrung |Geschlecht |  N|  Perc|    M|
|:---------------|:----------|--:|-----:|----:|
|sehr gering     |weiblich   | 27|  7.20| 3.23|
|sehr gering     |männlich   | 22|  5.87| 2.97|
|gering          |weiblich   | 44| 11.73| 3.20|
|gering          |männlich   | 51| 13.60| 3.22|
|mittel          |weiblich   | 74| 19.73| 3.18|
|mittel          |männlich   | 69| 18.40| 3.28|
|mittel          |divers     |  2|  0.53| 3.67|
|hoch            |weiblich   | 26|  6.93| 3.41|
|hoch            |männlich   | 43| 11.47| 3.22|
|sehr hoch       |weiblich   |  4|  1.07| 3.92|
|sehr hoch       |männlich   | 13|  3.47| 3.10|

### Test auf Normalverteilung der Residuen

	Shapiro-Wilk normality test

data:  model$residuals
W = 0.96182, p-value = 2.606e-08


### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 9.6532, df = 6, p-value = 0.14


### Lineares Modell mit robusten Standardfehlern:

Table: Robuste Standardfehler

|                         | Estimate| Std..Error| t.value| Pr...t..|
|:------------------------|--------:|----------:|-------:|--------:|
|(Intercept)              |    3.140|      0.157|  19.983|    0.000|
|GenKI_Erfahrunggering    |    0.096|      0.190|   0.507|    0.613|
|GenKI_Erfahrungmittel    |    0.117|      0.181|   0.644|    0.520|
|GenKI_Erfahrunghoch      |    0.188|      0.201|   0.939|    0.348|
|GenKI_Erfahrungsehr hoch |    0.195|      0.384|   0.508|    0.612|
|Geschlechtmännlich       |   -0.054|      0.114|  -0.469|    0.640|
|Geschlechtdivers         |    0.410|      0.949|   0.432|    0.666|

### Robuste ANOVA-Ergebnisse:

Table: Robuste ANOVA-Ergebnisse

|Var             |  Df|       F| Pr(>F)|  Eta2|
|:---------------|---:|-------:|------:|-----:|
|(Intercept)     |   1| 399.326|  0.000|    NA|
|GenKI_Erfahrung |   4|   0.241|  0.915| 0.002|
|Geschlecht      |   2|   0.214|  0.807| 0.001|
|Residuals       | 368|      NA|     NA|    NA|

> # Einstellungs-Analysen
> ## Analyse der Einstellung gegenüber KI in Abhängigkeit von verschiedenen Variablen
> fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "GenKI_Erfahrung")
## Statistiken für Einstellung_KI  ~  GenKI_Erfahrung 


Table: Prädiktoren

|Prädiktor       |
|:---------------|
|GenKI_Erfahrung |


Table: Häufigkeiten

|GenKI_Erfahrung |   N|  Perc|    M|
|:---------------|---:|-----:|----:|
|sehr gering     |  49| 13.07| 3.25|
|gering          |  95| 25.33| 3.54|
|mittel          | 145| 38.67| 3.68|
|hoch            |  69| 18.40| 3.86|
|sehr hoch       |  17|  4.53| 4.28|

### Test auf Normalverteilung der Residuen

	Shapiro-Wilk normality test

data:  model$residuals
W = 0.97476, p-value = 4.067e-06


### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 9.032, df = 4, p-value = 0.0603


### Lineares Modell mit robusten Standardfehlern:

Table: Robuste Standardfehler

|                         | Estimate| Std..Error| t.value| Pr...t..|
|:------------------------|--------:|----------:|-------:|--------:|
|(Intercept)              |    3.247|      0.107|  30.368|    0.000|
|GenKI_Erfahrunggering    |    0.296|      0.124|   2.383|    0.018|
|GenKI_Erfahrungmittel    |    0.437|      0.116|   3.775|    0.000|
|GenKI_Erfahrunghoch      |    0.618|      0.126|   4.903|    0.000|
|GenKI_Erfahrungsehr hoch |    1.038|      0.169|   6.156|    0.000|

### Robuste ANOVA-Ergebnisse:

Table: Robuste ANOVA-Ergebnisse

|Var             |  Df|       F| Pr(>F)|  Eta2|
|:---------------|---:|-------:|------:|-----:|
|(Intercept)     |   1| 922.238|      0|    NA|
|GenKI_Erfahrung |   4|  12.591|      0| 0.132|
|Residuals       | 370|      NA|     NA|    NA|

> fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "Geschlecht")
## Statistiken für Einstellung_KI  ~  Geschlecht 


Table: Prädiktoren

|Prädiktor  |
|:----------|
|Geschlecht |


Table: Häufigkeiten

|Geschlecht |   N|  Perc|    M|
|:----------|---:|-----:|----:|
|weiblich   | 175| 46.67| 3.52|
|männlich   | 198| 52.80| 3.77|
|divers     |   2|  0.53| 2.92|

### Test auf Normalverteilung der Residuen

	Shapiro-Wilk normality test

data:  model$residuals
W = 0.97, p-value = 5.536e-07


### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 0.30703, df = 2, p-value = 0.8577


### Lineares Modell mit robusten Standardfehlern:

Table: Robuste Standardfehler

|                   | Estimate| Std..Error| t.value| Pr...t..|
|:------------------|--------:|----------:|-------:|--------:|
|(Intercept)        |    3.522|      0.048|  74.133|    0.000|
|Geschlechtmännlich |    0.251|      0.064|   3.934|    0.000|
|Geschlechtdivers   |   -0.605|      0.826|  -0.732|    0.464|

### Robuste ANOVA-Ergebnisse:

Table: Robuste ANOVA-Ergebnisse

|Var         |  Df|        F| Pr(>F)|  Eta2|
|:-----------|---:|--------:|------:|-----:|
|(Intercept) |   1| 5495.727|      0|    NA|
|Geschlecht  |   2|    8.144|      0| 0.047|
|Residuals   | 372|       NA|     NA|    NA|

> #fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "Bildungsabschluss")
> fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "Berufserfahrung")
## Statistiken für Einstellung_KI  ~  Berufserfahrung 


Table: Prädiktoren

|Prädiktor       |
|:---------------|
|Berufserfahrung |


Table: Häufigkeiten

|Berufserfahrung    |   N|  Perc|    M|
|:------------------|---:|-----:|----:|
|keine              |   7|  1.87| 3.74|
|weniger als 1 Jahr |   6|  1.60| 3.40|
|1-5 Jahre          |  75| 20.00| 3.65|
|5-10 Jahre         |  43| 11.47| 3.72|
|mehr als 10 Jahre  | 244| 65.07| 3.64|

### Test auf Normalverteilung der Residuen

	Shapiro-Wilk normality test

data:  model$residuals
W = 0.97268, p-value = 1.665e-06


### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 2.3143, df = 4, p-value = 0.6782


### Lineares Modell mit robusten Standardfehlern:

Table: Robuste Standardfehler

|                                  | Estimate| Std..Error| t.value| Pr...t..|
|:---------------------------------|--------:|----------:|-------:|--------:|
|(Intercept)                       |    3.738|      0.137|  27.347|    0.000|
|Berufserfahrungweniger als 1 Jahr |   -0.335|      0.334|  -1.003|    0.316|
|Berufserfahrung1-5 Jahre          |   -0.086|      0.153|  -0.563|    0.574|
|Berufserfahrung5-10 Jahre         |   -0.021|      0.166|  -0.126|    0.899|
|Berufserfahrungmehr als 10 Jahre  |   -0.095|      0.143|  -0.667|    0.505|

### Robuste ANOVA-Ergebnisse:

Table: Robuste ANOVA-Ergebnisse

|Var             |  Df|       F| Pr(>F)|  Eta2|
|:---------------|---:|-------:|------:|-----:|
|(Intercept)     |   1| 747.884|  0.000|    NA|
|Berufserfahrung |   4|   0.392|  0.814| 0.004|
|Residuals       | 370|      NA|     NA|    NA|

> fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "Berufsstatus")
## Statistiken für Einstellung_KI  ~  Berufsstatus 


Table: Prädiktoren

|Prädiktor    |
|:------------|
|Berufsstatus |


Table: Häufigkeiten

|Berufsstatus       |   N| Perc|    M|
|:------------------|---:|----:|----:|
|nicht erwerbstätig |  12|  3.2| 3.41|
|erwerbstätig       | 291| 77.6| 3.67|
|im Studium         |  63| 16.8| 3.56|
|in der Ausbildung  |   9|  2.4| 3.85|

### Test auf Normalverteilung der Residuen

	Shapiro-Wilk normality test

data:  model$residuals
W = 0.97398, p-value = 2.89e-06


### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 2.5551, df = 3, p-value = 0.4654


### Lineares Modell mit robusten Standardfehlern:

Table: Robuste Standardfehler

|                              | Estimate| Std..Error| t.value| Pr...t..|
|:-----------------------------|--------:|----------:|-------:|--------:|
|(Intercept)                   |    3.410|      0.172|  19.835|    0.000|
|Berufsstatuserwerbstätig      |    0.265|      0.176|   1.509|    0.132|
|Berufsstatusim Studium        |    0.148|      0.192|   0.775|    0.439|
|Berufsstatusin der Ausbildung |    0.442|      0.202|   2.183|    0.030|

### Robuste ANOVA-Ergebnisse:

Table: Robuste ANOVA-Ergebnisse

|Var          |  Df|       F| Pr(>F)|  Eta2|
|:------------|---:|-------:|------:|-----:|
|(Intercept)  |   1| 393.413|  0.000|    NA|
|Berufsstatus |   3|   2.307|  0.076| 0.012|
|Residuals    | 371|      NA|     NA|    NA|

> fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "Alter")
## Statistiken für Einstellung_KI  ~  Alter 


Table: Prädiktoren

|Prädiktor |
|:---------|
|Alter     |


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

### Test auf Normalverteilung der Residuen

	Shapiro-Wilk normality test

data:  model$residuals
W = 0.9744, p-value = 3.477e-06


### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 2.2329, df = 1, p-value = 0.1351


### Lineares Modell mit robusten Standardfehlern:

Table: Robuste Standardfehler

|            | Estimate| Std..Error| t.value| Pr...t..|
|:-----------|--------:|----------:|-------:|--------:|
|(Intercept) |    3.738|      0.100|  37.542|    0.000|
|Alter       |   -0.002|      0.003|  -0.881|    0.379|

### Robuste ANOVA-Ergebnisse:

Table: Robuste ANOVA-Ergebnisse

|Var         |  Df|        F| Pr(>F)|  Eta2|
|:-----------|---:|--------:|------:|-----:|
|(Intercept) |   1| 1409.425|  0.000|    NA|
|Alter       |   1|    0.777|  0.379| 0.002|
|Residuals   | 373|       NA|     NA|    NA|

> ## Kombiniertes Modell
> fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "GenKI_Erfahrung +  Geschlecht")
## Statistiken für Einstellung_KI  ~  GenKI_Erfahrung +  Geschlecht 


Table: Prädiktoren

|Prädiktor       |
|:---------------|
|GenKI_Erfahrung |
|Geschlecht      |


Table: Häufigkeiten

|GenKI_Erfahrung |Geschlecht |  N|  Perc|    M|
|:---------------|:----------|--:|-----:|----:|
|sehr gering     |weiblich   | 27|  7.20| 3.12|
|sehr gering     |männlich   | 22|  5.87| 3.40|
|gering          |weiblich   | 44| 11.73| 3.34|
|gering          |männlich   | 51| 13.60| 3.71|
|mittel          |weiblich   | 74| 19.73| 3.65|
|mittel          |männlich   | 69| 18.40| 3.74|
|mittel          |divers     |  2|  0.53| 2.92|
|hoch            |weiblich   | 26|  6.93| 3.72|
|hoch            |männlich   | 43| 11.47| 3.95|
|sehr hoch       |weiblich   |  4|  1.07| 4.44|
|sehr hoch       |männlich   | 13|  3.47| 4.24|

### Test auf Normalverteilung der Residuen

	Shapiro-Wilk normality test

data:  model$residuals
W = 0.97343, p-value = 2.288e-06


### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test

	studentized Breusch-Pagan test

data:  model
BP = 8.5818, df = 6, p-value = 0.1985


### Lineares Modell mit robusten Standardfehlern:

Table: Robuste Standardfehler

|                         | Estimate| Std..Error| t.value| Pr...t..|
|:------------------------|--------:|----------:|-------:|--------:|
|(Intercept)              |    3.157|      0.108|  29.137|    0.000|
|GenKI_Erfahrunggering    |    0.278|      0.122|   2.276|    0.023|
|GenKI_Erfahrungmittel    |    0.441|      0.114|   3.855|    0.000|
|GenKI_Erfahrunghoch      |    0.583|      0.125|   4.660|    0.000|
|GenKI_Erfahrungsehr hoch |    0.975|      0.173|   5.648|    0.000|
|Geschlechtmännlich       |    0.200|      0.061|   3.275|    0.001|
|Geschlechtdivers         |   -0.681|      0.827|  -0.824|    0.411|

### Robuste ANOVA-Ergebnisse:

Table: Robuste ANOVA-Ergebnisse

|Var             |  Df|       F| Pr(>F)|  Eta2|
|:---------------|---:|-------:|------:|-----:|
|(Intercept)     |   1| 848.981|  0.000|    NA|
|GenKI_Erfahrung |   4|  11.025|  0.000| 0.132|
|Geschlecht      |   2|   5.799|  0.003| 0.033|
|Residuals       | 368|      NA|     NA|    NA|
