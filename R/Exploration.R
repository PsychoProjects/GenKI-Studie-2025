source("R/InstallPackages.R")
source("R/Read_Data.R")

cat("\n*** Statistiken nach Geschlecht\n")
daten %>% group_by(Geschlecht) %>% count() %>% print()
daten %>% group_by(Geschlecht, Gruppe) %>% skim(Akzeptanz) %>% print()

cat("\n*** Statistiken nach Bildungsabschluss\n")
daten %>% group_by(Bildungsabschluss) %>% count() %>% print()
daten %>% group_by(Bildungsabschluss, Gruppe) %>% skim(Akzeptanz) %>% print()

