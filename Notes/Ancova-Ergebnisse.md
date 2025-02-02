## Ergebnisse

### Prüfung der Voraussetzungen für die ANCOVA
Vor der Durchführung der **Analysis of Covariance (ANCOVA)** wurden die **zentrale Modellannahmen** überprüft:

#### 1. Normalverteilung der Residuen
Die Annahme der Normalverteilung der Residuen wurde mithilfe des **Shapiro-Wilk-Tests** überprüft. Die Ergebnisse zeigten, dass die Residuen **nicht signifikant von einer Normalverteilung abweichen** (W = 0.993, p = .082).
Zusätzlich wurde ein **QQ-Plot der Residuen** erstellt, der visuell die Annahme der Normalverteilung bestätigte.

#### 2. Homogenität der Varianzen (Levene-Test)
Die Homogenität der Varianzen wurde mit dem **Levene-Test** überprüft.
- Für die unabhängige Variable *Vertrauensmaßnahmen* konnte die **Varianzhomogenität nicht abgelehnt werden** (p = .939).
- Für *Anwendungsfeld* wurde jedoch eine **signifikante Verletzung der Varianzhomogenität festgestellt** (p < .001).

Da die ANCOVA eine **Varianzhomogenität** der Residuen voraussetzt, wurde zur Korrektur eine **robuste ANCOVA mit heteroskedastizitätsrobusten Standardfehlern (HC3)** sowie eine **Bootstrapped ANCOVA (1000 Wiederholungen)** durchgeführt.

#### 3. Lineare Beziehung zwischen Kovariate und abhängiger Variable
Die Kovariate *Einstellung_KI* zeigte in der Gesamtstichprobe zunächst **keine signifikante einfache Korrelation mit der abhängigen Variable Akzeptanz** (r = -.007, p = 1.00).
Jedoch ergab eine **separate Analyse der Gruppen** eine **signifikante Korrelation innerhalb der Anwendungsfelder**:
- **Objektiv-Gruppe:** r = 0.56, p < .001
- **Subjektiv-Gruppe:** r = 0.34, p < .001

Dies deutet darauf hin, dass sich die Effekte in der Gesamtstichprobe ausgleichen, aber in den Subgruppen dennoch bestehen. **Im ANCOVA-Modell erwies sich die Kovariate als hochsignifikant**, sodass sie als erklärende Variable beibehalten wurde.

---

### Ergebnisse der ANCOVA

Eine **robuste ANCOVA** mit heteroskedastizitätsrobusten Standardfehlern (HC3) wurde berechnet, um den Einfluss von **Anwendungsfeld, Vertrauensmaßnahmen und der Kovariate Einstellung_KI auf Akzeptanz** zu untersuchen.

Das Modell erklärte **44.4 % der Varianz** (R^2 = 0.444), was auf eine **mittlere bis starke Effektstärke** hinweist.

#### Haupteffekte
- **Anwendungsfeld** hatte einen **signifikanten Effekt auf Akzeptanz** (b = -1.23, 95%-KI [-1.48, -0.99], p < .001), wobei die **Subjektiv-Gruppe eine geringere Akzeptanz aufwies als die Objektiv-Gruppe**.
- Die **Kovariate Einstellung_KI zeigte ebenfalls einen signifikanten Effekt** (b = 0.61, 95%-KI [0.48, 0.75], p < .001), was bedeutet, dass eine **positivere Einstellung gegenüber KI mit einer höheren Akzeptanz assoziiert ist**.

#### Interaktionseffekte und Vertrauensmaßnahmen
- Der Effekt der *Vertrauensmaßnahmen* war nicht signifikant (b = -0.00, 95%-KI [-0.18, 0.18], p = .977).
- Die **Interaktion zwischen Anwendungsfeld und Vertrauensmaßnahmen** zeigte ebenfalls **keinen signifikanten Effekt** (b = 0.03, 95%-KI [-0.30, 0.34], p = .870).

#### Bootstrapped ANCOVA zur Bestätigung der Ergebnisse
Um die Robustheit der Ergebnisse sicherzustellen, wurde eine **Bootstrapped ANCOVA mit 1000 Wiederholungen** durchgeführt.
Die Konfidenzintervalle bestätigten die ursprünglichen Effekte, was darauf hindeutet, dass die Ergebnisse **nicht durch Varianzheterogenität verzerrt wurden**.

---

### Zusammenfassung und Interpretation
✅ **Die Haupteffekte für Anwendungsfeld und Einstellung_KI waren signifikant** und wurden durch Bootstrapping bestätigt.
❌ **Vertrauensmaßnahmen hatten keinen signifikanten Effekt auf Akzeptanz.**
❌ **Keine Interaktionseffekte** zwischen den unabhängigen Variablen.
✅ **Die Verwendung der Kovariate Einstellung_KI war gerechtfertigt**, da sie einen signifikanten Einfluss auf die Akzeptanz zeigte.

➡ **Die Ergebnisse unterstützen die Annahme, dass eine positivere Einstellung gegenüber KI die Akzeptanz erhöht, während Vertrauensmaßnahmen allein keinen signifikanten Einfluss hatten.**

