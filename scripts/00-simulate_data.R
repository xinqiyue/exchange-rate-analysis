#### Preamble ####
# Purpose: Simulates a dataset of Australian electoral divisions, including the 
  #state and party that won each division.
# Author: Rohan Alexander
# Date: 26 September 2024
# Contact: rohan.alexander@utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(lubridate)
library(tibble)

set.seed(687)


#### Simulate data ####
# Set date range (weekly data)
date_range <- seq.Date(from = as.Date("2022-01-01"), to = as.Date("2023-12-31"), by = "week")

#Simulated exchange rate data (assuming fluctuations are between 1.2 and 1.4)
usd_cad_rate <- runif(length(date_range), min = 1.2, max = 1.4)

#Simulated interest rate data (assumed to be between 0.5% and 3%)
interest_rate <- runif(length(date_range), min = 0.5, max = 3.0)

# Simulate BCPI data (assumed to be between 90 and 110)
bcpi <- runif(length(date_range), min = 90, max = 110)

# Simulate the energy price index (assumed to be between 80 and 120)
ener <- runif(length(date_range), min = 80, max = 120)

# Simulate the metal price index (assumed to be between 85 and 115)
mtls <- runif(length(date_range), min = 85, max = 115)

# Create a data frame
simulated_data <- tibble(
  Date = date_range,
  USD_CAD_Exchange_Rate = usd_cad_rate,
  Interest_Rate = interest_rate,
  BCPI = bcpi,
  Energy_Index = ener,
  Metals_Index = mtls
)

#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")
