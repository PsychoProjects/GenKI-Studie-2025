source("R/InstallPackages.R")

# Parameter
effect_size <- 0.2 # Cohen's f
alpha <- 0.05 # significance level
power <- 0.8 # 1-beta
num_groups <- 4 # 2x2 design

# Stichprobengröße je Gruppe
sample_size <- pwr.anova.test(k = num_groups, f = effect_size, sig.level = alpha, power = power)

# Output the total sample size
cat("Stichprobengröße:", ceiling(sample_size$n * num_groups), "\n")
cat("Stichprobengröße je Gruppe:", ceiling(sample_size$n), "\n")
