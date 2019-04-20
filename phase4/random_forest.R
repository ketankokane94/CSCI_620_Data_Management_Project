# Run dataPreprocessing.R before this
# Tree generation

#install.packages("randomForest")

library(party)
library(randomForest)

library(rpart)
library(rpart.plot)

# Load test data

test_data = read.table("adult.test",header = TRUE,sep = ",",na.strings = " ?")
dim(test_data)

test_data = subset(test_data, select = -c(fnlwgt,race,native.country) )
dim(test_data)

# On training data

dtree <- randomForest(prediction ~ ., data = dataset)

# Prints confusion matrix
print(dtree)

val_predicted <- predict(dtree, test_data, type = 'class')

#accuracy <- sum(diag(dtree))/sum(dtree)

# Plots error rate with respect to increase in number of trees generated
plot(dtree)
