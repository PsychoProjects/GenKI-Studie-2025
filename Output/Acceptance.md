
> source("InstallPackages.R")

> source("Read_Data.R")

> # Cronbachs Alpha für objektive Anwendungsfelder
> akzeptanz_daten_objektiv <- daten %>% 
+   filter(Anwendungsfeld == "Objektiv") %>%
+   select(starts_with("Akzeptanz_O"))

> alpha(akzeptanz_daten_objektiv)

Reliability analysis   
Call: alpha(x = akzeptanz_daten_objektiv)

  raw_alpha std.alpha G6(smc) average_r S/N   ase mean   sd median_r
      0.71      0.71    0.63      0.45 2.4 0.037  3.8 0.76     0.47

    95% confidence boundaries 
         lower alpha upper
Feldt     0.62  0.71  0.77
Duhachek  0.63  0.71  0.78

 Reliability if an item is dropped:
             raw_alpha std.alpha G6(smc) average_r S/N alpha se var.r med.r
Akzeptanz_O1      0.54      0.54    0.37      0.37 1.2    0.066    NA  0.37
Akzeptanz_O2      0.64      0.64    0.47      0.47 1.8    0.052    NA  0.47
Akzeptanz_O3      0.66      0.67    0.50      0.50 2.0    0.048    NA  0.50

 Item statistics 
               n raw.r std.r r.cor r.drop mean   sd
Akzeptanz_O1 191  0.81  0.83  0.70   0.59  4.1 0.89
Akzeptanz_O2 191  0.79  0.78  0.61   0.50  3.8 0.99
Akzeptanz_O3 191  0.78  0.77  0.58   0.49  3.5 1.00

Non missing response frequency for each item
                1    2    3    4    5 miss
Akzeptanz_O1 0.02 0.05 0.08 0.48 0.38    0
Akzeptanz_O2 0.03 0.12 0.13 0.53 0.20    0
Akzeptanz_O3 0.03 0.16 0.20 0.48 0.14    0

> # Berechnung der Korrelationsmatrix nur obere Diagonale
> cor(akzeptanz_daten_objektiv)
             Akzeptanz_O1 Akzeptanz_O2 Akzeptanz_O3
Akzeptanz_O1    1.0000000    0.4999611    0.4733698
Akzeptanz_O2    0.4999611    1.0000000    0.3728920
Akzeptanz_O3    0.4733698    0.3728920    1.0000000

> # Faktorenanalyse mit 2 Faktoren fpr objektive Anwendungsfelder
> fa(akzeptanz_daten_objektiv, nfactors = 3, rotate = "varimax")
Factor Analysis using method =  minres
Call: fa(r = akzeptanz_daten_objektiv, nfactors = 3, rotate = "varimax")
Standardized loadings (pattern matrix) based upon correlation matrix
              MR1  MR2 MR3   h2   u2 com
Akzeptanz_O1 0.56 0.54   0 0.61 0.39 2.0
Akzeptanz_O2 0.55 0.35   0 0.43 0.57 1.7
Akzeptanz_O3 0.34 0.52   0 0.39 0.61 1.7

                       MR1  MR2  MR3
SS loadings           0.73 0.69 0.00
Proportion Var        0.24 0.23 0.00
Cumulative Var        0.24 0.47 0.47
Proportion Explained  0.52 0.48 0.00
Cumulative Proportion 0.52 1.00 1.00

Mean item complexity =  1.8
Test of the hypothesis that 3 factors are sufficient.

df null model =  3  with the objective function =  0.57 with Chi Square =  107.96
df of  the model are -3  and the objective function was  0 

The root mean square of the residuals (RMSR) is  0 
The df corrected root mean square of the residuals is  NA 

The harmonic n.obs is  191 with the empirical chi square  0  with prob <  NA 
The total n.obs was  191  with Likelihood Chi Square =  0  with prob <  NA 

Tucker Lewis Index of factoring reliability =  1.029
Fit based upon off diagonal values = 1
Measures of factor score adequacy             
                                                    MR1   MR2 MR3
Correlation of (regression) scores with factors    0.64  0.62   0
Multiple R square of scores with factors           0.41  0.38   0
Minimum correlation of possible factor scores     -0.18 -0.23  -1

> fa(akzeptanz_daten_objektiv, nfactors = 2, rotate = "varimax")
Factor Analysis using method =  minres
Call: fa(r = akzeptanz_daten_objektiv, nfactors = 2, rotate = "varimax")
Standardized loadings (pattern matrix) based upon correlation matrix
              MR1  MR2   h2   u2 com
Akzeptanz_O1 0.56 0.54 0.61 0.39 2.0
Akzeptanz_O2 0.55 0.35 0.43 0.57 1.7
Akzeptanz_O3 0.34 0.52 0.39 0.61 1.7

                       MR1  MR2
SS loadings           0.73 0.69
Proportion Var        0.24 0.23
Cumulative Var        0.24 0.47
Proportion Explained  0.52 0.48
Cumulative Proportion 0.52 1.00

Mean item complexity =  1.8
Test of the hypothesis that 2 factors are sufficient.

df null model =  3  with the objective function =  0.57 with Chi Square =  107.96
df of  the model are -2  and the objective function was  0 

The root mean square of the residuals (RMSR) is  0 
The df corrected root mean square of the residuals is  NA 

The harmonic n.obs is  191 with the empirical chi square  0  with prob <  NA 
The total n.obs was  191  with Likelihood Chi Square =  0  with prob <  NA 

Tucker Lewis Index of factoring reliability =  1.029
Fit based upon off diagonal values = 1
Measures of factor score adequacy             
                                                    MR1   MR2
Correlation of (regression) scores with factors    0.64  0.62
Multiple R square of scores with factors           0.41  0.38
Minimum correlation of possible factor scores     -0.18 -0.23

> fa(akzeptanz_daten_objektiv, nfactors = 1, rotate = "varimax")
Factor Analysis using method =  minres
Call: fa(r = akzeptanz_daten_objektiv, nfactors = 1, rotate = "varimax")
Standardized loadings (pattern matrix) based upon correlation matrix
              MR1   h2   u2 com
Akzeptanz_O1 0.80 0.63 0.37   1
Akzeptanz_O2 0.63 0.39 0.61   1
Akzeptanz_O3 0.59 0.35 0.65   1

                MR1
SS loadings    1.38
Proportion Var 0.46

Mean item complexity =  1
Test of the hypothesis that 1 factor is sufficient.

df null model =  3  with the objective function =  0.57 with Chi Square =  107.96
df of  the model are 0  and the objective function was  0 

The root mean square of the residuals (RMSR) is  0 
The df corrected root mean square of the residuals is  NA 

The harmonic n.obs is  191 with the empirical chi square  0  with prob <  NA 
The total n.obs was  191  with Likelihood Chi Square =  0  with prob <  NA 

Tucker Lewis Index of factoring reliability =  -Inf
Fit based upon off diagonal values = 1
Measures of factor score adequacy             
                                                   MR1
Correlation of (regression) scores with factors   0.86
Multiple R square of scores with factors          0.75
Minimum correlation of possible factor scores     0.49

> # Cronbachs Alpha für subjektive Anwendungsfelder
> akzeptanz_daten_subjektiv <- daten %>% 
+   filter(Anwendungsfeld == "Subjektiv") %>%
+   select(starts_with("Akzeptanz_S"))

> alpha(akzeptanz_daten_subjektiv)

Reliability analysis   
Call: alpha(x = akzeptanz_daten_subjektiv)

  raw_alpha std.alpha G6(smc) average_r S/N   ase mean sd median_r
      0.83      0.83    0.77      0.61 4.8 0.022  2.6  1     0.62

    95% confidence boundaries 
         lower alpha upper
Feldt     0.78  0.83  0.87
Duhachek  0.78  0.83  0.87

 Reliability if an item is dropped:
             raw_alpha std.alpha G6(smc) average_r S/N alpha se var.r med.r
Akzeptanz_S1      0.70      0.70    0.54      0.54 2.3    0.044    NA  0.54
Akzeptanz_S2      0.76      0.76    0.62      0.62 3.2    0.035    NA  0.62
Akzeptanz_S3      0.81      0.81    0.68      0.68 4.3    0.028    NA  0.68

 Item statistics 
               n raw.r std.r r.cor r.drop mean  sd
Akzeptanz_S1 184  0.89  0.89  0.82   0.74  2.8 1.2
Akzeptanz_S2 184  0.86  0.86  0.75   0.68  2.6 1.2
Akzeptanz_S3 184  0.83  0.83  0.69   0.63  2.4 1.2

Non missing response frequency for each item
                1    2    3    4    5 miss
Akzeptanz_S1 0.15 0.30 0.18 0.32 0.05    0
Akzeptanz_S2 0.20 0.35 0.17 0.25 0.03    0
Akzeptanz_S3 0.25 0.34 0.16 0.22 0.03    0

> # Berechnung der Korrelationsmatrix
> cor(akzeptanz_daten_subjektiv)
             Akzeptanz_S1 Akzeptanz_S2 Akzeptanz_S3
Akzeptanz_S1    1.0000000    0.6820571    0.6184621
Akzeptanz_S2    0.6820571    1.0000000    0.5395433
Akzeptanz_S3    0.6184621    0.5395433    1.0000000

> # Faktorenanalyse mit 2 Faktoren für subjektive Anwendungsfelder
> fa(akzeptanz_daten_subjektiv, nfactors = 3, rotate = "varimax")
Factor Analysis using method =  minres
Call: fa(r = akzeptanz_daten_subjektiv, nfactors = 3, rotate = "varimax")
Standardized loadings (pattern matrix) based upon correlation matrix
              MR2  MR1 MR3   h2   u2 com
Akzeptanz_S1 0.62 0.62   0 0.77 0.23 2.0
Akzeptanz_S2 0.48 0.63   0 0.62 0.38 1.9
Akzeptanz_S3 0.58 0.42   0 0.51 0.49 1.8

                       MR2  MR1  MR3
SS loadings           0.95 0.95 0.00
Proportion Var        0.32 0.32 0.00
Cumulative Var        0.32 0.63 0.63
Proportion Explained  0.50 0.50 0.00
Cumulative Proportion 0.50 1.00 1.00

Mean item complexity =  1.9
Test of the hypothesis that 3 factors are sufficient.

df null model =  3  with the objective function =  1.15 with Chi Square =  208.49
df of  the model are -3  and the objective function was  0 

The root mean square of the residuals (RMSR) is  0 
The df corrected root mean square of the residuals is  NA 

The harmonic n.obs is  184 with the empirical chi square  0  with prob <  NA 
The total n.obs was  184  with Likelihood Chi Square =  0  with prob <  NA 

Tucker Lewis Index of factoring reliability =  1.015
Fit based upon off diagonal values = 1
Measures of factor score adequacy             
                                                    MR2   MR1 MR3
Correlation of (regression) scores with factors    0.67  0.68   0
Multiple R square of scores with factors           0.45  0.46   0
Minimum correlation of possible factor scores     -0.10 -0.08  -1

> fa(akzeptanz_daten_subjektiv, nfactors = 2, rotate = "varimax")
Factor Analysis using method =  minres
Call: fa(r = akzeptanz_daten_subjektiv, nfactors = 2, rotate = "varimax")
Standardized loadings (pattern matrix) based upon correlation matrix
              MR2  MR1   h2   u2 com
Akzeptanz_S1 0.62 0.62 0.77 0.23 2.0
Akzeptanz_S2 0.48 0.63 0.62 0.38 1.9
Akzeptanz_S3 0.58 0.42 0.51 0.49 1.8

                       MR2  MR1
SS loadings           0.95 0.95
Proportion Var        0.32 0.32
Cumulative Var        0.32 0.63
Proportion Explained  0.50 0.50
Cumulative Proportion 0.50 1.00

Mean item complexity =  1.9
Test of the hypothesis that 2 factors are sufficient.

df null model =  3  with the objective function =  1.15 with Chi Square =  208.49
df of  the model are -2  and the objective function was  0 

The root mean square of the residuals (RMSR) is  0 
The df corrected root mean square of the residuals is  NA 

The harmonic n.obs is  184 with the empirical chi square  0  with prob <  NA 
The total n.obs was  184  with Likelihood Chi Square =  0  with prob <  NA 

Tucker Lewis Index of factoring reliability =  1.015
Fit based upon off diagonal values = 1
Measures of factor score adequacy             
                                                    MR2   MR1
Correlation of (regression) scores with factors    0.67  0.68
Multiple R square of scores with factors           0.45  0.46
Minimum correlation of possible factor scores     -0.10 -0.08

> fa(akzeptanz_daten_subjektiv, nfactors = 1, rotate = "varimax")
Factor Analysis using method =  minres
Call: fa(r = akzeptanz_daten_subjektiv, nfactors = 1, rotate = "varimax")
Standardized loadings (pattern matrix) based upon correlation matrix
              MR1   h2   u2 com
Akzeptanz_S1 0.88 0.78 0.22   1
Akzeptanz_S2 0.77 0.60 0.40   1
Akzeptanz_S3 0.70 0.49 0.51   1

                MR1
SS loadings    1.87
Proportion Var 0.62

Mean item complexity =  1
Test of the hypothesis that 1 factor is sufficient.

df null model =  3  with the objective function =  1.15 with Chi Square =  208.49
df of  the model are 0  and the objective function was  0 

The root mean square of the residuals (RMSR) is  0 
The df corrected root mean square of the residuals is  NA 

The harmonic n.obs is  184 with the empirical chi square  0  with prob <  NA 
The total n.obs was  184  with Likelihood Chi Square =  0  with prob <  NA 

Tucker Lewis Index of factoring reliability =  -Inf
Fit based upon off diagonal values = 1
Measures of factor score adequacy             
                                                   MR1
Correlation of (regression) scores with factors   0.93
Multiple R square of scores with factors          0.86
Minimum correlation of possible factor scores     0.71

> # Analyse der Werteverteilung
> plot_histograms <- function(data) {
+   data %>%
+     select(starts_with("Akzeptanz")) %>%
+     gather(variable, value) %>%
+     ggplot(aes(x = value)) +
+     geom_histogram(aes(y = ..density..), bins = 10, fill = "lightblue", color = "black") +
+     geom_density(alpha = 0.2, fill = "red") +
+     facet_wrap(~ variable, scales = "free") +
+     labs(x = "Wert", y = "Häufigkeit")
+ }

> # Histogramme für objektive Anwendungsfelder
> plot_histograms(akzeptanz_daten_objektiv)

> # Histogramme für subjektive Anwendungsfelder
> plot_histograms(akzeptanz_daten_subjektiv)
