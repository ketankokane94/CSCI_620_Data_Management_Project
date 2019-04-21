# Run dataPreprocessing.R and test_dataPreprocessing.R before this

# Tree generation

#install.packages("randomForest")

library(party)
library(randomForest)

library(rpart)
library(rpart.plot)

# Load test data

#test_data = read.table("adult.test",header = TRUE,sep = ",",na.strings = " ?")
#dim(test_data)

#test_data = subset(test_data, select = -c(fnlwgt,race,native.country) )
#dim(test_data)

# On training data

dtree <- randomForest(prediction ~ ., data = dataset)

# Prints confusion matrix while learning with other key details of process.
#print(dtree)

val_predicted <- predict(dtree, dataset, type = 'response')

#print(val_predicted)

confMatrix <- table(dataset$prediction, val_predicted)

print(confMatrix)

# Plots error rate with respect to increase in number of trees generated
plot(dtree)

accuracy <- sum(diag(confMatrix))/sum(confMatrix)

print(accuracy)

# On testing data

val_predicted <- predict(dtree, test_data, type = 'response')

#print(val_predicted)

confMatrix <- table(test_data$prediction, val_predicted)

print(confMatrix)

# Plots error rate with respect to increase in number of trees generated
plot(dtree)

accuracy <- sum(diag(confMatrix))/sum(confMatrix)

print(accuracy)
