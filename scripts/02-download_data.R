#### Preamble ####
# Purpose: Download the raw data sets.
# Author: Xinqi Yue
# Date: 3 Dec 2024
# Contact: xinqi.yue@mail.utoronto.ca
# License: MIT
# Pre-requisites:
#   - The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `exchange_rate_analysis` rproj


#### Workspace setup ####
library(tidyverse)

#### Download data ####
weekly_bank_rate <- read_csv("https://www.bankofcanada.ca/stats/results//csv?rangeType=dates&ByDate_frequency=daily&lP=lookup_canadian_interest.php&sR=2014-11-27&se=V80691310&dF=2021-01-01&dT=2024-11-26", skip = 10)
daily_exchange_rate <- read_csv("https://www.bankofcanada.ca/valet/observations/group/FX_RATES_DAILY/csv?start_date=2017-01-03", skip = 39)
weekly_BCPI <- read_csv("https://www.bankofcanada.ca/valet/observations/group/BCPI_WEEKLY/csv?start_date=1972-01-01", skip = 20)

#### Save data ####
write_csv(weekly_bank_rate, "data/01-raw_data/weekly_bank_rate_raw_data.csv")
write_csv(daily_exchange_rate, "data/01-raw_data/daily_exchange_rate_raw_data.csv")
write_csv(weekly_BCPI, "data/01-raw_data/weekly_BCPI_raw_data.csv")
