
> source("InstallPackages.R")

> source("Read_Data.R")
[1] "Daten werden geladen..."

> # ANOVA zur Überprüfung der Manipulationswirkung auf Akzeptanz
> #   sollte signifikant sein
> manipulation_check <- aov(Akzeptanz ~ Vertrauensmassnahmen, data = daten)

> print(summary(manipulation_check))
                      Df Sum Sq Mean Sq F value Pr(>F)  
Vertrauensmassnahmen   1    4.6   4.586    3.99 0.0465 *
Residuals            373  428.7   1.149                 
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> # ANOVA für Akzeptanz_S1 bis Akzeptanz_S3: die F- und p-Werte sollten ähnlich sein, wenn sie das Gleiche messen
> anova_akzeptanzS1 <- aov(Akzeptanz_S1 ~ Anwendungsfeld * Vertrauensmassnahmen, data = rohdaten)
RStudioGD 
        2 
RStudioGD 
        2 
RStudioGD 
        2 
[1] 353 140
[1] 353 140
[1] 353 140
[1] 353 140
[1] 353 140

> load_packages <- function(packages) {
+   for (package in packages) {
+     if (!(package %in% rownames(installed.packages()))) {
+       install.pa .... [TRUNCATED] 

> load_packages(
+   c(
+     "boot",
+     "car",
+     "dplyr",
+     "effectsize",
+     "ggplot2",
+     "ggpubr",
+     "gridExtra",
+     "Hmisc ..." ... [TRUNCATED] 
Paket ‘corrplot’ erfolgreich ausgepackt und MD5 Summen abgeglichen
Paket ‘ggsci’ erfolgreich ausgepackt und MD5 Summen abgeglichen
Paket ‘ggsignif’ erfolgreich ausgepackt und MD5 Summen abgeglichen
Paket ‘polynom’ erfolgreich ausgepackt und MD5 Summen abgeglichen
Paket ‘rstatix’ erfolgreich ausgepackt und MD5 Summen abgeglichen
Paket ‘ggpubr’ erfolgreich ausgepackt und MD5 Summen abgeglichen

Die heruntergeladenen Binärpakete sind in 
	C:\Users\localadmin.Alpha\AppData\Local\Temp\RtmpwDH9Zp\downloaded_packages
pdf 
  4 
pdf 
  4 
pdf 
  4 
pdf 
  4 
