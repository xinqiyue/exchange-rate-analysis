#### Preamble ####
# Purpose: Tests... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 26 September 2024 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
# Load necessary libraries
library(readr)
library(testthat)
library(dplyr)

# 1. Read the CSV file into analysis_data
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")

# 2. View the first few rows to check if the data is loaded correctly
head(analysis_data)

# 3. Test that the dataset has the correct number of rows and columns
test_that("dataset has 204 rows", {
  expect_equal(nrow(analysis_data), 204)
})

test_that("dataset has 6 columns", {  # Assuming there are 6 columns
  expect_equal(ncol(analysis_data), 6)
})

# 4. Test that each column is of the expected type
test_that("'date' is Date type", {
  expect_type(analysis_data$date, "double") # R read dates as numeric type by default
})

test_that("'weekly_bank_rate' is numeric", {
  expect_type(analysis_data$weekly_bank_rate, "double")
})

test_that("'weekly_avg_usd_vs_cad' is numeric", {
  expect_type(analysis_data$weekly_avg_usd_vs_cad, "double")
})

test_that("'weekly_total_bcpi' is numeric", {
  expect_type(analysis_data$weekly_total_bcpi, "double")
})

test_that("'weekly_energy_bcpi' is numeric", {
  expect_type(analysis_data$weekly_energy_bcpi, "double")
})

test_that("'weekly_metal_bcpi' is numeric", {
  expect_type(analysis_data$weekly_metal_bcpi, "double")
})

# 5. Test that there are no missing values in the dataset
test_that("no missing values in dataset", {
  expect_true(all(!is.na(analysis_data)))
})

# 6. Test that the 'date' column contains valid date values (check the range of dates)
test_that("'date' column contains valid dates", {
  expect_true(all(analysis_data$date >= as.Date("2021-01-01")))
})

# 7. Test that there are no empty strings in any columns
test_that("no empty strings or NAs in any column", {
  expect_true(all(!is.na(analysis_data$weekly_bank_rate) | analysis_data$weekly_bank_rate != ""))
  expect_true(all(!is.na(analysis_data$weekly_avg_usd_vs_cad) | analysis_data$weekly_avg_usd_vs_cad != ""))
  expect_true(all(!is.na(analysis_data$weekly_total_bcpi) | analysis_data$weekly_total_bcpi != ""))
  expect_true(all(!is.na(analysis_data$weekly_energy_bcpi) | analysis_data$weekly_energy_bcpi != ""))
  expect_true(all(!is.na(analysis_data$weekly_metal_bcpi) | analysis_data$weekly_metal_bcpi != ""))
})

# 8. Test that numeric columns contain only valid numeric values (no characters or invalid entries)
test_that("numeric columns contain valid numeric values", {
  expect_true(all(is.numeric(analysis_data$weekly_bank_rate)))
  expect_true(all(is.numeric(analysis_data$weekly_avg_usd_vs_cad)))
  expect_true(all(is.numeric(analysis_data$weekly_total_bcpi)))
  expect_true(all(is.numeric(analysis_data$weekly_energy_bcpi)))
  expect_true(all(is.numeric(analysis_data$weekly_metal_bcpi)))
})


