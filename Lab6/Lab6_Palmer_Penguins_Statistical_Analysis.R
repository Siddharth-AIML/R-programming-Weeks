# ============================================================
# LAB PROBLEM STATEMENT 6
# Statistical Analysis of Physical Characteristics of Palmer Penguins
# ============================================================
# Topics:
# 1. Descriptive Statistics
# 2. Hypothesis Testing
# 3. One-Way ANOVA
# 4. Kruskal-Wallis Test
# 5. Two-Way ANOVA
# 6. Flipper Length Analysis
# 7. Required Visualizations
# ============================================================

# -------------------- 1. INSTALL & LOAD PACKAGES --------------------

required_packages <- c(
  "palmerpenguins",
  "dplyr",
  "ggplot2",
  "moments",
  "car"
)

for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
}

library(palmerpenguins)
library(dplyr)
library(ggplot2)
library(moments)
library(car)

cat("\n============================================================\n")
cat("LAB 6 - PALMER PENGUINS STATISTICAL ANALYSIS\n")
cat("============================================================\n")

# -------------------- 2. LOAD DATASET --------------------

data("penguins")

cat("\nDataset loaded successfully.\n")
cat("Rows:", nrow(penguins), "\n")
cat("Columns:", ncol(penguins), "\n")

cat("\nFirst 6 observations:\n")
print(head(penguins))

cat("\nMissing values:\n")
print(colSums(is.na(penguins)))

# -------------------- 3. CREATE OUTPUT FOLDER --------------------

out <- "Lab6_Results"

if (!dir.exists(out)) {
  dir.create(out)
}

# -------------------- 4. CLEAN DATA --------------------
# Complete cases for the main analyses

p <- penguins %>%
  filter(
    !is.na(body_mass_g),
    !is.na(flipper_length_mm),
    !is.na(species),
    !is.na(sex)
  )

cat("\nRows used for analysis:", nrow(p), "\n")

# ============================================================
# TASK 1 - DESCRIPTIVE STATISTICS
# ============================================================

cat("\n============================================================\n")
cat("TASK 1 - DESCRIPTIVE STATISTICS: BODY MASS\n")
cat("============================================================\n")

bm <- p$body_mass_g

overall <- data.frame(
  Statistic = c(
    "Mean",
    "Median",
    "Minimum",
    "Maximum",
    "Variance",
    "Standard Deviation",
    "Q1",
    "Q3",
    "IQR",
    "Skewness",
    "Kurtosis"
  ),
  Value = c(
    mean(bm),
    median(bm),
    min(bm),
    max(bm),
    var(bm),
    sd(bm),
    as.numeric(quantile(bm, 0.25)),
    as.numeric(quantile(bm, 0.75)),
    IQR(bm),
    skewness(bm),
    kurtosis(bm)
  )
)

cat("\nOverall Body Mass Statistics:\n")
print(overall)

write.csv(
  overall,
  file.path(out, "overall_descriptive_statistics.csv"),
  row.names = FALSE
)

# Species-wise statistics

species_stats <- p %>%
  group_by(species) %>%
  summarise(
    Count = n(),
    Mean = mean(body_mass_g),
    Median = median(body_mass_g),
    Minimum = min(body_mass_g),
    Maximum = max(body_mass_g),
    Variance = var(body_mass_g),
    SD = sd(body_mass_g),
    Q1 = as.numeric(quantile(body_mass_g, 0.25)),
    Q3 = as.numeric(quantile(body_mass_g, 0.75)),
    IQR = IQR(body_mass_g),
    Skewness = skewness(body_mass_g),
    Kurtosis = kurtosis(body_mass_g),
    .groups = "drop"
  )

cat("\nSpecies-wise Body Mass Statistics:\n")
print(species_stats)

write.csv(
  species_stats,
  file.path(out, "species_descriptive_statistics.csv"),
  row.names = FALSE
)

# -------------------- Required Visualizations --------------------

g1 <- ggplot(p, aes(x = body_mass_g)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  labs(
    title = "Histogram of Penguin Body Mass",
    x = "Body Mass (g)",
    y = "Frequency"
  ) +
  theme_minimal()

print(g1)
ggsave(
  file.path(out, "histogram_body_mass.png"),
  g1,
  width = 8,
  height = 6
)

g2 <- ggplot(p, aes(x = species, y = body_mass_g)) +
  geom_boxplot(fill = "lightgreen", color = "black") +
  labs(
    title = "Body Mass by Penguin Species",
    x = "Species",
    y = "Body Mass (g)"
  ) +
  theme_minimal()

print(g2)
ggsave(
  file.path(out, "species_boxplot_body_mass.png"),
  g2,
  width = 8,
  height = 6
)

g3 <- ggplot(p, aes(x = body_mass_g)) +
  geom_density(fill = "lightblue", alpha = 0.6) +
  labs(
    title = "Density Plot of Penguin Body Mass",
    x = "Body Mass (g)",
    y = "Density"
  ) +
  theme_minimal()

print(g3)
ggsave(
  file.path(out, "density_body_mass.png"),
  g3,
  width = 8,
  height = 6
)

g4 <- ggplot(p, aes(x = sex, y = body_mass_g)) +
  geom_boxplot(fill = "lightpink", color = "black") +
  labs(
    title = "Body Mass by Penguin Sex",
    x = "Sex",
    y = "Body Mass (g)"
  ) +
  theme_minimal()

print(g4)
ggsave(
  file.path(out, "sex_boxplot_body_mass.png"),
  g4,
  width = 8,
  height = 6
)

# ============================================================
# TASK 2 - MALE VS FEMALE HYPOTHESIS TESTING
# ============================================================

cat("\n============================================================\n")
cat("TASK 2 - MALE VS FEMALE BODY MASS\n")
cat("============================================================\n")

cat("\nH0: Mean male body mass = Mean female body mass\n")
cat("H1: Mean male body mass != Mean female body mass\n")

male <- p %>%
  filter(sex == "male") %>%
  pull(body_mass_g)

female <- p %>%
  filter(sex == "female") %>%
  pull(body_mass_g)

cat("\nMale sample size:", length(male), "\n")
cat("Female sample size:", length(female), "\n")

cat("\nMale mean:", mean(male), "g\n")
cat("Female mean:", mean(female), "g\n")

# Shapiro-Wilk tests

sh_male <- shapiro.test(male)
sh_female <- shapiro.test(female)

cat("\nShapiro-Wilk Test - Male:\n")
print(sh_male)

cat("\nShapiro-Wilk Test - Female:\n")
print(sh_female)

# QQ plots

png(
  file.path(out, "QQ_male.png"),
  width = 800,
  height = 600
)
qqnorm(male, main = "QQ Plot - Male Body Mass")
qqline(male)
dev.off()

png(
  file.path(out, "QQ_female.png"),
  width = 800,
  height = 600
)
qqnorm(female, main = "QQ Plot - Female Body Mass")
qqline(female)
dev.off()

# Independent two-sample Welch t-test

tt <- t.test(
  male,
  female,
  var.equal = FALSE,
  conf.level = 0.95
)

cat("\nIndependent Two-Sample t-Test:\n")
print(tt)

# Cohen's d

n1 <- length(male)
n2 <- length(female)

sp <- sqrt(
  ((n1 - 1) * sd(male)^2 +
     (n2 - 1) * sd(female)^2) /
    (n1 + n2 - 2)
)

d <- (mean(male) - mean(female)) / sp

cat("\nCohen's d:", d, "\n")
cat("95% CI for mean difference:", tt$conf.int, "\n")

if (abs(d) < 0.2) {
  effect_interpretation <- "Negligible effect"
} else if (abs(d) < 0.5) {
  effect_interpretation <- "Small effect"
} else if (abs(d) < 0.8) {
  effect_interpretation <- "Medium effect"
} else {
  effect_interpretation <- "Large effect"
}

cat("Effect size interpretation:", effect_interpretation, "\n")

if (tt$p.value < 0.05) {
  cat("Conclusion: Reject H0. Male and female mean body masses differ significantly.\n")
} else {
  cat("Conclusion: Fail to reject H0. Evidence is insufficient to conclude a significant difference.\n")
}

# ============================================================
# TASK 3 - ONE-WAY ANOVA
# ============================================================

cat("\n============================================================\n")
cat("TASK 3 - ONE-WAY ANOVA: BODY MASS ~ SPECIES\n")
cat("============================================================\n")

a1 <- aov(
  body_mass_g ~ species,
  data = p
)

cat("\nANOVA Table:\n")
print(summary(a1))

# Species-wise normality

cat("\nSpecies-wise Shapiro-Wilk Tests:\n")

species_levels <- levels(factor(p$species))

for (s in species_levels) {
  x <- p %>%
    filter(species == s) %>%
    pull(body_mass_g)

  cat("\n", s, ":\n", sep = "")
  print(shapiro.test(x))
}

# QQ plots for all species

png(
  file.path(out, "QQ_species.png"),
  width = 1000,
  height = 800
)

par(mfrow = c(2, 2))

for (s in species_levels) {
  x <- p %>%
    filter(species == s) %>%
    pull(body_mass_g)

  qqnorm(
    x,
    main = paste("QQ Plot -", s)
  )
  qqline(x)
}

par(mfrow = c(1, 1))
dev.off()

# Levene's test

cat("\nLevene's Test for Homogeneity of Variance:\n")

lev <- car::leveneTest(
  body_mass_g ~ species,
  data = p
)

print(lev)

# ANOVA p-value

a1_p <- summary(a1)[[1]][["Pr(>F)"]][1]

cat("\nANOVA p-value:", a1_p, "\n")

# Tukey HSD if significant

if (a1_p < 0.05) {

  cat("\nANOVA is significant.\n")
  cat("Performing Tukey HSD post-hoc test...\n")

  tuk <- TukeyHSD(a1)

  print(tuk)

  capture.output(
    tuk,
    file = file.path(out, "tukey_HSD_results.txt")
  )

} else {

  cat("\nANOVA is not significant; Tukey HSD is not required.\n")
}

# ============================================================
# TASK 4 - KRUSKAL-WALLIS TEST
# ============================================================

cat("\n============================================================\n")
cat("TASK 4 - KRUSKAL-WALLIS TEST\n")
cat("============================================================\n")

kw <- kruskal.test(
  body_mass_g ~ species,
  data = p
)

print(kw)

cat("\nANOVA p-value:", a1_p, "\n")
cat("Kruskal-Wallis p-value:", kw$p.value, "\n")

if (a1_p < 0.05 && kw$p.value < 0.05) {

  cat(
    "Conclusion: Both ANOVA and Kruskal-Wallis indicate significant differences among species.\n"
  )

} else if (a1_p >= 0.05 && kw$p.value >= 0.05) {

  cat(
    "Conclusion: Both ANOVA and Kruskal-Wallis indicate no significant differences among species.\n"
  )

} else {

  cat(
    "Conclusion: The two methods give different conclusions; assumptions should be considered carefully.\n"
  )
}

# ============================================================
# TASK 5 - TWO-WAY ANOVA
# ============================================================

cat("\n============================================================\n")
cat("TASK 5 - TWO-WAY ANOVA: BODY MASS ~ SPECIES * SEX\n")
cat("============================================================\n")

a2 <- aov(
  body_mass_g ~ species * sex,
  data = p
)

tw <- summary(a2)[[1]]

cat("\nTwo-Way ANOVA Table:\n")
print(summary(a2))

cat("\nSpecies p-value:", tw["species", "Pr(>F)"], "\n")
cat("Sex p-value:", tw["sex", "Pr(>F)"], "\n")
cat(
  "Species x Sex interaction p-value:",
  tw["species:sex", "Pr(>F)"],
  "\n"
)

g5 <- ggplot(
  p,
  aes(
    x = species,
    y = body_mass_g,
    fill = sex
  )
) +
  geom_boxplot() +
  labs(
    title = "Body Mass by Species and Sex",
    x = "Species",
    y = "Body Mass (g)",
    fill = "Sex"
  ) +
  theme_minimal()

print(g5)

ggsave(
  file.path(out, "species_sex_body_mass.png"),
  g5,
  width = 9,
  height = 6
)

# ============================================================
# TASK 6 - FLIPPER LENGTH ANALYSIS
# ============================================================

cat("\n============================================================\n")
cat("TASK 6 - FLIPPER LENGTH ANALYSIS\n")
cat("============================================================\n")

flipper_stats <- p %>%
  group_by(species) %>%
  summarise(
    Count = n(),
    Mean = mean(flipper_length_mm),
    Median = median(flipper_length_mm),
    Minimum = min(flipper_length_mm),
    Maximum = max(flipper_length_mm),
    SD = sd(flipper_length_mm),
    IQR = IQR(flipper_length_mm),
    .groups = "drop"
  )

cat("\nFlipper Length Statistics by Species:\n")
print(flipper_stats)

write.csv(
  flipper_stats,
  file.path(out, "flipper_length_statistics.csv"),
  row.names = FALSE
)

# Flipper length ANOVA

fa <- aov(
  flipper_length_mm ~ species,
  data = p
)

cat("\nFlipper Length One-Way ANOVA:\n")
print(summary(fa))

# Flipper length Kruskal-Wallis

fk <- kruskal.test(
  flipper_length_mm ~ species,
  data = p
)

cat("\nFlipper Length Kruskal-Wallis Test:\n")
print(fk)

# Flipper length visualization

g6 <- ggplot(
  p,
  aes(
    x = species,
    y = flipper_length_mm
  )
) +
  geom_boxplot(fill = "lightyellow", color = "black") +
  labs(
    title = "Flipper Length by Penguin Species",
    x = "Species",
    y = "Flipper Length (mm)"
  ) +
  theme_minimal()

print(g6)

ggsave(
  file.path(out, "flipper_length_species.png"),
  g6,
  width = 8,
  height = 6
)

# ============================================================
# TASK 7 - GROUP COMPARISON PLOT
# ============================================================

cat("\n============================================================\n")
cat("TASK 7 - GROUP COMPARISON PLOT\n")
cat("============================================================\n")

means <- p %>%
  group_by(species) %>%
  summarise(
    Mean = mean(body_mass_g),
    SD = sd(body_mass_g),
    .groups = "drop"
  )

g7 <- ggplot(
  means,
  aes(
    x = species,
    y = Mean
  )
) +
  geom_col(fill = "steelblue") +
  geom_errorbar(
    aes(
      ymin = Mean - SD,
      ymax = Mean + SD
    ),
    width = 0.2
  ) +
  labs(
    title = "Mean Body Mass by Penguin Species",
    x = "Species",
    y = "Mean Body Mass (g)"
  ) +
  theme_minimal()

print(g7)

ggsave(
  file.path(out, "group_mean_body_mass.png"),
  g7,
  width = 8,
  height = 6
)

# ============================================================
# SAVE COMPLETE STATISTICAL RESULTS
# ============================================================

results_file <- file.path(
  out,
  "complete_statistical_results.txt"
)

sink(results_file)

cat("LAB PROBLEM STATEMENT 6 - PALMER PENGUINS\n")
cat("=========================================\n\n")

cat("Observations used:", nrow(p), "\n\n")

cat("OVERALL DESCRIPTIVE STATISTICS\n")
print(overall)

cat("\nSPECIES-WISE DESCRIPTIVE STATISTICS\n")
print(species_stats)

cat("\nMALE SHAPIRO-WILK TEST\n")
print(sh_male)

cat("\nFEMALE SHAPIRO-WILK TEST\n")
print(sh_female)

cat("\nTWO-SAMPLE WELCH t-TEST\n")
print(tt)

cat("\nCOHEN'S d\n")
print(d)

cat("\n95% CI FOR MEAN DIFFERENCE\n")
print(tt$conf.int)

cat("\nONE-WAY ANOVA\n")
print(summary(a1))

cat("\nLEVENE'S TEST\n")
print(lev)

if (a1_p < 0.05) {
  cat("\nTUKEY HSD\n")
  print(TukeyHSD(a1))
}

cat("\nKRUSKAL-WALLIS TEST\n")
print(kw)

cat("\nTWO-WAY ANOVA\n")
print(summary(a2))

cat("\nFLIPPER LENGTH STATISTICS\n")
print(flipper_stats)

cat("\nFLIPPER LENGTH ANOVA\n")
print(summary(fa))

cat("\nFLIPPER LENGTH KRUSKAL-WALLIS\n")
print(fk)

sink()

# ============================================================
# FINAL MESSAGE
# ============================================================

cat("\n============================================================\n")
cat("LAB 6 COMPLETED SUCCESSFULLY\n")
cat("============================================================\n")
cat("All analysis and visualizations have been generated.\n")
cat("Results saved in folder:", normalizePath(out), "\n")
cat("============================================================\n")
