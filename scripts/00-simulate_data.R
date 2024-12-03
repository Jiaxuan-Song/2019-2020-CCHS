#### Preamble ####
# Purpose: Simulates an analysis dataset about the 
# Author: Jiaxuan Song
# Date: 24 November 2024
# Contact: jiaxuan.song@mail.utoronto.ca
# License: MIT
# Pre-requisites: none

# Load necessary library
library(tidyverse)
library(arrow)
set.seed(123) # For reproducibility

# Simulate number of observations
n <- 1000 # Number of respondents

# Simulate variables based on structure

DEPDVPHQ <- sample(0:27, n, replace = TRUE) # Depression severity scale
DHHGAGE <- sample(1:5, n, replace = TRUE) 
# 1: 12-17, 2: 18-34, 3: 35-49, 4: 50-64, 5: 65+

DHHGMS <- sample(1:2, n, replace = TRUE, prob = c(0.6, 0.4)) 
# 1: Married/Common-law, 2: Other

INCDGHH <- sample(1:3, n, replace = TRUE, prob = c(0.4, 0.4, 0.2)) 
# 1: Low, 2: Medium, 3: High

EHG2DVH3 <- sample(1:3, n, replace = TRUE, prob = c(0.4, 0.4, 0.2)) 
# 1: High School, 2: Post-secondary, 3: Graduate

ALCDVTTM <- sample(0:50, n, replace = TRUE)  # Weekly alcohol consumption
DEPDVPHQ <- sample(0:27, n, replace = TRUE) # Depression severity scale

# Combine into a data frame
simulated_data <- data.frame(
  DEPDVPHQ,
  DHHGAGE,
  DHHGMS,
  INCDGHH,
  EHG2DVH3,
  ALCDVTTM
)

# Preview the simulated data
head(simulated_data)

# Save the simulated data
write_parquet(simulated_data, "data/00-simulated_data/cchs_simulated_data.parquet")
