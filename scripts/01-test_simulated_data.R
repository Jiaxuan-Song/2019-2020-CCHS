#### Preamble ####
# Purpose: Tests the structure and validity of the simulated dataset
# Author: Jiaxuan Song
# Date: 24 November 2024
# Contact: jiaxuan.song@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` and `arrow` packages must be installed and loaded
  # - 00-simulate_data.R must have been run

# Load necessary libraries
library(tidyverse)
library(arrow)
library(testthat)

# Load the simulated data
simulated_data <- read_parquet("data/00-simulated_data/cchs_simulated_data.parquet")

# Function to validate categorical variables
validate_categories <- function(column, valid_values, column_name) {
  test_that(glue::glue("{column_name} contains only valid values"), {
    expect_true(all(column %in% valid_values), info = glue::glue("'{column_name}' contains invalid values."))
  })
}

# Function to validate numerical ranges
validate_range <- function(column, min_val, max_val, column_name) {
  test_that(glue::glue("{column_name} values are within the expected range"), {
    expect_true(all(column >= min_val & column <= max_val), info = glue::glue("'{column_name}' values are out of range."))
  })
}

# Test 1: Depression severity scale (DEPDVPHQ)
validate_range(simulated_data$DEPDVPHQ, 0, 27, "DEPDVPHQ")

# Test 2: Age group (DHHGAGE)
validate_categories(simulated_data$DHHGAGE, c(1, 2, 3, 4, 5), "DHHGAGE")

# Test 3: Marital status (DHHGMS)
validate_categories(simulated_data$DHHGMS, c(1, 2), "DHHGMS")

# Test 4: Household income (INCDGHH)
validate_categories(simulated_data$INCDGHH, c(1, 2, 3), "INCDGHH")

# Test 5: Education level (EHG2DVH3)
validate_categories(simulated_data$EHG2DVH3, c(1, 2, 3), "EHG2DVH3")

# Test 6: Weekly alcohol consumption (ALCDVTTM)
validate_range(simulated_data$ALCDVTTM, 0, 50, "ALCDVTTM")

# Final check: Ensure no missing values
test_that("Dataset contains no missing values", {
  expect_true(all(!is.na(simulated_data)), info = "Dataset contains missing values.")
})
