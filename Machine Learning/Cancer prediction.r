# Update data file
data <- read_csv("data.csv")

# Select feature
data %>%
  group_by(data) %>%
  summarise(mean(#each feature))

# 1. split data
set.seed(42)
n <- nrow(data)
id <- sample(1:n, size = 0.8*n)
train_data <- data[id, ]
test_data <- data[-id, ]

# 1.1 normalization
transform <- preProcess(train_data, 
                        method = c("range"))

train_tran <- predict(transform, train_data)
test_tran <- predict(transform, test_data)

# 2. train
model <- train(diagnosis ~ perimeter_mean + area_mean + area_se + perimeter_worst + area_worst,
               data = train_tran,
               method = "glm")

# 3. score
pred_dia <- predict(model, newdata = test_tran)

# 4. evaluate
mean(test_tran$diagnosis == pred_dia)

test_tran$diagnosis <- as.factor(test_tran$diagnosis)

# Result
    > model
Generalized Linear Model 

454 samples
  5 predictor
  2 classes: 'B', 'M' 

No pre-processing
Resampling: Bootstrapped (25 reps) 
Summary of sample sizes: 454, 454, 454, 454, 454, 454, ... 
Resampling results:

  Accuracy   Kappa    
  0.9292155  0.8511044

  Confusion Matrix and Statistics

          Reference
Prediction  B  M
         B 79  3
         M  1 31
                                          
               Accuracy : 0.9649          
                 95% CI : (0.9126, 0.9904)
    No Information Rate : 0.7018          
    P-Value [Acc > NIR] : 6.927e-13       
                                          
                  Kappa : 0.9147          
                                          
 Mcnemar's Test P-Value : 0.6171          
                                          
              Precision : 0.9688          
                 Recall : 0.9118          
                     F1 : 0.9394          
             Prevalence : 0.2982          
         Detection Rate : 0.2719          
   Detection Prevalence : 0.2807          
      Balanced Accuracy : 0.9496          
                                          
       'Positive' Class : M 

confusionMatrix(pred_dia,
                test_tran$diagnosis,
                positive = "M",
                mode = "prec_recall")
