source("InstallPackages.R")
source("Read_Data.R")

# ANOVA zur Überprüfung der Manipulationswirkung auf Akzeptanz
#   sollte signifikant sein
manipulation_check <- aov(Akzeptanz ~ Vertrauensmassnahmen, data = daten)
print(summary(manipulation_check))

# ANOVA für Akzeptanz_S1 bis Akzeptanz_S3: die F- und p-Werte sollten ähnlich sein, wenn sie das Gleiche messen
anova_akzeptanzS1 <- aov(Akzeptanz_S1 ~ Anwendungsfeld * Vertrauensmassnahmen, data = rohdaten)
anova_akzeptanzS2 <- aov(Akzeptanz_S2 ~ Anwendungsfeld * Vertrauensmassnahmen, data = rohdaten)
anova_akzeptanzS3 <- aov(Akzeptanz_S3 ~ Anwendungsfeld * Vertrauensmassnahmen, data = rohdaten)
print(summary(anova_akzeptanzS1))
print(summary(anova_akzeptanzS2))
print(summary(anova_akzeptanzS3))

# ANOVA für Akzeptanz_O1 bis Akzeptanz_O3: die F- und p-Werte sollten ähnlich sein, wenn sie das Gleiche messen
anova_akzeptanzO1 <- aov(Akzeptanz_O1 ~ Anwendungsfeld * Vertrauensmassnahmen, data = rohdaten)
anova_akzeptanzO2 <- aov(Akzeptanz_O2 ~ Anwendungsfeld * Vertrauensmassnahmen, data = rohdaten)
anova_akzeptanzO3 <- aov(Akzeptanz_O3 ~ Anwendungsfeld * Vertrauensmassnahmen, data = rohdaten)
print(summary(anova_akzeptanzO1))
print(summary(anova_akzeptanzO2))
print(summary(anova_akzeptanzO3))

# Cronbach's Alpha, um zu prüfen, ob die Items zur Messung der Akzeptanz konsistent sind. Werte über 0.7 gelten als akzeptabel.
ca_s <- alpha(rohdaten[, c("Akzeptanz_S1", "Akzeptanz_S2", "Akzeptanz_S3")])
print(ca_s)
ca_o <- alpha(rohdaten[, c("Akzeptanz_O1", "Akzeptanz_O2", "Akzeptanz_O3")])
print(ca_o)

# Korrelation zwischen den Akzeptanz-Items sollte hoch sein
correlation_matrix <- cor(select(rohdaten, Akzeptanz_O1, Akzeptanz_O2, Akzeptanz_O3), use = "complete.obs")
print(correlation_matrix)
correlation_matrix <- cor(select(rohdaten, Akzeptanz_S1, Akzeptanz_S2, Akzeptanz_S3), use = "complete.obs")
print(correlation_matrix)

cor_results <- list()
cor_results$Akzeptanz_O1_O2 <- cor.test(rohdaten$Akzeptanz_O1, rohdaten$Akzeptanz_O2, use = "complete.obs")
cor_results$Akzeptanz_O1_O3 <- cor.test(rohdaten$Akzeptanz_O1, rohdaten$Akzeptanz_O3, use = "complete.obs")
cor_results$Akzeptanz_O2_O3 <- cor.test(rohdaten$Akzeptanz_O2, rohdaten$Akzeptanz_O3, use = "complete.obs")
cor_results$Akzeptanz_S1_S2 <- cor.test(rohdaten$Akzeptanz_S1, rohdaten$Akzeptanz_S2, use = "complete.obs")
cor_results$Akzeptanz_S1_S3 <- cor.test(rohdaten$Akzeptanz_S1, rohdaten$Akzeptanz_S3, use = "complete.obs")
cor_results$Akzeptanz_S2_S3 <- cor.test(rohdaten$Akzeptanz_S2, rohdaten$Akzeptanz_S3, use = "complete.obs")
print(cor_results)

# Überprüfung der Verteilung von Einstellung_KI zwischen den Vertrauensmassnahmen-Gruppen
# sollte nicht signifikant sein
print(summary(aov(Einstellung_KI ~ Vertrauensmassnahmen, data = daten)))

# Faktorenanalyse zur Überprüfung der Konstruktvalidität der Akzeptanz-Items
#   mit einem Faktor (Annahme, dass alle Items auf einen Faktor laden)
akzeptanz_items_s <- rohdaten[, c("Akzeptanz_S1", "Akzeptanz_S2", "Akzeptanz_S3")] 
fa_result_s <- fa(akzeptanz_items_s, nfactors = 1, rotate = "none")
print(fa_result_s)
akzeptanz_items_o <- rohdaten[, c("Akzeptanz_O1", "Akzeptanz_O2", "Akzeptanz_O3")]
fa_result_o <- fa(akzeptanz_items_o, nfactors = 1, rotate = "none")
print(fa_result_o)

# Alternativ: Faktorenanalyse mit mehreren Faktoren, um zu prüfen, ob mehr als ein Faktor vorhanden ist
fa_multiple_s <- fa(akzeptanz_items_s, nfactors = 2, rotate = "varimax")
print(fa_multiple_s)
fa_multiple_o <- fa(akzeptanz_items_o, nfactors = 2, rotate = "varimax")
print(fa_multiple_o)

