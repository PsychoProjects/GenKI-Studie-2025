source("InstallPackages.R")

# Ermittlung der benötigten Power für die ANCOVA
## Parameter
effect_size <- 0.2 # Cohen's f
alpha <- 0.05 # significance level
power <- 0.8 # 1-beta
num_groups <- 4 # 2x2 design

## Benötigte Stichprobengröße
sample_size <- pwr.anova.test(k = num_groups, f = effect_size, sig.level = alpha, power = power)

stichprobe_df <- data.frame(
  Parameter = c("Gesamt", "Pro Gruppe"),
  Wert = c(ceiling(sample_size$n * num_groups), ceiling(sample_size$n))
)
kable(stichprobe_df, col.names = c("Bereich", "Benötigte Stichprobengröße")) %>% print()
