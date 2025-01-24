
> source("InstallPackages.R")

> source("Read_Data.R")

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

> anova_akzeptanzS2 <- aov(Akzeptanz_S2 ~ Anwendungsfeld * Vertrauensmassnahmen, data = rohdaten)

> anova_akzeptanzS3 <- aov(Akzeptanz_S3 ~ Anwendungsfeld * Vertrauensmassnahmen, data = rohdaten)

> print(summary(anova_akzeptanzS1))
                                     Df Sum Sq Mean Sq  F value Pr(>F)    
Anwendungsfeld                        1 597349  597349 8.63e+05 <2e-16 ***
Vertrauensmassnahmen                  1      0       0 2.17e-01  0.642    
Anwendungsfeld:Vertrauensmassnahmen   1      0       0 2.27e-01  0.634    
Residuals                           371    257       1                    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> print(summary(anova_akzeptanzS2))
                                     Df Sum Sq Mean Sq F value Pr(>F)    
Anwendungsfeld                        1 593289  593289  890352 <2e-16 ***
Vertrauensmassnahmen                  1      0       0       0  0.991    
Anwendungsfeld:Vertrauensmassnahmen   1      0       0       0  0.991    
Residuals                           371    247       1                   
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> print(summary(anova_akzeptanzS3))
                                     Df Sum Sq Mean Sq   F value Pr(>F)    
Anwendungsfeld                        1 591265  591265 8.878e+05 <2e-16 ***
Vertrauensmassnahmen                  1      0       0 4.000e-03  0.948    
Anwendungsfeld:Vertrauensmassnahmen   1      0       0 4.000e-03  0.947    
Residuals                           371    247       1                     
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> # ANOVA für Akzeptanz_O1 bis Akzeptanz_O3: die F- und p-Werte sollten ähnlich sein, wenn sie das Gleiche messen
> anova_akzeptanzO1 <- aov(Akzeptanz_O1 ~ Anwendungsfeld * Vertrauensmassnahmen, data = rohdaten)

> anova_akzeptanzO2 <- aov(Akzeptanz_O2 ~ Anwendungsfeld * Vertrauensmassnahmen, data = rohdaten)

> anova_akzeptanzO3 <- aov(Akzeptanz_O3 ~ Anwendungsfeld * Vertrauensmassnahmen, data = rohdaten)

> print(summary(anova_akzeptanzO1))
                                     Df Sum Sq Mean Sq   F value Pr(>F)    
Anwendungsfeld                        1 617107  617107 1.531e+06 <2e-16 ***
Vertrauensmassnahmen                  1      0       0 5.020e-01  0.479    
Anwendungsfeld:Vertrauensmassnahmen   1      0       0 4.790e-01  0.489    
Residuals                           371    149       0                     
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> print(summary(anova_akzeptanzO2))
                                     Df Sum Sq Mean Sq   F value Pr(>F)    
Anwendungsfeld                        1 611387  611387 1.234e+06 <2e-16 ***
Vertrauensmassnahmen                  1      1       1 2.042e+00  0.154    
Anwendungsfeld:Vertrauensmassnahmen   1      1       1 1.950e+00  0.163    
Residuals                           371    184       0                     
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> print(summary(anova_akzeptanzO3))
                                     Df Sum Sq Mean Sq   F value Pr(>F)    
Anwendungsfeld                        1 607983  607983 1.192e+06 <2e-16 ***
Vertrauensmassnahmen                  1      0       0 1.090e-01  0.741    
Anwendungsfeld:Vertrauensmassnahmen   1      0       0 1.040e-01  0.747    
Residuals                           371    189       1                     
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> # Cronbach's Alpha, um zu prüfen, ob die Items zur Messung der Akzeptanz konsistent sind. Werte über 0.7 gelten als akzeptabel.
> ca_s <- alpha(rohdaten[, c("Akzeptanz_S1", "Akzeptanz_S2", "Akzeptanz_S3")])

> print(ca_s)

Reliability analysis   
Call: alpha(x = rohdaten[, c("Akzeptanz_S1", "Akzeptanz_S2", "Akzeptanz_S3")])

  raw_alpha std.alpha G6(smc) average_r   S/N     ase mean sd median_r
         1         1       1         1 18421 4.9e-06  -38 40        1

    95% confidence boundaries 
         lower alpha upper
Feldt        1     1     1
Duhachek     1     1     1

 Reliability if an item is dropped:
             raw_alpha std.alpha G6(smc) average_r   S/N alpha se var.r med.r
Akzeptanz_S1         1         1       1         1 10411  1.0e-05    NA     1
Akzeptanz_S2         1         1       1         1 12360  8.7e-06    NA     1
Akzeptanz_S3         1         1       1         1 14852  7.1e-06    NA     1

 Item statistics 
               n raw.r std.r r.cor r.drop mean sd
Akzeptanz_S1 375     1     1     1      1  -38 40
Akzeptanz_S2 375     1     1     1      1  -38 40
Akzeptanz_S3 375     1     1     1      1  -38 40

> ca_o <- alpha(rohdaten[, c("Akzeptanz_O1", "Akzeptanz_O2", "Akzeptanz_O3")])

> print(ca_o)

Reliability analysis   
Call: alpha(x = rohdaten[, c("Akzeptanz_O1", "Akzeptanz_O2", "Akzeptanz_O3")])

  raw_alpha std.alpha G6(smc) average_r   S/N     ase mean sd median_r
         1         1       1         1 18848 4.9e-06  -36 40        1

    95% confidence boundaries 
         lower alpha upper
Feldt        1     1     1
Duhachek     1     1     1

 Reliability if an item is dropped:
             raw_alpha std.alpha G6(smc) average_r   S/N alpha se var.r med.r
Akzeptanz_O1         1         1       1         1 10364  1.0e-05    NA     1
Akzeptanz_O2         1         1       1         1 13609  8.3e-06    NA     1
Akzeptanz_O3         1         1       1         1 14538  7.4e-06    NA     1

 Item statistics 
               n raw.r std.r r.cor r.drop mean sd
Akzeptanz_O1 375     1     1     1      1  -36 41
Akzeptanz_O2 375     1     1     1      1  -36 40
Akzeptanz_O3 375     1     1     1      1  -36 40

> # Korrelation zwischen den Akzeptanz-Items sollte hoch sein
> correlation_matrix <- cor(select(rohdaten, Akzeptanz_O1, Akzeptanz_O2, Akzeptanz_O3), use = "complete.obs")

> print(correlation_matrix)
             Akzeptanz_O1 Akzeptanz_O2 Akzeptanz_O3
Akzeptanz_O1    1.0000000    0.9998624    0.9998531
Akzeptanz_O2    0.9998624    1.0000000    0.9998071
Akzeptanz_O3    0.9998531    0.9998071    1.0000000

> correlation_matrix <- cor(select(rohdaten, Akzeptanz_S1, Akzeptanz_S2, Akzeptanz_S3), use = "complete.obs")

> print(correlation_matrix)
             Akzeptanz_S1 Akzeptanz_S2 Akzeptanz_S3
Akzeptanz_S1    1.0000000    0.9998654    0.9998382
Akzeptanz_S2    0.9998654    1.0000000    0.9998079
Akzeptanz_S3    0.9998382    0.9998079    1.0000000

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
t = 1164.3, df = 373, p-value < 2.2e-16
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 0.9998314 0.9998877
sample estimates:
      cor 
0.9998624 


$Akzeptanz_O1_O3

	Pearson's product-moment correlation

data:  rohdaten$Akzeptanz_O1 and rohdaten$Akzeptanz_O3
t = 1126.5, df = 373, p-value < 2.2e-16
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 0.9998199 0.9998801
sample estimates:
      cor 
0.9998531 


$Akzeptanz_O2_O3

	Pearson's product-moment correlation

data:  rohdaten$Akzeptanz_O2 and rohdaten$Akzeptanz_O3
t = 983.04, df = 373, p-value < 2.2e-16
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 0.9997636 0.9998425
sample estimates:
      cor 
0.9998071 


$Akzeptanz_S1_S2

	Pearson's product-moment correlation

data:  rohdaten$Akzeptanz_S1 and rohdaten$Akzeptanz_S2
t = 1176.8, df = 373, p-value < 2.2e-16
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 0.9998350 0.9998901
sample estimates:
      cor 
0.9998654 


$Akzeptanz_S1_S3

	Pearson's product-moment correlation

data:  rohdaten$Akzeptanz_S1 and rohdaten$Akzeptanz_S3
t = 1073.5, df = 373, p-value < 2.2e-16
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 0.9998018 0.9998680
sample estimates:
      cor 
0.9998382 


$Akzeptanz_S2_S3

	Pearson's product-moment correlation

data:  rohdaten$Akzeptanz_S2 and rohdaten$Akzeptanz_S3
t = 985.27, df = 373, p-value < 2.2e-16
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 0.9997647 0.9998433
sample estimates:
      cor 
0.9998079 



> # Überprüfung der Verteilung von Einstellung_KI zwischen den Vertrauensmassnahmen-Gruppen
> # sollte nicht signifikant sein
> print(summary(aov(Einstellung_KI ~ Vertrauensmassnahmen, data = daten)))
                      Df Sum Sq Mean Sq F value Pr(>F)  
Vertrauensmassnahmen   1   1.09  1.0943   2.814 0.0943 .
Residuals            373 145.04  0.3888                 
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

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

df null model =  3  with the objective function =  16.39 with Chi Square =  6099.6
df of  the model are 0  and the objective function was  3 

The root mean square of the residuals (RMSR) is  0 
The df corrected root mean square of the residuals is  NA 

The harmonic n.obs is  375 with the empirical chi square  0.01  with prob <  NA 
The total n.obs was  375  with Likelihood Chi Square =  1115.79  with prob <  NA 

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
Akzeptanz_O1   1  1 0.0018   1
Akzeptanz_O2   1  1 0.0018   1
Akzeptanz_O3   1  1 0.0018   1

                MR1
SS loadings    2.99
Proportion Var 1.00

Mean item complexity =  1
Test of the hypothesis that 1 factor is sufficient.

df null model =  3  with the objective function =  16.44 with Chi Square =  6118.51
df of  the model are 0  and the objective function was  3.05 

The root mean square of the residuals (RMSR) is  0 
The df corrected root mean square of the residuals is  NA 

The harmonic n.obs is  375 with the empirical chi square  0.01  with prob <  NA 
The total n.obs was  375  with Likelihood Chi Square =  1132.18  with prob <  NA 

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

df null model =  3  with the objective function =  16.39 with Chi Square =  6099.6
df of  the model are -2  and the objective function was  3 

The root mean square of the residuals (RMSR) is  0 
The df corrected root mean square of the residuals is  NA 

The harmonic n.obs is  375 with the empirical chi square  0.01  with prob <  NA 
The total n.obs was  375  with Likelihood Chi Square =  1113.79  with prob <  NA 

Tucker Lewis Index of factoring reliability =  1.276
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
Akzeptanz_O1   1   0  1 0.0018   1
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

df null model =  3  with the objective function =  16.44 with Chi Square =  6118.51
df of  the model are -2  and the objective function was  3.05 

The root mean square of the residuals (RMSR) is  0 
The df corrected root mean square of the residuals is  NA 

The harmonic n.obs is  375 with the empirical chi square  0.01  with prob <  NA 
The total n.obs was  375  with Likelihood Chi Square =  1130.15  with prob <  NA 

Tucker Lewis Index of factoring reliability =  1.279
Fit based upon off diagonal values = 1
Measures of factor score adequacy             
                                                  MR1 MR2
Correlation of (regression) scores with factors     1   0
Multiple R square of scores with factors            1   0
Minimum correlation of possible factor scores       1  -1
