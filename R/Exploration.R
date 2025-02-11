source("InstallPackages.R")
source("Read_Data.R")

# Analysefunktion
fn_Akzeptanz_Analyse <- function(daten, resp_var, input_var) {
  cat("## Statistiken für", resp_var, " ~ ", input_var, "\n")
  
  if (!is.null(daten[[input_var]])) {
    stats <- daten %>% group_by(!!sym(input_var)) %>%
      summarise(
        N = n(),
        Perc = n() / nrow(daten) * 100,
        M = mean(!!sym(resp_var), na.rm = TRUE)
      )
    print(kable(stats, caption = "Häufigkeiten", digits = 2), "\n")
  }
  
  ## Analyseformel zusammensetzen
  formula <- as.formula(paste(resp_var, input_var, sep = " ~ "))  

  ## Lineares Modell erstellen
  model <- lm(formula, data = daten)  # Regressionmodell
  
  cat("\n### Test auf Normalverteilung der Residuen\n")
  sw_test <- shapiro.test(model$residuals) 
  print(sw_test)

  cat("\n### Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test\n")
  bp_test <- bptest(model)
  print(bp_test)

  ## Falls Heteroskedastizität vorliegt, robuste Standardfehler und robuste ANOVA verwenden
  if ((bp_test$p.value < 0.05) || (sw_test$p.value < 0.05)) {
    cat("\n### Robuste Standardfehler:")
    robust_se <- coeftest(model, vcov = vcovHC(model, type = "HC3"))
    print(robust_se)

    cat("### Robuste ANOVA-Ergebnisse:")
    robust_anova <- Anova(model, type = "III", white.adjust = TRUE)
    print(robust_anova)
    
  } else {
    cat("\n### Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.")
    aov_model <- anova(model)
    
    cat("\n### Modell-Koeffizienten\n")
    coef_df <- as.data.frame(coef(model))
    print(kable(coef_df, digits = 2, caption = "Modell-Koeffizienten"))
    
    cat("\n### Zusammenfassung des Modells")
    mp <- model_parameters(aov_model, eta_squared = "partial")
    print(kable(as.data.frame(mp), digits = 3, caption = "Zusammenfassung des ANOVA-Modells"))
    
    cat("\n### Effektgrößen") 
    eff_es <- eta_squared(aov_model, partial = TRUE)
    print(kable(as.data.frame(eff_es), digits = 3, caption = "Effektgrößen der ANOVA"))
  }
}

# Akzeptanz-Analysen
## Analyse der Akzeptanz in Abhängigkeit von verschiedenen Variablen
fn_Akzeptanz_Analyse(daten, "Akzeptanz", "GenKI_Erfahrung")
fn_Akzeptanz_Analyse(daten, "Akzeptanz", "Geschlecht")
fn_Akzeptanz_Analyse(daten, "Akzeptanz", "Bildungsabschluss")
fn_Akzeptanz_Analyse(daten, "Akzeptanz", "Berufserfahrung")
fn_Akzeptanz_Analyse(daten, "Akzeptanz", "Berufsstatus")
fn_Akzeptanz_Analyse(daten, "Akzeptanz", "Alter")

## Kombiniertes Modell
fn_Akzeptanz_Analyse(daten, "Akzeptanz", "GenKI_Erfahrung * Anwendungsfeld")
fn_Akzeptanz_Analyse(daten, "Akzeptanz", "GenKI_Erfahrung * Geschlecht")

# Einstellungs-Analysen
## Analyse der Einstellung gegenüber KI in Abhängigkeit von verschiedenen Variablen
fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "GenKI_Erfahrung")
fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "Geschlecht")
fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "Bildungsabschluss")
fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "Berufserfahrung")
fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "Berufsstatus")
fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "Alter")

## Kombiniertes Modell
fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "GenKI_Erfahrung * Geschlecht")

### Verteilung der Einstellung nach Geschlecht und GenKI-Erfahrung 
stats <- daten %>% filter(Geschlecht != "divers") %>% group_by(Geschlecht, GenKI_Erfahrung) %>%
    summarise(
      N = n(),
      Perc = n() / nrow(daten) * 100,
      M = mean(Einstellung_KI, na.rm = TRUE)
    )
print(kable(stats, caption = "Häufigkeiten", digits = 2), "\n")

