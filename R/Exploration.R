source("InstallPackages.R")
source("Read_Data.R")

# Analysefunktion
fn_Akzeptanz_Analyse <- function(daten, var) {
  cat("# Statistiken für", deparse(substitute(var)), "\n")
  
  if (!is.null(daten[[var]])) {
    stats <- daten %>% group_by(!!sym(var)) %>%
      summarise(
        N = n(),
        Perc = n() / nrow(daten) * 100,
        M = mean(Akzeptanz, na.rm = TRUE)
      )
    print(kable(stats, caption = "Häufigkeiten", digits = 2), "\n")
  }
  
  ## Analyseformel zusammensetzen
  formula <- as.formula(paste("Akzeptanz", var, sep = " ~ "))  

  ## Lineares Modell erstellen
  model <- lm(formula, data = daten)  # Regressionmodell
  
  cat("\n## Überprüfung der Varianzhomogenität mit Breusch-Pagan-Test\n")
  bp_test <- bptest(model)
  print(bp_test)

  ## Falls Heteroskedastizität vorliegt, robuste Standardfehler und robuste ANOVA verwenden
  if (bp_test$p.value < 0.05) {
    cat("\n## Robuste Standardfehler:")
    robust_se <- coeftest(model, vcov = vcovHC(model, type = "HC3"))
    print(kable(as.data.frame(robust_se), digits = 3, caption = "Robuste Standardfehler"))
    
    cat("## Robuste ANOVA-Ergebnisse:")
    robust_anova <- Anova(model, type = "III", white.adjust = TRUE)
    print(kable(as.data.frame(robust_anova), digits = 2, caption = "Robuste ANOVA"))
  } else {
    cat("\n## Varianzhomogenität liegt vor. Klassische ANOVA wird verwendet.")
    aov_model <- anova(model)
    
    cat("\n### Modell-Koeffizienten\n")
    coef_df <- as.data.frame(coef(model))
    print(kable(coef_df, digits = 3, caption = "Modell-Koeffizienten"))
    
    cat("\n### Zusammenfassung des Modells")
    mp <- model_parameters(aov_model, eta_squared = "partial")
    print(kable(as.data.frame(mp), digits = 2, caption = "Zusammenfassung des ANOVA-Modells"))
    
    cat("\n### Effektgrößen") 
    eff_es <- eta_squared(aov_model, partial = TRUE)
    print(kable(as.data.frame(eff_es), digits = 2, caption = "Effektgrößen der ANOVA"))
  }
}

# Analyse der Akzeptanz in Abhängigkeit von verschiedenen Variablen
fn_Akzeptanz_Analyse(daten, "GenKI_Erfahrung")
fn_Akzeptanz_Analyse(daten, "Geschlecht")
fn_Akzeptanz_Analyse(daten, "Bildungsabschluss")
fn_Akzeptanz_Analyse(daten, "Berufserfahrung")
fn_Akzeptanz_Analyse(daten, "Berufsstatus")
fn_Akzeptanz_Analyse(daten, "Alter")

# Kombiniertes Modell
fn_Akzeptanz_Analyse(daten, "GenKI_Erfahrung + Geschlecht + Bildungsabschluss + Berufserfahrung + Berufsstatus + Alter")
