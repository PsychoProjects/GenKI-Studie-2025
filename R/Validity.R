source("InstallPackages.R")
source("Read_Data.R")


# Analysen zur Einschätzung der Objektivität bzw. Subjektivität der Anwendungsfelder
table_val <- table(daten$Anwendungsfeld, daten$objektiv_subjektiv)

## Umwandlung in DataFrame mit Prozentwerten innerhalb jedes Anwendungsfelds
table_df <- as.data.frame(table_val) %>%
  group_by(Var1) %>%  # Gruppierung nach Anwendungsfeld
  mutate(Prozent = round(Freq / sum(Freq) * 100, 2)) %>%
  arrange(Var1)  # Sortierung nach Anwendungsfeld

## Tabelle ausgeben mit Anwendungsfeld, Einschätzung, Häufigkeit und Prozentanteil
kable(table_df, 
      col.names = c("Anwendungsfeld", "Einschätzung", "Häufigkeit", "Prozent"),
      caption = "Kreuztabelle der Übereinstimmung von Anwendungsfeld und objektiv-subjektiv-Einschätzung")

## Chi-Quadrat-Test zur Überprüfung der Verteilung
chitest <- chisq.test(table_val) 
print(chitest)

### Effektstärke Cramer's V berechnen
cramers_v(chitest)

## Korrelationsanalyse zwischen Anwendungsfeld und objektiv-subjektiv-Einschätzung
cor.test(as.numeric(daten$Anwendungsfeld), as.numeric(daten$objektiv_subjektiv), method = "kendall")

# Cronbach's Alpha, um zu prüfen, ob die Items zur Messung der Akzeptanz konsistent sind. Werte über 0.7 gelten als akzeptabel.
## Objektive Anwendungsfelder
obj_daten <- daten %>% filter(Anwendungsfeld == "Objektiv") %>% select(starts_with("Akzeptanz_O"))
ca <- alpha(obj_daten)
### Konfidenzintervall ergänzen
ca_stats <- ca$total %>% mutate(
  CI_lower = raw_alpha - 1.96 * ase,
  CI_upper = raw_alpha + 1.96 * ase,
  df = nrow(obj_daten) - 1
)
kable(ca_stats, digits = 2, caption = "Gesamtergebnis der Reliabilitätsanalyse für objektive Anwendungsfelder")
kable(ca$item.stats, digits = 2, caption = "Item-Statistiken der Reliabilitätsanalyse für objektive Anwendungsfelder")

## Subjektive Anwendungsfelder
subj_daten <- daten %>% filter(Anwendungsfeld == "Subjektiv") %>% select(starts_with("Akzeptanz_S"))
ca <- alpha(subj_daten)
### Konfidenzintervall ergänzen
ca_stats <- ca$total %>% mutate(
  CI_lower = raw_alpha - 1.96 * ase,
  CI_upper = raw_alpha + 1.96 * ase,
  df = nrow(subj_daten) - 1
)
kable(ca_stats, digits = 2, caption = "Gesamtergebnis der Reliabilitätsanalyse für subjektive Anwendungsfelder")
kable(ca$item.stats, digits = 2, caption = "Item-Statistiken der Reliabilitätsanalyse für subjektive Anwendungsfelder")

# Korrelation zwischen den Akzeptanz-Items sollte hoch sein
correlation_matrix <- cor(obj_daten, use = "complete.obs")
kable(correlation_matrix, digits = 2, caption = "Korrelationsmatrix der Akzeptanz-Items (Objektive Anwendungsfelder)")
correlation_matrix <- cor(subj_daten, use = "complete.obs")
kable(correlation_matrix, digits = 2, caption = "Korrelationsmatrix der Akzeptanz-Items (Subjektive Anwendungsfelder)")
