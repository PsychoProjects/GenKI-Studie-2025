source("InstallPackages.R")
source("Read_Data.R")

# Analysefunktion
fn_Akzeptanz_Analyse <- function(daten, resp_var, input_var) {
  cat("## Statistiken für", resp_var, " ~ ", input_var, "\n")
  
  ## Prädiktoren aufteilen (unterstützt sowohl "+" als auch "*")
  input_vars <- unlist(strsplit(input_var, " \\+|\\* "))  # Trennung durch "+" oder "*"
  input_vars <- unique(trimws(input_vars))  # Entfernt doppelte & überflüssige Leerzeichen
  
  print(kable(input_vars, caption = "Prädiktoren", col.names = c("Prädiktor")))
  
  ## Gruppierte Statistik berechnen
  if (all(input_vars %in% colnames(daten))) {
    stats <- daten %>% 
      group_by(across(all_of(input_vars), .names = "{col}")) %>% 
      summarise(
        N = n(),
        Perc = n() / nrow(daten) * 100,
        M = mean(!!sym(resp_var), na.rm = TRUE),
        .groups = "drop"
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
    cat("\n### Lineares Modell mit robusten Standardfehlern:")
    robust_se <- coeftest(model, vcov = vcovHC(model, type = "HC3"))
    ### In ein Dataframe umwandeln (manuelle Extraktion)
    robust_se_df <- data.frame(
      Estimate = robust_se[, 1],
      `Std. Error` = robust_se[, 2],
      `t value` = robust_se[, 3],
      `Pr(>|t|)` = robust_se[, 4]
    )
    print(kable(robust_se_df, digits = 3, caption = "Robuste Standardfehler"))
    
    cat("\n### Robuste ANOVA-Ergebnisse:")
    robust_anova <- Anova(model, type = "III", white.adjust = TRUE)
 
    ### ANOVA-Ergebnisse in Dataframe umwandeln
    robust_anova_df <- as.data.frame(robust_anova)
    robust_anova_df$Var <- rownames(robust_anova_df) 
    rownames(robust_anova_df) <- NULL  # Zeilenamen entfernen
    robust_anova_df <- robust_anova_df[, c("Var", colnames(robust_anova_df)[-ncol(robust_anova_df)])]
    
    # Effektstärke ergänzen
    effect_sizes <- eta_squared(model, partial = FALSE)  
    robust_anova_df$Eta2 <- effect_sizes$Eta2[match(robust_anova_df$Var, effect_sizes$Parameter)]
    
    print(kable(robust_anova_df, digits = 3, caption = "Robuste ANOVA-Ergebnisse"))
    
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
#fn_Akzeptanz_Analyse(daten, "Akzeptanz", "Bildungsabschluss")
fn_Akzeptanz_Analyse(daten, "Akzeptanz", "Berufserfahrung")
fn_Akzeptanz_Analyse(daten, "Akzeptanz", "Berufsstatus")
fn_Akzeptanz_Analyse(daten, "Akzeptanz", "Alter")

## Kombiniertes Modell
fn_Akzeptanz_Analyse(daten, "Akzeptanz", "GenKI_Erfahrung + Anwendungsfeld")
fn_Akzeptanz_Analyse(daten, "Akzeptanz", "GenKI_Erfahrung + Geschlecht")

# Einstellungs-Analysen
## Analyse der Einstellung gegenüber KI in Abhängigkeit von verschiedenen Variablen
fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "GenKI_Erfahrung")
fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "Geschlecht")
#fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "Bildungsabschluss")
fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "Berufserfahrung")
fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "Berufsstatus")
fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "Alter")

## Kombiniertes Modell
fn_Akzeptanz_Analyse(daten, "Einstellung_KI", "GenKI_Erfahrung +  Geschlecht")


