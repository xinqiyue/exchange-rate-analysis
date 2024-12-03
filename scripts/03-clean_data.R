#### Preamble ####
# Purpose: clean and preprocess three raw datasets (weekly bank rate data, 
#         daily exchange rate data, and weekly BCPI data), by standardizing 
#         column names, removing missing values, aggregating data where 
#         necessary (e.g., converting daily exchange rates to weekly averages), 
#         and merging the datasets into a single cleaned data frame. The final
#         cleaned dataset is then saved in Parquet format for analysis.
# Author: Xinqi Yue
# Date: 3 Dec 2024
# Contact: xinqi.yue@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - The `tidyverse`, `lubridate` and `arrow` package must be installed
#   - 02-download_data.R must been run first
# Any other information needed? Make sure you are in the `exchange_rate_analysis` rproj

#### Workspace setup ####
library(tidyverse)
library(lubridate)
library(arrow)

#### Clean data ####
weekly_bank_rate_data <- read_csv("data/01-raw_data/weekly_bank_rate_raw_data.csv")
daily_exchange_rate_data <- read_csv("data/01-raw_data/daily_exchange_rate_raw_data.csv")
weekly_BCPI_data <- read_csv("data/01-raw_data/weekly_BCPI_raw_data.csv")

# 1. Clean weekly_bank_rate_data
weekly_bank_rate_data <- weekly_bank_rate_data |>
  janitor::clean_names() |> # Standardize column names (lowercase, snake_case)
  tidyr::drop_na() |> # Remove rows with missing values
  rename(weekly_bank_rate = v80691310) |> # Rename column for clarity
  mutate(date = ymd(date)) # Convert the date column to Date format

# 2. Clean and aggregate daily_exchange_rate_data to weekly averages
weekly_exchange_rate_data <- daily_exchange_rate_data |>
  janitor::clean_names() |> # Standardize column names
  select(date, fxusdcad) |> # Keep only date and FXUSDCAD columns
  tidyr::drop_na() |> # Remove rows with missing values
  mutate(date = ymd(date)) |> # Convert the date column to Date format
  filter(date > as.Date("2021-01-01")) |> # Filter rows after January 1, 2021
  rename(usd_vs_cad = fxusdcad) |> # Rename column for clarity
  mutate(
    date = date + days(3 - wday(date, week_start = 1)) # Group by week
  ) |>
  group_by(date) |>  # Group by the new weekly column
  summarise(weekly_avg_usd_vs_cad = mean(usd_vs_cad, na.rm = TRUE)) |> # Calculate weekly averages
  ungroup() # Ungroup to finalize the data frame

# 3. Clean weekly_BCPI_data and select specific columns
weekly_BCPI_data <- weekly_BCPI_data |> 
  janitor::clean_names() |> # Standardize column names
  select(date, w_bcpi, w_ener, w_mtls) |> # Keep only specified columns
  tidyr::drop_na() |> # Remove rows with missing values
  mutate(date = ymd(date)) |> # Convert the date column to Date format
  filter(date > as.Date("2021-01-01")) |> # Filter rows after January 1, 2021
  filter(date < as.Date("2024-12-01")) |>
  rename(weekly_total_bcpi = w_bcpi, 
         weekly_energy_bcpi = w_ener, 
         weekly_metal_bcpi = w_mtls)

# 4. Combine all datasets by date
cleaned_data <- weekly_bank_rate_data |>
  full_join(weekly_exchange_rate_data, by = "date") |> # Merge with exchange rate data
  full_join(weekly_BCPI_data, by = "date") # Merge with BCPI data

# Clean the combined data
cleaned_data <- cleaned_data |> 
  tidyr::drop_na() # Remove rows with missing values

# Convert columns to numeric and remove rows with NA after conversion
cleaned_data$weekly_total_bcpi <- as.numeric(cleaned_data$weekly_total_bcpi)
cleaned_data$weekly_energy_bcpi <- as.numeric(cleaned_data$weekly_energy_bcpi)
cleaned_data$weekly_metal_bcpi <- as.numeric(cleaned_data$weekly_metal_bcpi)

# Remove rows where any of the numeric columns are NA (after conversion)
cleaned_data <- cleaned_data |> 
  filter(
    !is.na(weekly_total_bcpi) & 
      !is.na(weekly_energy_bcpi) & 
      !is.na(weekly_metal_bcpi)
  )

#### Save data ####
write_parquet(cleaned_data, "data/02-analysis_data/analysis_data.parquet")
