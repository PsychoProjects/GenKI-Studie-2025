
> source("InstallPackages.R")

> source("Read_Data.R")
[1] "Daten werden geladen..."

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
