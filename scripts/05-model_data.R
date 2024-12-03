#### Preamble ####
# Purpose:  fits two linear regression models on the dataset, evaluates their 
#         performance using RMSE and MAE on the test set, and saves the models 
#         to disk for future use.
# Author: Xinqi Yue
# Date: 3 Dec 2024
# Contact: xinqi.yue@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - The `tidyverse` package must be installed
#   - 02-download_data.R must been run first
#   - 03-clean_data.R must been run Secondly
# Any other information needed? Make sure you are in the `exchange_rate_analysis` rproj

#### Workspace setup ####
library(tidyverse)

#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

### Model data ####
# Fit a linear regression model
model <- lm(weekly_avg_usd_vs_cad ~ weekly_bank_rate + weekly_metal_bcpi + weekly_energy_bcpi, data = analysis_data)
model2 <- lm(weekly_avg_usd_vs_cad ~ weekly_bank_rate + weekly_total_bcpi, data = analysis_data)

set.seed(886) # Set the random seed to ensure reproducible results
train_indices <- sample(1:nrow(analysis_data), size = 0.8 * nrow(analysis_data))
train_data <- analysis_data[train_indices, ]
test_data <- analysis_data[-train_indices, ]

# Fit the model on the training set
model_train1 <- lm(weekly_avg_usd_vs_cad ~ weekly_bank_rate + weekly_metal_bcpi + weekly_energy_bcpi, data = train_data)
model_train2 <- lm(weekly_avg_usd_vs_cad ~ weekly_bank_rate + weekly_total_bcpi, data = train_data)

# Make predictions on the test set
test_predictions1 <- predict(model_train1, newdata = test_data)
test_predictions2 <- predict(model_train2, newdata = test_data)

# Calculating RMSE and MAE
rmse1 <- sqrt(mean((test_data$weekly_avg_usd_vs_cad - test_predictions1)^2))
mae1 <- mean(abs(test_data$weekly_avg_usd_vs_cad - test_predictions1))

rmse2 <- sqrt(mean((test_data$weekly_avg_usd_vs_cad - test_predictions2)^2))
mae2 <- mean(abs(test_data$weekly_avg_usd_vs_cad - test_predictions2))

# Creating tabular data
results <- data.frame(
  Model = c("First Model", "Second Model"),
  RMSE = c(rmse1, rmse2),
  MAE = c(mae1, mae2)
)


#### Save model ####
# Save the model to disk
saveRDS(model, "models/weekly_total_model.rds")
saveRDS(model2, "models/weekly_partial_model.rds")
saveRDS(model_train1, "models/weekly_total_train_model.rds")
saveRDS(model_train2, "models/weekly_partial_train_model.rds")