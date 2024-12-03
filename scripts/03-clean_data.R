#### Preamble ####
# Purpose: Cleans the raw data for model preparing
# Author: Jiaxuan Song
# Date: 24 November 2024
# Contact: jiaxuan.song@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - The `dplyr` and `readr` packages must be installed and loaded.
# - 02-download_data.R must have been run.

# Load necessary libraries
library(dplyr)
library(readr)
library(arrow)


# Load raw data
data <- read_csv("data/01-raw_data/cchs_raw_data.csv")

# Define a vector of predefined missing value codes for numeric and character columns
missing_values_numeric <- c(6, 9, 96, 99, 996, 99996, 999, 999.6, 999.9, 9999.6, 9999, 9999.9, 99999)
missing_values_character <- c("6", "9", "96", "99", "996", "99996", "999", "999.6", "999.9", "9999.6", "9999", "9999.9", "99999")

# Replace predefined missing value codes with NA
data <- data %>%
  mutate(across(where(is.numeric), ~ ifelse(.x %in% missing_values_numeric, NA, .x))) %>%
  mutate(across(where(is.character), ~ ifelse(.x %in% missing_values_character, NA, .x)))

# Select relevant variables
cleaned_data <- data %>%
  select(
    DHHGAGE, DEPDVPHQ, DHHGMS, INCDGHH, EHG2DVH3, ALCDVTTM
  )

# Display the first few rows of the cleaned data
head(cleaned_data)

# Save the cleaned data to a new Parquet file
write_parquet(cleaned_data, "data/02-analysis_data/cchs_cleaned_data.parquet")



