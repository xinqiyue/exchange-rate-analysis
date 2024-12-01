#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

### Model data ####
# Fit a linear regression model
model <- lm(weekly_avg_usd_vs_cad ~ weekly_bank_rate + weekly_metal_bcpi + weekly_energy_bcpi, data = analysis_data)
model2 <- lm(weekly_avg_usd_vs_cad ~ weekly_bank_rate + weekly_total_bcpi, data = analysis_data)

set.seed(886) # 设置随机种子以确保结果可复现
train_indices <- sample(1:nrow(analysis_data), size = 0.8 * nrow(analysis_data))
train_data <- analysis_data[train_indices, ]
test_data <- analysis_data[-train_indices, ]

# 在训练集上拟合模型
model_train1 <- lm(weekly_avg_usd_vs_cad ~ weekly_bank_rate + weekly_metal_bcpi + weekly_energy_bcpi, data = train_data)
model_train2 <- lm(weekly_avg_usd_vs_cad ~ weekly_bank_rate + weekly_total_bcpi, data = train_data)

# 在测试集上进行预测
test_predictions1 <- predict(model_train1, newdata = test_data)
test_predictions2 <- predict(model_train2, newdata = test_data)

# 计算RMSE和MAE
rmse1 <- sqrt(mean((test_data$weekly_avg_usd_vs_cad - test_predictions1)^2))
mae1 <- mean(abs(test_data$weekly_avg_usd_vs_cad - test_predictions1))

rmse2 <- sqrt(mean((test_data$weekly_avg_usd_vs_cad - test_predictions2)^2))
mae2 <- mean(abs(test_data$weekly_avg_usd_vs_cad - test_predictions2))

# 创建表格数据
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