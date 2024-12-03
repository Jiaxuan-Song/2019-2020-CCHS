#### Preamble ####
# Purpose: Models
# Author: Jiaxuan Song
# Date: 29 November 2024
# Contact: jiaxuan.song@mail.utoronto.ca
# License: MIT
# Pre-requisites: None



# Load necessary libraries
library(tidyverse)
library(arrow)
library(testthat)

# Load the data
cleaned_data <- read_parquet("data/02-analysis_data/cchs_cleaned_data.parquet")


# Plot 1: Distribution of Age Group (DHHGAGE)
ggplot(cleaned_data, aes(x = as.factor(DHHGAGE))) +
  geom_bar() +
  labs(title = "Distribution of Age Group (DHHGAGE)", x = "Age Group", y = "Count") +
  theme_minimal()

# Plot 2: Marital Status (DHHGMS) vs Household Income (INCDGHH)
ggplot(cleaned_data, aes(x = as.factor(DHHGMS), fill = as.factor(INCDGHH))) +
  geom_bar(position = "dodge") +
  labs(title = "Marital Status vs Household Income", x = "Marital Status", y = "Count", fill = "Household Income") +
  theme_minimal()

# Plot 3: Weekly Alcohol Consumption (ALCDVTTM) Histogram
ggplot(cleaned_data, aes(x = ALCDVTTM)) +
  geom_histogram(binwidth = 10, fill = "blue", color = "black") +
  labs(title = "Weekly Alcohol Consumption (ALCDVTTM)", x = "Alcohol Consumption (in standard drinks)", y = "Frequency") +
  theme_minimal()
