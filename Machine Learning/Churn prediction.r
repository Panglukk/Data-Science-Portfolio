# ข้อที่ 1
# split data
train_test_split <- function(data, size = 0.8) {
  set.seed(42)
  n <- nrow(data)
  id <-sample(1:n, size*n)
  train_df <- data[id, ]
  test_df <- data[-id, ]
  return(list(train_df, test_df))
}

prep_df <- train_test_split(churn, size = 0.8)

prep_df[[1]]
prep_df[[2]]

ctrl <- trainControl(method = "cv", 
                     number = 10)

# train model 
model <- train(churn ~ totaldayminutes + totaleveminutes + totalevecharge + totalnightminutes,
               data = prep_df[[1]],
               method = "glm",
               trControl = ctrl)

# score model (predict)
pred_churn <- predict(model, newdata = prep_df[[2]])

# evaluate
acc <- mean(pred_churn == prep_df[[2]]$churn)


# result
> model
Generalized Linear Model 

4000 samples
   4 predictor
   2 classes: 'No', 'Yes' 

No pre-processing
Resampling: Cross-Validated (10 fold) 
Summary of sample sizes: 3600, 3600, 3600, 3600, 3600, 3600, ... 
Resampling results:

  Accuracy   Kappa     
  0.8612498  0.02097273

> acc
[1] 0.859

----------------------------------------------------------------------

# ข้อที่ 2 
library(tidyverse)
library(caret)
library(mlbench)
library(MLmetrics)

churn <- read_csv("churn.csv")

glimpse(churn)
mean(complete.cases(churn))

df <- churn %>%
  select(totaldayminutes, 
         totaleveminutes, 
         totalevecharge, 
         totalnightminutes,
         churn)


# 1. split data
set.seed(42)
n <- nrow(df)
id <- sample(1:n, size = 0.8*n)
train_df <- df[id, ]
test_df <- df[-id, ]

# normalization
transform <- preProcess(train_df, 
                        method = c("range"))

train_df_z <- predict(transform, train_df)
test_df_z <- predict(transform, test_df)


# 2. train
set.seed(42)
ctrl <- trainControl(method = "cv",
                     number = 5,
                     summaryFunction = prSummary,
                     classProbs = TRUE)

k_grid <- data.frame(k = 9)

logis_model <- train(churn ~ .,
                     data = train_df_z,
                     method = "knn",
                     metric = "AUC",
                     trControl = ctrl,
                     tuneGrid = k_grid)

# 3. score
p <- predict(logis_model, newdata = test_df_z)

# 4. evaluate
mean(p == test_df_z$churn)

test_df_z$churn <- as.factor(test_df_z$churn)

confusionMatrix(p, 
		test_df_z$churn, 
		positive = "Yes",
                mode = "prec_recall")
