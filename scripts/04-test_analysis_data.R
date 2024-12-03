#### Preamble ####
# Purpose: Tests the structure and validity of the cleaned dataset
# Author: Jiaxuan Song
# Date: 24 November 2024
# Contact: jiaxuan.song@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - The `tidyverse` and `arrow` packages must be installed and loaded.
# - 02-clean_data.R must have been run to produce the cleaned data.



# Load necessary libraries
library(tidyverse)
library(arrow)
library(testthat)

# Load the data
cleaned_data <- read_parquet("data/02-analysis_data/cchs_cleaned_data.parquet")

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

# Example tests based on the dataset

# Test 1: Age group (DHHGAGE) should only include 1 to 5, NA not allowed
test_that("DHHGAGE contains only valid categories (1-5) with no NA values", {
  expect_true(all(cleaned_data$DHHGAGE %in% 1:5, na.rm = TRUE), info = "DHHGAGE contains invalid categories.")
})

# Test 2: Marital status (DHHGMS) should only include 1 or 2, NA allowed
test_that("DHHGMS contains only valid categories (1, 2) with NA allowed", {
  expect_true(all(na.omit(cleaned_data$DHHGMS) %in% c(1, 2)), info = "DHHGMS contains invalid categories.")
})

# Test 3: Total household income (INCDGHH) should only include 1 to 5, NA allowed
test_that("INCDGHH contains only valid categories (1-5) with NA allowed", {
  expect_true(all(na.omit(cleaned_data$INCDGHH) %in% 1:5), info = "INCDGHH contains invalid categories.")
})

# Test 4: Education level (EHG2DVH3) should be between 1 and 3, NA allowed
test_that("EHG2DVH3 contains only valid categories (1-3) with NA allowed", {
  expect_true(all(na.omit(cleaned_data$EHG2DVH3) %in% 1:3), info = "EHG2DVH3 contains invalid categories.")
})

# Test 5: Weekly alcohol consumption (ALCDVTTM) should be between 0 and 140, NA allowed
test_that("ALCDVTTM values are within range 0-140 with NA allowed", {
  expect_true(all(cleaned_data$ALCDVTTM >= 0 & cleaned_data$ALCDVTTM <= 140, na.rm = TRUE), info = "ALCDVTTM contains invalid values.")
})

# Test 6: Check for missing values in required columns (DHHGAGE, DHHGMS, INCDGHH, EHG2DVH3, ALCDVTTM)
required_columns <- c("DHHGAGE", "DHHGMS", "INCDGHH", "EHG2DVH3", "ALCDVTTM")
for (col in required_columns) {
  test_that(glue::glue("{col} contains no missing values"), {
    expect_true(all(!is.na(cleaned_data[[col]])), info = glue::glue("{col} contains missing values."))
  })
}
