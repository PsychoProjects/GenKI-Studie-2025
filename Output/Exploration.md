
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
+         Prozent = n() / nrow(daten) * 100,
+         M = mean(!!sym(resp_var), na.rm = TRUE),
+         SD = sd(!!sym(resp_var), na.rm = TRUE),
+         KI_von = tryCatch(t.test(!!sym(resp_var))$conf.int[1], error = function(e) NA),
+         KI_bis = tryCatch(t.test(!!sym(resp_var))$conf.int[2], error = f .... [TRUNCATED] 

> # Akzeptanz-Analysen
> ## Analyse der Akzeptanz in Abhängigkeit von verschiedenen Variablen
> fn_Akzeptanz_Analyse(daten, "Akzeptanz", "GenKI_Erfahrung")
## Statistiken für Akzeptanz  ~  GenKI_Erfahrung 


Table: Prädiktoren

|Prädiktor       |
|:---------------|
|GenKI_Erfahrung |


Table: Häufigkeiten

|GenKI_Erfahrung |   N| Prozent|    M|   SD| KI_von| KI_bis|
|:---------------|---:|-------:|----:|----:|------:|------:|
|sehr gering     |  49|   13.07| 3.12| 1.07|   2.81|   3.42|
|gering          |  95|   25.33| 3.21| 1.03|   3.00|   3.42|
|mittel          | 145|   38.67| 3.24| 1.10|   3.06|   3.42|
|hoch            |  69|   18.40| 3.29| 1.01|   3.05|   3.54|
|sehr hoch       |  17|    4.53| 3.29| 1.40|   2.57|   4.01|

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

### Ergebnisse der robusten ANOVA:

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

|Geschlecht |   N| Prozent|    M|   SD| KI_von| KI_bis|
|:----------|---:|-------:|----:|----:|------:|------:|
|weiblich   | 175|   46.67| 3.25| 1.02|   3.09|   3.40|
|männlich   | 198|   52.80| 3.21| 1.13|   3.05|   3.36|
|divers     |   2|    0.53| 3.67| 0.94|  -4.80|  12.14|

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

### Ergebnisse der robusten ANOVA:

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

|Berufserfahrung    |   N| Prozent|    M|   SD| KI_von| KI_bis|
|:------------------|---:|-------:|----:|----:|------:|------:|
|keine              |   7|    1.87| 3.05| 0.93|   2.19|   3.91|
|weniger als 1 Jahr |   6|    1.60| 3.22| 0.75|   2.43|   4.01|
|1-5 Jahre          |  75|   20.00| 3.25| 1.04|   3.01|   3.49|
|5-10 Jahre         |  43|   11.47| 3.32| 1.06|   2.99|   3.64|
|mehr als 10 Jahre  | 244|   65.07| 3.21| 1.11|   3.07|   3.35|

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

### Ergebnisse der robusten ANOVA:

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

|Berufsstatus       |   N| Prozent|    M|   SD| KI_von| KI_bis|
|:------------------|---:|-------:|----:|----:|------:|------:|
|nicht erwerbstätig |  12|     3.2| 3.47| 0.64|   3.06|   3.88|
|erwerbstätig       | 291|    77.6| 3.28| 1.08|   3.16|   3.41|
|im Studium         |  63|    16.8| 3.01| 1.09|   2.74|   3.28|
|in der Ausbildung  |   9|     2.4| 2.56| 1.18|   1.65|   3.46|

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

### Ergebnisse der robusten ANOVA:

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

| Alter|  N| Prozent|    M|   SD| KI_von| KI_bis|
|-----:|--:|-------:|----:|----:|------:|------:|
|    18|  4|    1.07| 3.25| 0.50|   2.45|   4.05|
|    19|  7|    1.87| 2.33| 1.20|   1.22|   3.44|
|    20|  8|    2.13| 3.50| 0.82|   2.82|   4.18|
|    21| 12|    3.20| 3.25| 1.06|   2.58|   3.92|
|    22|  9|    2.40| 3.04| 1.10|   2.19|   3.88|
|    23|  7|    1.87| 3.57| 1.05|   2.60|   4.54|
|    24| 12|    3.20| 3.39| 0.93|   2.80|   3.98|
|    25| 14|    3.73| 3.45| 0.75|   3.02|   3.88|
|    26|  9|    2.40| 2.48| 1.18|   1.57|   3.39|
|    27| 16|    4.27| 3.27| 0.99|   2.74|   3.80|
|    28|  7|    1.87| 3.29| 1.13|   2.24|   4.33|
|    29|  6|    1.60| 3.61| 1.37|   2.17|   5.05|
|    30|  9|    2.40| 3.56| 0.65|   3.06|   4.05|
|    31|  7|    1.87| 2.71| 0.71|   2.06|   3.37|
|    32| 13|    3.47| 3.62| 1.21|   2.89|   4.35|
|    33|  5|    1.33| 3.60| 0.55|   2.92|   4.28|
|    34|  9|    2.40| 3.19| 0.82|   2.56|   3.81|
|    35|  7|    1.87| 2.38| 1.06|   1.40|   3.36|
|    36| 14|    3.73| 3.14| 1.27|   2.41|   3.87|
|    37|  5|    1.33| 3.27| 1.23|   1.73|   4.80|
|    38| 11|    2.93| 3.52| 1.33|   2.62|   4.41|
|    39|  9|    2.40| 2.78| 1.19|   1.86|   3.69|
|    40| 10|    2.67| 3.27| 1.24|   2.38|   4.15|
|    41|  6|    1.60| 3.94| 0.68|   3.23|   4.66|
|    42|  7|    1.87| 3.52| 0.90|   2.69|   4.36|
|    43|  6|    1.60| 3.50| 1.47|   1.96|   5.04|
|    44|  8|    2.13| 4.08| 0.53|   3.64|   4.52|
|    45| 11|    2.93| 3.52| 1.13|   2.76|   4.27|
|    46| 11|    2.93| 3.48| 1.20|   2.68|   4.29|
|    47|  6|    1.60| 3.28| 0.90|   2.33|   4.23|
|    48|  8|    2.13| 2.50| 1.46|   1.28|   3.72|
|    49|  5|    1.33| 3.53| 1.12|   2.14|   4.92|
|    50|  9|    2.40| 3.78| 0.41|   3.46|   4.09|
|    51|  8|    2.13| 3.12| 0.91|   2.37|   3.88|
|    52| 11|    2.93| 2.73| 1.27|   1.87|   3.58|
|    53|  7|    1.87| 2.71| 1.67|   1.17|   4.26|
|    54|  4|    1.07| 2.08| 0.57|   1.18|   2.99|
|    55|  3|    0.80| 2.89| 1.02|   0.36|   5.42|
|    56| 12|    3.20| 2.83| 0.82|   2.31|   3.36|
|    57|  7|    1.87| 2.57| 1.33|   1.34|   3.80|
|    58|  4|    1.07| 2.00| 0.72|   0.85|   3.15|
|    59|  6|    1.60| 3.78| 0.93|   2.80|   4.76|
|    60|  6|    1.60| 3.56| 0.40|   3.13|   3.98|
|    61|  3|    0.80| 4.00| 0.33|   3.17|   4.83|
|    62|  3|    0.80| 3.89| 0.19|   3.41|   4.37|
|    63|  3|    0.80| 3.22| 0.84|   1.14|   5.31|
|    64|  4|    1.07| 3.25| 1.50|   0.86|   5.64|
|    65|  2|    0.53| 2.67| 0.94|  -5.80|  11.14|
|    66|  2|    0.53| 4.00| 0.00|     NA|     NA|
|    67|  1|    0.27| 3.00|   NA|     NA|     NA|
|    68|  1|    0.27| 4.00|   NA|     NA|     NA|
|    78|  1|    0.27| 3.00|   NA|     NA|     NA|

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

### Ergebnisse der robusten ANOVA:

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

|GenKI_Erfahrung |Anwendungsfeld |  N| Prozent|    M|   SD| KI_von| KI_bis|
|:---------------|:--------------|--:|-------:|----:|----:|------:|------:|
|sehr gering     |Objektiv       | 28|    7.47| 3.69| 0.75|   3.40|   3.98|
|sehr gering     |Subjektiv      | 21|    5.60| 2.35| 0.96|   1.91|   2.79|
|gering          |Objektiv       | 48|   12.80| 3.67| 0.90|   3.41|   3.94|
|gering          |Subjektiv      | 47|   12.53| 2.73| 0.94|   2.46|   3.01|
|mittel          |Objektiv       | 76|   20.27| 3.94| 0.66|   3.79|   4.09|
|mittel          |Subjektiv      | 69|   18.40| 2.46| 0.97|   2.23|   2.70|
|hoch            |Objektiv       | 32|    8.53| 3.85| 0.60|   3.64|   4.07|
|hoch            |Subjektiv      | 37|    9.87| 2.81| 1.06|   2.46|   3.16|
|sehr hoch       |Objektiv       |  7|    1.87| 3.90| 1.30|   2.70|   5.11|
|sehr hoch       |Subjektiv      | 10|    2.67| 2.87| 1.36|   1.89|   3.84|

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

### Ergebnisse der robusten ANOVA:

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

|GenKI_Erfahrung |Geschlecht |  N| Prozent|    M|   SD| KI_von| KI_bis|
|:---------------|:----------|--:|-------:|----:|----:|------:|------:|
|sehr gering     |weiblich   | 27|    7.20| 3.23| 0.89|   2.88|   3.59|
|sehr gering     |männlich   | 22|    5.87| 2.97| 1.27|   2.41|   3.53|
|gering          |weiblich   | 44|   11.73| 3.20| 1.03|   2.88|   3.51|
|gering          |männlich   | 51|   13.60| 3.22| 1.04|   2.92|   3.51|
|mittel          |weiblich   | 74|   19.73| 3.18| 1.07|   2.94|   3.43|
|mittel          |männlich   | 69|   18.40| 3.28| 1.16|   3.00|   3.56|
|mittel          |divers     |  2|    0.53| 3.67| 0.94|  -4.80|  12.14|
|hoch            |weiblich   | 26|    6.93| 3.41| 0.97|   3.02|   3.80|
|hoch            |männlich   | 43|   11.47| 3.22| 1.04|   2.90|   3.55|
|sehr hoch       |weiblich   |  4|    1.07| 3.92| 1.20|   2.01|   5.82|
|sehr hoch       |männlich   | 13|    3.47| 3.10| 1.44|   2.23|   3.97|

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

### Ergebnisse der robusten ANOVA:

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

|GenKI_Erfahrung |   N| Prozent|    M|   SD| KI_von| KI_bis|
|:---------------|---:|-------:|----:|----:|------:|------:|
|sehr gering     |  49|   13.07| 3.25| 0.74|   3.03|   3.46|
|gering          |  95|   25.33| 3.54| 0.61|   3.42|   3.67|
|mittel          | 145|   38.67| 3.68| 0.53|   3.60|   3.77|
|hoch            |  69|   18.40| 3.86| 0.55|   3.73|   4.00|
|sehr hoch       |  17|    4.53| 4.28| 0.52|   4.02|   4.55|

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

### Ergebnisse der robusten ANOVA:

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

|Geschlecht |   N| Prozent|    M|   SD| KI_von| KI_bis|
|:----------|---:|-------:|----:|----:|------:|------:|
|weiblich   | 175|   46.67| 3.52| 0.63|   3.43|   3.62|
|männlich   | 198|   52.80| 3.77| 0.60|   3.69|   3.86|
|divers     |   2|    0.53| 2.92| 0.82|  -4.50|  10.33|

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

### Ergebnisse der robusten ANOVA:

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

|Berufserfahrung    |   N| Prozent|    M|   SD| KI_von| KI_bis|
|:------------------|---:|-------:|----:|----:|------:|------:|
|keine              |   7|    1.87| 3.74| 0.33|   3.43|   4.05|
|weniger als 1 Jahr |   6|    1.60| 3.40| 0.68|   2.69|   4.12|
|1-5 Jahre          |  75|   20.00| 3.65| 0.58|   3.52|   3.79|
|5-10 Jahre         |  43|   11.47| 3.72| 0.62|   3.53|   3.91|
|mehr als 10 Jahre  | 244|   65.07| 3.64| 0.65|   3.56|   3.72|

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

### Ergebnisse der robusten ANOVA:

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

|Berufsstatus       |   N| Prozent|    M|   SD| KI_von| KI_bis|
|:------------------|---:|-------:|----:|----:|------:|------:|
|nicht erwerbstätig |  12|     3.2| 3.41| 0.57|   3.05|   3.77|
|erwerbstätig       | 291|    77.6| 3.67| 0.62|   3.60|   3.75|
|im Studium         |  63|    16.8| 3.56| 0.67|   3.39|   3.73|
|in der Ausbildung  |   9|     2.4| 3.85| 0.30|   3.62|   4.08|

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

### Ergebnisse der robusten ANOVA:

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

| Alter|  N| Prozent|    M|   SD| KI_von| KI_bis|
|-----:|--:|-------:|----:|----:|------:|------:|
|    18|  4|    1.07| 3.40| 0.46|   2.67|   4.13|
|    19|  7|    1.87| 3.55| 0.28|   3.29|   3.80|
|    20|  8|    2.13| 3.96| 0.67|   3.40|   4.52|
|    21| 12|    3.20| 3.50| 0.69|   3.06|   3.94|
|    22|  9|    2.40| 3.65| 0.46|   3.30|   4.00|
|    23|  7|    1.87| 3.81| 0.45|   3.39|   4.23|
|    24| 12|    3.20| 3.81| 0.60|   3.43|   4.20|
|    25| 14|    3.73| 3.64| 0.72|   3.22|   4.05|
|    26|  9|    2.40| 3.58| 0.49|   3.20|   3.96|
|    27| 16|    4.27| 3.97| 0.54|   3.68|   4.26|
|    28|  7|    1.87| 3.65| 0.68|   3.03|   4.28|
|    29|  6|    1.60| 3.71| 0.93|   2.73|   4.69|
|    30|  9|    2.40| 3.59| 0.42|   3.27|   3.91|
|    31|  7|    1.87| 3.36| 0.48|   2.92|   3.80|
|    32| 13|    3.47| 3.61| 0.67|   3.21|   4.01|
|    33|  5|    1.33| 3.80| 0.50|   3.19|   4.41|
|    34|  9|    2.40| 3.61| 0.68|   3.09|   4.13|
|    35|  7|    1.87| 3.39| 0.80|   2.65|   4.14|
|    36| 14|    3.73| 3.93| 0.54|   3.62|   4.24|
|    37|  5|    1.33| 3.70| 0.39|   3.21|   4.19|
|    38| 11|    2.93| 3.80| 0.49|   3.47|   4.14|
|    39|  9|    2.40| 3.33| 0.56|   2.91|   3.76|
|    40| 10|    2.67| 3.48| 0.41|   3.18|   3.77|
|    41|  6|    1.60| 3.82| 0.52|   3.27|   4.37|
|    42|  7|    1.87| 3.57| 0.70|   2.92|   4.22|
|    43|  6|    1.60| 3.51| 0.87|   2.61|   4.42|
|    44|  8|    2.13| 3.88| 0.50|   3.46|   4.29|
|    45| 11|    2.93| 3.71| 0.79|   3.18|   4.24|
|    46| 11|    2.93| 3.68| 0.46|   3.37|   3.99|
|    47|  6|    1.60| 3.65| 0.49|   3.14|   4.16|
|    48|  8|    2.13| 3.61| 0.75|   2.99|   4.24|
|    49|  5|    1.33| 3.87| 0.50|   3.25|   4.48|
|    50|  9|    2.40| 3.37| 0.53|   2.96|   3.78|
|    51|  8|    2.13| 3.74| 0.67|   3.18|   4.30|
|    52| 11|    2.93| 3.42| 1.04|   2.73|   4.12|
|    53|  7|    1.87| 3.51| 1.14|   2.46|   4.56|
|    54|  4|    1.07| 3.67| 0.58|   2.74|   4.59|
|    55|  3|    0.80| 4.17| 0.66|   2.52|   5.81|
|    56| 12|    3.20| 3.77| 0.39|   3.53|   4.02|
|    57|  7|    1.87| 3.15| 0.88|   2.34|   3.97|
|    58|  4|    1.07| 2.98| 0.66|   1.93|   4.03|
|    59|  6|    1.60| 3.76| 0.54|   3.20|   4.33|
|    60|  6|    1.60| 3.33| 0.48|   2.83|   3.84|
|    61|  3|    0.80| 3.97| 0.41|   2.95|   4.99|
|    62|  3|    0.80| 4.36| 0.43|   3.30|   5.42|
|    63|  3|    0.80| 3.94| 0.17|   3.51|   4.38|
|    64|  4|    1.07| 3.81| 0.46|   3.08|   4.55|
|    65|  2|    0.53| 3.29| 0.41|  -0.41|   7.00|
|    66|  2|    0.53| 4.00| 0.00|     NA|     NA|
|    67|  1|    0.27| 4.33|   NA|     NA|     NA|
|    68|  1|    0.27| 2.67|   NA|     NA|     NA|
|    78|  1|    0.27| 2.58|   NA|     NA|     NA|

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

### Ergebnisse der robusten ANOVA:

Table: Robuste ANOVA-Ergebnisse

|Var         |  Df|        F| Pr(>F)|  Eta2|
|:-----------|---:|--------:|------:|-----:|
|(Intercept) |   1| 1409.425|  0.000|    NA|
|Alter       |   1|    0.777|  0.379| 0.002|
|Residuals   | 373|       NA|     NA|    NA|

> ## Kombiniertes Modell
> fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "GenKI_Erfahrung + Geschlecht")
## Statistiken für Einstellung_KI  ~  GenKI_Erfahrung + Geschlecht 


Table: Prädiktoren

|Prädiktor       |
|:---------------|
|GenKI_Erfahrung |
|Geschlecht      |


Table: Häufigkeiten

|GenKI_Erfahrung |Geschlecht |  N| Prozent|    M|   SD| KI_von| KI_bis|
|:---------------|:----------|--:|-------:|----:|----:|------:|------:|
|sehr gering     |weiblich   | 27|    7.20| 3.12| 0.72|   2.84|   3.41|
|sehr gering     |männlich   | 22|    5.87| 3.40| 0.76|   3.06|   3.73|
|gering          |weiblich   | 44|   11.73| 3.34| 0.62|   3.16|   3.53|
|gering          |männlich   | 51|   13.60| 3.71| 0.55|   3.56|   3.87|
|mittel          |weiblich   | 74|   19.73| 3.65| 0.50|   3.54|   3.77|
|mittel          |männlich   | 69|   18.40| 3.74| 0.54|   3.61|   3.87|
|mittel          |divers     |  2|    0.53| 2.92| 0.82|  -4.50|  10.33|
|hoch            |weiblich   | 26|    6.93| 3.72| 0.58|   3.49|   3.96|
|hoch            |männlich   | 43|   11.47| 3.95| 0.52|   3.79|   4.11|
|sehr hoch       |weiblich   |  4|    1.07| 4.44| 0.17|   4.16|   4.71|
|sehr hoch       |männlich   | 13|    3.47| 4.24| 0.59|   3.88|   4.59|

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

### Ergebnisse der robusten ANOVA:

Table: Robuste ANOVA-Ergebnisse

|Var             |  Df|       F| Pr(>F)|  Eta2|
|:---------------|---:|-------:|------:|-----:|
|(Intercept)     |   1| 848.981|  0.000|    NA|
|GenKI_Erfahrung |   4|  11.025|  0.000| 0.132|
|Geschlecht      |   2|   5.799|  0.003| 0.033|
|Residuals       | 368|      NA|     NA|    NA|
