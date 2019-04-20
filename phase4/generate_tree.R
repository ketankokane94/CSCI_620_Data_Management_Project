# Run dataPreprocessing.R before this

# Tree generation

library(rpart)
library(rpart.plot)

dtree <- rpart(prediction ~ ., data = dataset, method = 'class', model = TRUE)

rpart.plot(dtree)

# predict using tree

# Read test data into a data frame
test_data = read.table("adult.test",header = TRUE,sep = ",",na.strings = " ?")
dim(test_data)

test_data = subset(test_data, select = -c(fnlwgt,race,native.country) )
dim(test_data)

val_predicted <- predict(dtree, dataset, type = "class")

print(val_predicted)

#length(dataset$prediction)

#class(val_predicted)

# Check accuracy for prediction on training data

confMatrix <- table(dataset$prediction, val_predicted)

print(confMatrix)

accuracy <- sum(diag(confMatrix))/sum(confMatrix)

print(accuracy)

# Check accuracy for prediction on training data

confMatrix <- table(test_data$prediction, val_predicted)

print(confMatrix)

accuracy <- sum(diag(confMatrix))/sum(confMatrix)

print(accuracy)
