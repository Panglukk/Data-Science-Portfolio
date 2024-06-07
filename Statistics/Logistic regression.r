# การ converse num to character
mtcars$am <- factor(mtcars$am, levels = c(0,1), labels = c("auto", "manual"))

# การนับจำนวน auto, manual
table(mtcars$am)

# 1. split data
set.seed(42)
n <- nrow(mtcars)
id <- sample(1:n, size = n*0.7)
train_data <- mtcars[id, ]
test_data <- mtcars[-id, ]

# 2. train data
logit_model <- glm(am ~ mpg, data = train_data, family = "binomial")
pred_train <- predict(logit_model, type = "response")
train_data$pred <- if_else(pred_train >=0.5, "manual", "auto")
mean(train_data$am == train_data$pred) 

# 3. test data
pred_test <- predict(logit_model, newdata = test_data, type = "response")
test_data$pred <- if_else(pred_test >= 0.5, "manual", "auto")
mean(test_data$am == test_data$pred)

# Result
mean_train = 0.8181818
mean_test = 0.6
