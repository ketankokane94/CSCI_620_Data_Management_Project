# Run dataPreprocessing.R and test_dataPreprocessing.R before this

# Model generation

#install.packages("e1071")

library(party)
library(e1071)
library(tidyverse)
library(rpart)
library(rpart.plot)

# Load test data

#test_data = read.table("adult.test",header = TRUE,sep = ",",na.strings = " ?")
#dim(test_data)

#test_data = subset(test_data, select = -c(fnlwgt,race,native.country) )
#dim(test_data)

# Build Naive Bayes Model

model <- naiveBayes(prediction ~ ., data = dataset)

print(model)

# Test model on training data

vals_predicted <- predict(model, newdata = dataset)

print(vals_predicted[1])
vals_predicted[1]
confMatrix <- table(dataset$prediction, vals_predicted)

# Prints confusion matrix indicating number of values correctly predicted and not

print(confMatrix)

accuracy <- sum(diag(confMatrix))/sum(confMatrix)

print(accuracy)

# Test model on test data

vals_predicted <- predict(model, newdata = test_data)

#print(vals_predicted)

confMatrix <- as.data.frame(table(test_data$prediction, vals_predicted))
confMatrix
ggplot(data =  confMatrix, mapping = aes(x = Var1, y = vals_predicted)) +
  ggtitle("Naive Bayes Testing set confusion matrix")+
  geom_tile(aes(fill = Freq), colour = "white") +
  xlab("Actual class label")+
  ylab("Predicted class label")+
  geom_text(aes(label = sprintf("%1.0f", Freq)), vjust = 1) +
  scale_fill_gradient(low = "blue",
                      high = "red",
                      trans = "log")
# Prints confusion matrix indicating number of values correctly predicted and not

print(confMatrix)

accuracy <- sum(diag(confMatrix))/sum(confMatrix)

print(accuracy)