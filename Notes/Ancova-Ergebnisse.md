## 5. Ergebnisse

### 5.1 Prüfung der Voraussetzungen

Die Prüfung der Normalverteilung der Residuen mittels des Shapiro-Wilk-Tests ergab keine signifikante Abweichung von der Normalverteilung, *W* = 0,993, *p* = 0,082, sodass die Annahme der Normalverteilung der Residuen als gegeben betrachtet werden kann.

Die Homoskedastizität wurde mit Levene-Tests untersucht. Die Varianzhomogenität über die Interaktion der Faktoren Anwendungsfeld und Vertrauensmaßnahmen war verletzt, *F*(3, 371) = 7,78, *p* < 0,001. Ebenso zeigte sich eine signifikante Varianzheterogenität zwischen den Gruppen des Faktors Anwendungsfeld, *F*(1, 373) = 21,81, *p* < 0,001. Für den Faktor Vertrauensmaßnahmen wurde hingegen keine signifikante Verletzung festgestellt, *F*(1, 373) = 0,006, *p* = 0,939.

Da eine signifikante Varianzheterogenität vorliegt, wurden robuste Verfahren zur Absicherung der Ergebnisse herangezogen und die Ergebnisse der ANCOVA durch Bootstrap-Verfahren.

### 5.2 Standard-ANCOVA

Eine Kovarianzanalyse (ANCOVA) wurde durchgeführt, um den Einfluss der Faktoren Anwendungsfeld und Vertrauensmaßnahmen sowie der Kovariate Einstellung gegenüber KI auf die Akzeptanz zu untersuchen. Die Ergebnisse sind in Tabelle 1 zusammengefasst.

**Tabelle 1**
Ergebnisse der Standard-ANCOVA

| Prädiktor                                         | *F*(1, 370) | *p*    | *η²p* |
| ------------------------------------------------- | ----------- | ------ | ----- |
| Anwendungsfeld                                    | 210,58      | <0,001 | 0,36  |
| Einstellung gegenüber KI                          | 84,18       | <0,001 | 0,19  |
| Vertrauensmaßnahmen                               | 0,47        | 0,496  | 0,001 |
| Interaktion: Anwendungsfeld × Vertrauensmaßnahmen | 0,03        | 0,869  | 0,000 |

### 5.3 Bootstrapping

Zur weiteren Absicherung der Schätzergebnisse wurde ein Bootstrapping mit 1.000 Wiederholungen durchgeführt. Die Bootstrapped-Konfidenzintervalle für die einzelnen Prädiktoren zeigen, dass das Anwendungsfeld einen stabilen Effekt auf die Akzeptanz hat, 95%-KI [-1,44, -1,00]. Ebenso zeigt sich für die Einstellung gegenüber KI ein verlässlicher positiver Effekt, 95%-KI [0,48, 0,74]. Dagegen umfassen die Konfidenzintervalle für Vertrauensmaßnahmen, 95%-KI [-0,18, 0,18], sowie für die Interaktion von Anwendungsfeld und Vertrauensmaßnahmen, 95%-KI [-0,37, 0,32], den Nullpunkt, was auf Unsicherheit hinsichtlich ihrer Effekte hinweist.

Zusätzlich werden die Bootstrapped-Konfidenzintervalle in Tabelle 2 dargestellt.

**Tabelle 2**
Bootstrapped 95%-Konfidenzintervalle für die Koeffizienten

| Prädiktor                                         | Untergrenze | Obergrenze |
| ------------------------------------------------- | ----------- | ---------- |
| Anwendungsfeld (Subjektiv)                        | -1,44       | -1,00      |
| Einstellung gegenüber KI                          | 0,48        | 0,74       |
| Vertrauensmaßnahmen (Mit Maßnahme)                | -0,18       | 0,18       |
| Interaktion: Anwendungsfeld × Vertrauensmaßnahmen | -0,37       | 0,32       |

### 5.4 Robuste ANCOVA

Aufgrund der festgestellten Varianzheterogenität wurde eine robuste ANCOVA mit heteroskedastizitätsrobusten Standardfehlern (HC3) durchgeführt. Die Ergebnisse der robusten ANCOVA zeigten, dass der Haupteffekt des Anwendungsfelds weiterhin hochsignifikant blieb, *t*(370) = -10,19, *p* < 0,001, *η²p* = 0,36. Ebenso war der Effekt der Einstellung gegenüber KI signifikant, *t*(370) = 9,17, *p* < 0,001, *η²p* = 0,19. Vertrauensmaßnahmen zeigten erneut keinen signifikanten Effekt, *t*(370) = 0,02, *p* = 0,982, *η²p* = 0,001. Auch die Interaktion zwischen Anwendungsfeld und Vertrauensmaßnahmen blieb nicht signifikant, *t*(370) = -0,17, *p* = 0,869, *η²p* = 0,000.

Diese Ergebnisse bestätigen die Robustheit der Standard-ANCOVA-Ergebnisse, da die Effektgrößen und Signifikanzniveaus weitgehend übereinstimmen. Damit können die Ergebnisse der Standard-ANCOVA als valide betrachtet werden. Die detaillierten Ergebnisse sind in Tabelle 3 zusammengefasst.

**Tabelle 3**
Ergebnisse der robusten ANCOVA

| Prädiktor                                         | *t*(370) | *p*    | *η²p* |
| ------------------------------------------------- | -------- | ------ | ----- |
| Anwendungsfeld                                    | -10,19   | <0,001 | 0,36  |
| Einstellung gegenüber KI                          | 9,17     | <0,001 | 0,19  |
| Vertrauensmaßnahmen                               | 0,02     | 0,982  | 0,001 |
| Interaktion: Anwendungsfeld × Vertrauensmaßnahmen | -0,17    | 0,869  | 0,000 |

### 5.5 Effektstärken

Die Effektstärken wurden mittels partieller Eta-Quadrat-Werte (*η²p*) bestimmt. Der Haupteffekt des Anwendungsfelds zeigte eine große Effektstärke (*η²p* = 0,36), was darauf hinweist, dass dieser Faktor einen substanziellen Anteil der Varianz in der Akzeptanz erklärt. Der Effekt der Einstellung gegenüber KI war mit einer mittleren Effektstärke (*η²p* = 0,19) ebenfalls relevant. Der Effekt der Vertrauensmaßnahmen war vernachlässigbar (*η²p* = 0,001), ebenso wie die Interaktion der Faktoren (*η²p* = 0,000), was darauf hindeutet, dass Vertrauensmaßnahmen keinen relevanten Einfluss auf die Akzeptanz hatten.

### 5.6 Korrelationen

Zusätzlich wurde die Korrelation zwischen der Einstellung gegenüber KI und der Akzeptanz mittels Kendalls *τ* berechnet. Die Ergebnisse zeigten eine signifikante positive Korrelation für die gesamte Stichprobe, *τ* = 0,25, *z* = 6,85, *p* < 0,001. Für die Teilgruppe mit objektivem Anwendungsfeld war die Korrelation stärker, *τ* = 0,42, *z* = 7,98, *p* < 0,001, während für die subjektive Anwendungsbedingung eine schwächere, aber signifikante Korrelation vorlag, *τ* = 0,23, *z* = 4,26, *p* < 0,001.

Die aktualisierten Analysen bestätigen somit, dass das Anwendungsfeld einen starken Einfluss auf die Akzeptanz hat, während Vertrauensmaßnahmen keinen signifikanten Beitrag zur Vorhersage leisten. Die robuste ANCOVA und die Bootstrapping-Analysen liefern konsistente Belege für die Stabilität der Haupteffekte.

