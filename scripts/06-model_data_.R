#### Preamble ####
# Purpose: Model on cleaned dataset
# Author: Jiaxuan Song
# Date: 25 November 2024 
# Contact: jiaxuan.song@mail.utoronto.ca
# License: MIT
# Pre-requisites: None


# Load necessary libraries
library(dplyr)
library(rstanarm)
library(ggplot2)
library(bayesplot)

# Clean and prepare the data
cleaned_data <- data %>%
  select(DHHGAGE, DEPDVPHQ, DHHGMS, INCDGHH, EHG2DVH3, ALCDVTTM) %>%
  drop_na() %>%
  rename(
    `Age Group` = DHHGAGE,
    `Depression Score` = DEPDVPHQ,
    `Marital Status` = DHHGMS,
    `Income Group` = INCDGHH,
    `Education Level` = EHG2DVH3,
    `Alcohol Consumption` = ALCDVTTM
  ) %>%
  mutate(
    `Marital Status` = case_when(
      `Marital Status` == 1 ~ "Married/Common-law",
      `Marital Status` == 2 ~ "Other",
      TRUE ~ "Unknown"
    ),
    `Age Group` = case_when(
      `Age Group` == 1 ~ "12-17",
      `Age Group` == 2 ~ "18-34",
      `Age Group` == 3 ~ "35-49",
      `Age Group` == 4 ~ "50-64",
      `Age Group` == 5 ~ "65+",
      TRUE ~ as.character(`Age Group`)
    ),
    `Income Group` = factor(`Income Group`, levels = 1:5, 
                            labels = c("Lowest Income", "Low-Middle Income", "Middle Income", "Upper-Middle Income", "Highest Income")),
    `Education Level` = factor(`Education Level`, levels = 1:6, 
                               labels = c("No Formal Education", "Some High School", "High School Graduate", 
                                          "Some College", "College Graduate", "Postgraduate"))
  )

# Fit the Bayesian regression model
CCHS_Bayesian_model <- stan_glm(
  `Depression Score` ~ `Age Group` + `Marital Status` + `Income Group` + `Education Level` + `Alcohol Consumption`,
  data = cleaned_data,
  family = gaussian(),  # Continuous response variable
  prior = normal(location = 0, scale = 5),  # Weakly informative normal priors
  prior_intercept = normal(location = 0, scale = 10),  # Intercept prior
  prior_aux = cauchy(location = 0, scale = 2.5),  # Prior for sigma
  chains = 4,  # Number of Markov chains
  iter = 2000,  # Number of iterations per chain
  seed = 123  # Seed for reproducibility
)

# Summarize the posterior distributions
summary(CCHS_Bayesian_model)

# Posterior vs Prior Plot
posterior_vs_prior(CCHS_Bayesian_model) +
  theme_minimal() +
  scale_color_brewer(palette = "Set1") +
  theme(legend.position = "bottom") +
  coord_flip()

# Posterior Predictive Checks
pp_check(CCHS_Bayesian_model) +
  ggtitle("Posterior Predictive Checks") +
  theme_minimal()

# Extract posterior draws for visualization
posterior_draws <- as.data.frame(as.matrix(CCHS_Bayesian_model))

# Visualize posterior distributions for key variables
mcmc_areas(
  posterior_draws,
  pars = c("`Age Group`2", "`Marital Status`Other", "`Income Group`2", "`Education Level`2"),
  prob = 0.95  # 95% credible intervals
) +
  theme_minimal() +
  ggtitle("Posterior Distributions of Key Coefficients")

#### Save model ####
saveRDS(
  CCHS_Bayesian_model,
  file = "models/CCHS_Bayesian_model.rds"  
)



