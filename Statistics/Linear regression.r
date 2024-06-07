# 1. Split data
set.seed(42)
n <- nrow(mtcars)
id <- sample(1:n, size = n*0.8) 
train_data <- mtcars[id, ]
test_data <- mtcars[-id, ] 

# 2. Train_model
model1 <- lm(mpg ~ hp, wt, data = train_data)
pred_train <- predict(model1)
error_train <- train_data$mpg - pred_train
(rmse_train <- sqrt(mean(error_train**2)))

# 3. Test_model
pred_test <- predict(model1, newdata = test_data)
error_test <- test_data$mpg - pred_test
rmse_test <- sqrt(mean(error_test**2))

# Print result
cat("RMSE train:", rmse_train,
    "\nRMSE test:", rmse_test)

# result
> cat("RMSE train:", rmse_train,
+     "\nRMSE test:", rmse_test)
RMSE train: 6.06463 
RMSE test: 3.435439 
