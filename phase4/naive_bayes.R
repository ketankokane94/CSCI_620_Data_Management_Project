# Run dataPreprocessing.R before this
# Tree generation

install.packages("e1071")

library(party)
library(e1071)

library(rpart)
library(rpart.plot)

# Load test data

test_data = read.table("adult.test",header = TRUE,sep = ",",na.strings = " ?")
dim(test_data)

test_data = subset(test_data, select = -c(fnlwgt,race,native.country) )
dim(test_data)

# Build Naive Bayes Model

model <- naiveBayes(prediction ~ ., data = dataset)

print(model)

# Test model on training data

vals_predicted <- predict(model, newdata = dataset)

print(vals_predicted)

confMatrix <- table(dataset$prediction, vals_predicted)

# Prints confusion matrix indicating number of values correctly predicted and not

print(confMatrix)

accuracy <- sum(diag(confMatrix))/sum(confMatrix)

print(accuracy)

# Test model on test data

vals_predicted <- predict(model, newdata = test_data)

print(vals_predicted)

confMatrix <- table(test_data$prediction, vals_predicted)

# Prints confusion matrix indicating number of values correctly predicted and not

print(confMatrix)

accuracy <- sum(diag(confMatrix))/sum(confMatrix)

print(accuracy)