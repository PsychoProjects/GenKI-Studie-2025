
> source("InstallPackages.R")

> source("Read_Data.R")

> # ANOVA zur Überprüfung der Manipulationswirkung auf Akzeptanz
> #   sollte signifikant sein
> manipulation_check <- aov(Akzeptanz ~ Vertrauensmassnahmen, data = daten)

> print(summary(manipulation_check))
                      Df Sum Sq Mean Sq F value Pr(>F)  
Vertrauensmassnahmen   1    4.3   4.300   3.802  0.052 .
Residuals            363  410.6   1.131                 
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> # ANOVA für Akzeptanz_S1 bis Akzeptanz_S3: die F- und p-Werte sollten ähnlich sein, wenn sie das Gleiche messen
> anova_akzeptanzS1 <- aov(Akzeptanz_S1 ~ Anwendungsfeld * Vertrauensmassnahmen, data = rohdaten)

> anova_akzeptanzS2 <- aov(Akzeptanz_S2 ~ Anwendungsfeld * Vertrauensmassnahmen, data = rohdaten)

> anova_akzeptanzS3 <- aov(Akzeptanz_S3 ~ Anwendungsfeld * Vertrauensmassnahmen, data = rohdaten)

> print(summary(anova_akzeptanzS1))
                                     Df Sum Sq Mean Sq   F value Pr(>F)    
Anwendungsfeld                        1 581865  581865 8.367e+05 <2e-16 ***
Vertrauensmassnahmen                  1      0       0 3.330e-01  0.564    
Anwendungsfeld:Vertrauensmassnahmen   1      0       0 3.460e-01  0.557    
Residuals                           361    251       1                     
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> print(summary(anova_akzeptanzS2))
                                     Df Sum Sq Mean Sq   F value Pr(>F)    
Anwendungsfeld                        1 577905  577905 8.636e+05 <2e-16 ***
Vertrauensmassnahmen                  1      0       0 1.000e-03  0.975    
Anwendungsfeld:Vertrauensmassnahmen   1      0       0 1.000e-03  0.974    
Residuals                           361    242       1                     
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> print(summary(anova_akzeptanzS3))
                                     Df Sum Sq Mean Sq   F value Pr(>F)    
Anwendungsfeld                        1 575809  575809 8.505e+05 <2e-16 ***
Vertrauensmassnahmen                  1      0       0 2.500e-02  0.875    
Anwendungsfeld:Vertrauensmassnahmen   1      0       0 2.600e-02  0.873    
Residuals                           361    244       1                     
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> # ANOVA für Akzeptanz_O1 bis Akzeptanz_O3: die F- und p-Werte sollten ähnlich sein, wenn sie das Gleiche messen
> anova_akzeptanzO1 <- aov(Akzeptanz_O1 ~ Anwendungsfeld * Vertrauensmassnahmen, data = rohdaten)

> anova_akzeptanzO2 <- aov(Akzeptanz_O2 ~ Anwendungsfeld * Vertrauensmassnahmen, data = rohdaten)

> anova_akzeptanzO3 <- aov(Akzeptanz_O3 ~ Anwendungsfeld * Vertrauensmassnahmen, data = rohdaten)

> print(summary(anova_akzeptanzO1))
                                     Df Sum Sq Mean Sq   F value Pr(>F)    
Anwendungsfeld                        1 600578  600578 1.493e+06 <2e-16 ***
Vertrauensmassnahmen                  1      0       0 4.620e-01  0.497    
Anwendungsfeld:Vertrauensmassnahmen   1      0       0 4.450e-01  0.505    
Residuals                           361    145       0                     
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> print(summary(anova_akzeptanzO2))
                                     Df Sum Sq Mean Sq   F value Pr(>F)    
Anwendungsfeld                        1 595149  595149 1.199e+06 <2e-16 ***
Vertrauensmassnahmen                  1      1       1 1.797e+00  0.181    
Anwendungsfeld:Vertrauensmassnahmen   1      1       1 1.729e+00  0.189    
Residuals                           361    179       0                     
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> print(summary(anova_akzeptanzO3))
                                     Df Sum Sq Mean Sq   F value Pr(>F)    
Anwendungsfeld                        1 591728  591728 1.175e+06 <2e-16 ***
Vertrauensmassnahmen                  1      0       0 2.160e-01  0.643    
Anwendungsfeld:Vertrauensmassnahmen   1      0       0 2.070e-01  0.649    
Residuals                           361    182       1                     
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> # Cronbach's Alpha, um zu prüfen, ob die Items zur Messung der Akzeptanz konsistent sind. Werte über 0.7 gelten als akzeptabel.
> ca_s <- alpha(rohdaten[, c("Akzeptanz_S1", "Akzeptanz_S2", "Akzeptanz_S3")])

> print(ca_s)

Reliability analysis   
Call: alpha(x = rohdaten[, c("Akzeptanz_S1", "Akzeptanz_S2", "Akzeptanz_S3")])

  raw_alpha std.alpha G6(smc) average_r   S/N     ase mean sd median_r
         1         1       1         1 18028 5.1e-06  -38 40        1

    95% confidence boundaries 
         lower alpha upper
Feldt        1     1     1
Duhachek     1     1     1

 Reliability if an item is dropped:
             raw_alpha std.alpha G6(smc) average_r   S/N alpha se var.r med.r
Akzeptanz_S1         1         1       1         1 10201  1.0e-05    NA     1
Akzeptanz_S2         1         1       1         1 12080  9.0e-06    NA     1
Akzeptanz_S3         1         1       1         1 14535  7.4e-06    NA     1

 Item statistics 
               n raw.r std.r r.cor r.drop mean sd
Akzeptanz_S1 365     1     1     1      1  -38 40
Akzeptanz_S2 365     1     1     1      1  -38 40
Akzeptanz_S3 365     1     1     1      1  -38 40

> ca_o <- alpha(rohdaten[, c("Akzeptanz_O1", "Akzeptanz_O2", "Akzeptanz_O3")])

> print(ca_o)

Reliability analysis   
Call: alpha(x = rohdaten[, c("Akzeptanz_O1", "Akzeptanz_O2", "Akzeptanz_O3")])

  raw_alpha std.alpha G6(smc) average_r   S/N   ase mean sd median_r
         1         1       1         1 18715 5e-06  -36 40        1

    95% confidence boundaries 
         lower alpha upper
Feldt        1     1     1
Duhachek     1     1     1

 Reliability if an item is dropped:
             raw_alpha std.alpha G6(smc) average_r   S/N alpha se var.r med.r
Akzeptanz_O1         1         1       1         1 10188  1.0e-05    NA     1
Akzeptanz_O2         1         1       1         1 13498  8.4e-06    NA     1
Akzeptanz_O3         1         1       1         1 14658  7.4e-06    NA     1

 Item statistics 
               n raw.r std.r r.cor r.drop mean sd
Akzeptanz_O1 365     1     1     1      1  -36 41
Akzeptanz_O2 365     1     1     1      1  -36 40
Akzeptanz_O3 365     1     1     1      1  -36 40

> # Korrelation zwischen den Akzeptanz-Items sollte hoch sein
> correlation_matrix <- cor(select(rohdaten, Akzeptanz_O1, Akzeptanz_O2, Akzeptanz_O3), use = "complete.obs")

> print(correlation_matrix)
             Akzeptanz_O1 Akzeptanz_O2 Akzeptanz_O3
Akzeptanz_O1    1.0000000    0.9998636    0.9998519
Akzeptanz_O2    0.9998636    1.0000000    0.9998037
Akzeptanz_O3    0.9998519    0.9998037    1.0000000

> correlation_matrix <- cor(select(rohdaten, Akzeptanz_S1, Akzeptanz_S2, Akzeptanz_S3), use = "complete.obs")

> print(correlation_matrix)
             Akzeptanz_S1 Akzeptanz_S2 Akzeptanz_S3
Akzeptanz_S1    1.0000000    0.9998624    0.9998345
Akzeptanz_S2    0.9998624    1.0000000    0.9998040
Akzeptanz_S3    0.9998345    0.9998040    1.0000000

> cor_results <- list()

> cor_results$Akzeptanz_O1_O2 <- cor.test(rohdaten$Akzeptanz_O1, rohdaten$Akzeptanz_O2, use = "complete.obs")

> cor_results$Akzeptanz_O1_O3 <- cor.test(rohdaten$Akzeptanz_O1, rohdaten$Akzeptanz_O3, use = "complete.obs")

> cor_results$Akzeptanz_O2_O3 <- cor.test(rohdaten$Akzeptanz_O2, rohdaten$Akzeptanz_O3, use = "complete.obs")

> cor_results$Akzeptanz_S1_S2 <- cor.test(rohdaten$Akzeptanz_S1, rohdaten$Akzeptanz_S2, use = "complete.obs")

> cor_results$Akzeptanz_S1_S3 <- cor.test(rohdaten$Akzeptanz_S1, rohdaten$Akzeptanz_S3, use = "complete.obs")

> cor_results$Akzeptanz_S2_S3 <- cor.test(rohdaten$Akzeptanz_S2, rohdaten$Akzeptanz_S3, use = "complete.obs")

> print(cor_results)
$Akzeptanz_O1_O2

	Pearson's product-moment correlation

data:  rohdaten$Akzeptanz_O1 and rohdaten$Akzeptanz_O2
t = 1153.3, df = 363, p-value < 2.2e-16
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 0.9998324 0.9998890
sample estimates:
      cor 
0.9998636 


$Akzeptanz_O1_O3

	Pearson's product-moment correlation

data:  rohdaten$Akzeptanz_O1 and rohdaten$Akzeptanz_O3
t = 1106.7, df = 363, p-value < 2.2e-16
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 0.9998180 0.9998794
sample estimates:
      cor 
0.9998519 


$Akzeptanz_O2_O3

	Pearson's product-moment correlation

data:  rohdaten$Akzeptanz_O2 and rohdaten$Akzeptanz_O3
t = 961.51, df = 363, p-value < 2.2e-16
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 0.9997588 0.9998403
sample estimates:
      cor 
0.9998037 


$Akzeptanz_S1_S2

	Pearson's product-moment correlation

data:  rohdaten$Akzeptanz_S1 and rohdaten$Akzeptanz_S2
t = 1148.5, df = 363, p-value < 2.2e-16
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 0.9998309 0.9998880
sample estimates:
      cor 
0.9998624 


$Akzeptanz_S1_S3

	Pearson's product-moment correlation

data:  rohdaten$Akzeptanz_S1 and rohdaten$Akzeptanz_S3
t = 1047, df = 363, p-value < 2.2e-16
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 0.9997966 0.9998653
sample estimates:
      cor 
0.9998345 


$Akzeptanz_S2_S3

	Pearson's product-moment correlation

data:  rohdaten$Akzeptanz_S2 and rohdaten$Akzeptanz_S3
t = 962.1, df = 363, p-value < 2.2e-16
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 0.9997591 0.9998405
sample estimates:
     cor 
0.999804 



> # Überprüfung der Verteilung von Einstellung_KI zwischen den Vertrauensmassnahmen-Gruppen
> # sollte nicht signifikant sein
> print(summary(aov(Einstellung_KI ~ Vertrauensmassnahmen, data = daten)))
                      Df Sum Sq Mean Sq F value Pr(>F)
Vertrauensmassnahmen   1   1.08  1.0769   2.718    0.1
Residuals            363 143.84  0.3962               

> # Faktorenanalyse zur Überprüfung der Konstruktvalidität der Akzeptanz-Items
> #   mit einem Faktor (Annahme, dass alle Items auf einen Faktor laden)
> akzeptanz_items_s <- rohdaten[, c("Akzeptanz_S1", "Akzeptanz_S2", "Akzeptanz_S3")] 

> fa_result_s <- fa(akzeptanz_items_s, nfactors = 1, rotate = "none")

> print(fa_result_s)
Factor Analysis using method =  minres
Call: fa(r = akzeptanz_items_s, nfactors = 1, rotate = "none")
Standardized loadings (pattern matrix) based upon correlation matrix
             MR1 h2     u2 com
Akzeptanz_S1   1  1 0.0018   1
Akzeptanz_S2   1  1 0.0018   1
Akzeptanz_S3   1  1 0.0018   1

                MR1
SS loadings    2.99
Proportion Var 1.00

Mean item complexity =  1
Test of the hypothesis that 1 factor is sufficient.

df null model =  3  with the objective function =  16.35 with Chi Square =  5919.97
df of  the model are 0  and the objective function was  2.97 

The root mean square of the residuals (RMSR) is  0 
The df corrected root mean square of the residuals is  NA 

The harmonic n.obs is  365 with the empirical chi square  0.01  with prob <  NA 
The total n.obs was  365  with Likelihood Chi Square =  1072.36  with prob <  NA 

Tucker Lewis Index of factoring reliability =  -Inf
Fit based upon off diagonal values = 1
Measures of factor score adequacy             
                                                  MR1
Correlation of (regression) scores with factors     1
Multiple R square of scores with factors            1
Minimum correlation of possible factor scores       1

> akzeptanz_items_o <- rohdaten[, c("Akzeptanz_O1", "Akzeptanz_O2", "Akzeptanz_O3")]

> fa_result_o <- fa(akzeptanz_items_o, nfactors = 1, rotate = "none")

> print(fa_result_o)
Factor Analysis using method =  minres
Call: fa(r = akzeptanz_items_o, nfactors = 1, rotate = "none")
Standardized loadings (pattern matrix) based upon correlation matrix
             MR1 h2     u2 com
Akzeptanz_O1   1  1 0.0017   1
Akzeptanz_O2   1  1 0.0018   1
Akzeptanz_O3   1  1 0.0018   1

                MR1
SS loadings    2.99
Proportion Var 1.00

Mean item complexity =  1
Test of the hypothesis that 1 factor is sufficient.

df null model =  3  with the objective function =  16.43 with Chi Square =  5951.23
df of  the model are 0  and the objective function was  3.04 

The root mean square of the residuals (RMSR) is  0 
The df corrected root mean square of the residuals is  NA 

The harmonic n.obs is  365 with the empirical chi square  0.01  with prob <  NA 
The total n.obs was  365  with Likelihood Chi Square =  1099.56  with prob <  NA 

Tucker Lewis Index of factoring reliability =  -Inf
Fit based upon off diagonal values = 1
Measures of factor score adequacy             
                                                  MR1
Correlation of (regression) scores with factors     1
Multiple R square of scores with factors            1
Minimum correlation of possible factor scores       1

> # Alternativ: Faktorenanalyse mit mehreren Faktoren, um zu prüfen, ob mehr als ein Faktor vorhanden ist
> fa_multiple_s <- fa(akzeptanz_items_s, nfactors = 2, rotate = "varimax")

> print(fa_multiple_s)
Factor Analysis using method =  minres
Call: fa(r = akzeptanz_items_s, nfactors = 2, rotate = "varimax")
Standardized loadings (pattern matrix) based upon correlation matrix
             MR1 MR2 h2     u2 com
Akzeptanz_S1   1   0  1 0.0018   1
Akzeptanz_S2   1   0  1 0.0018   1
Akzeptanz_S3   1   0  1 0.0018   1

                       MR1 MR2
SS loadings           2.99   0
Proportion Var        1.00   0
Cumulative Var        1.00   1
Proportion Explained  1.00   0
Cumulative Proportion 1.00   1

Mean item complexity =  1
Test of the hypothesis that 2 factors are sufficient.

df null model =  3  with the objective function =  16.35 with Chi Square =  5919.97
df of  the model are -2  and the objective function was  2.97 

The root mean square of the residuals (RMSR) is  0 
The df corrected root mean square of the residuals is  NA 

The harmonic n.obs is  365 with the empirical chi square  0.01  with prob <  NA 
The total n.obs was  365  with Likelihood Chi Square =  1070.38  with prob <  NA 

Tucker Lewis Index of factoring reliability =  1.273
Fit based upon off diagonal values = 1
Measures of factor score adequacy             
                                                  MR1 MR2
Correlation of (regression) scores with factors     1   0
Multiple R square of scores with factors            1   0
Minimum correlation of possible factor scores       1  -1

> fa_multiple_o <- fa(akzeptanz_items_o, nfactors = 2, rotate = "varimax")

> print(fa_multiple_o)
Factor Analysis using method =  minres
Call: fa(r = akzeptanz_items_o, nfactors = 2, rotate = "varimax")
Standardized loadings (pattern matrix) based upon correlation matrix
             MR1 MR2 h2     u2 com
Akzeptanz_O1   1   0  1 0.0017   1
Akzeptanz_O2   1   0  1 0.0018   1
Akzeptanz_O3   1   0  1 0.0018   1

                       MR1 MR2
SS loadings           2.99   0
Proportion Var        1.00   0
Cumulative Var        1.00   1
Proportion Explained  1.00   0
Cumulative Proportion 1.00   1

Mean item complexity =  1
Test of the hypothesis that 2 factors are sufficient.

df null model =  3  with the objective function =  16.43 with Chi Square =  5951.23
df of  the model are -2  and the objective function was  3.04 

The root mean square of the residuals (RMSR) is  0 
The df corrected root mean square of the residuals is  NA 

The harmonic n.obs is  365 with the empirical chi square  0.01  with prob <  NA 
The total n.obs was  365  with Likelihood Chi Square =  1097.53  with prob <  NA 

Tucker Lewis Index of factoring reliability =  1.278
Fit based upon off diagonal values = 1
Measures of factor score adequacy             
                                                  MR1 MR2
Correlation of (regression) scores with factors     1   0
Multiple R square of scores with factors            1   0
Minimum correlation of possible factor scores       1  -1
