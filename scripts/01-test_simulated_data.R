#### Preamble ####
# Purpose: load and validate a simulated dataset, ensuring it meets specific
#          criteria such as correct number of rows and columns, no missing or
#          empty values, and that the date column is in weekly intervals.
# Author: Xinqi Yue
# Date: 3 Dec 2024
# Contact: xinqi.yue@mail.utoronto.ca
# License: MIT
# Pre-requisites:
#   - The `tidyverse` package must be installed
#   - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `exchange_rate_analysis` rproj

#### Workspace setup ####
library(tidyverse)

simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Test if the data was successfully loaded
if (exists("simulated_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}


#### Test data ####

# Check if the dataset has 151 rows
if (nrow(simulated_data) == 105) {
  message("Test Passed: The dataset has 105 rows.")
} else {
  stop("Test Failed: The dataset does not have 151 rows.")
}

# Check if the dataset has 6 columns
if (ncol(simulated_data) == 6) {
  message("Test Passed: The dataset has 6 columns.")
} else {
  stop("Test Failed: The dataset does not have 6 columns.")
}

# Check if there are no empty strings or NA values in the relevant columns
if (all(!is.na(simulated_data$Date) & simulated_data$Date != "" # Check for missing values and empty strings in 'Date'
  ,
  na.rm = TRUE
) &
  all(!is.na(simulated_data$USD_CAD_Exchange_Rate) & simulated_data$USD_CAD_Exchange_Rate != "" # 'USD_CAD_Exchange_Rate'
    ,
    na.rm = TRUE
  ) &
  all(!is.na(simulated_data$Interest_Rate) & simulated_data$Interest_Rate != "" # 'Interest_Rate'
    ,
    na.rm = TRUE
  ) &
  all(!is.na(simulated_data$BCPI) & simulated_data$BCPI != "" # 'BCPI'
    ,
    na.rm = TRUE
  ) &
  all(!is.na(simulated_data$Energy_Index) & simulated_data$Energy_Index != "" # 'Energy_Index'
    ,
    na.rm = TRUE
  ) &
  all(!is.na(simulated_data$Metals_Index) & simulated_data$Metals_Index != "" # 'Metals_Index'
    ,
    na.rm = TRUE
  )) { # 'Metals_Index'
  message("Test Passed: There are no empty strings or NA values in the columns.")
} else {
  stop("Test Failed: There are empty strings or NA values in one or more columns.")
}

# Convert date columns to Date type
simulated_data$Date <- as.Date(simulated_data$Date)

# Calculate the difference in dates (in days)
date_diff <- diff(simulated_data$Date)

# Check if the date difference is 7 days, excluding the first row (since it has no previous row to compare to)
if (all(date_diff == 7, na.rm = TRUE)) {
  message("Test passed: Dates are weekly.")
} else {
  stop("Test failed: Date is not weekly.")
}
