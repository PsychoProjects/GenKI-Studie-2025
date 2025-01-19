source("InstallPackages.R")
source("Read_Data.R")

cat("\n*** Statistiken nach Geschlecht\n")
daten %>% group_by(Geschlecht) %>% count()
daten %>% group_by(Geschlecht, Gruppe) %>% skim(Akzeptanz)

cat("\n*** Statistiken nach Bildungsabschluss\n")
daten %>% group_by(Bildungsabschluss) %>% count()
daten %>% group_by(Bildungsabschluss, Gruppe) %>% skim(Akzeptanz)

