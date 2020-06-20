# Run dataPreprocessing.R and test_dataPreprocessing.R before this

# Tree generation

#install.packages("randomForest")

library(party)
library(randomForest)
library(ggplot2)
library(rpart)
library(rpart.plot)

# Load test data

#test_data = read.table("adult.test",header = TRUE,sep = ",",na.strings = " ?")
#dim(test_data)

#test_data = subset(test_data, select = -c(fnlwgt,race,native.country) )
#dim(test_data)

# On training data

dtree <- randomForest(prediction ~ ., data = dataset)
dtree
# Prints confusion matrix while learning with other key details of process.
#print(dtree)

val_predicted <- predict(dtree, dataset, type = 'response')

#print(val_predicted)

confMatrix <- as.data.frame(table(dataset$prediction, val_predicted))

print(confMatrix)
names(confMatrix)
ggplot(data =  confMatrix, mapping = aes(x = Var1, y = val_predicted)) +
  geom_tile(aes(fill = Freq), colour = "white") +
  geom_text(aes(label = sprintf("%1.0f", Freq)), vjust = 1) +
  scale_fill_gradient(low = "blue",
                      high = "red",
                      trans = "log")
# Plots error rate with respect to increase in number of trees generated
plot(dtree)

accuracy <- sum(diag(confMatrix))/sum(confMatrix)

print(accuracy)

# On testing data
levels(test_data$workclass)<-levels(dataset$workclass)
levels(test_data$occupation)<-levels(dataset$occupation)
val_predicted <- predict(dtree, test_data, type = 'response')

#print(val_predicted)

confMatrix <- as.data.frame(table(test_data$prediction, val_predicted))

print(confMatrix)
ggplot(data =  confMatrix, mapping = aes(x = Var1, y = val_predicted)) +
  ggtitle("Random Forrest Testing set confusion matrix")+
  geom_tile(aes(fill = Freq), colour = "white") +
  xlab("Actual class label")+
  ylab("Predicted class label")+
  geom_text(aes(label = sprintf("%1.0f", Freq)), vjust = 1) +
  scale_fill_gradient(low = "blue",
                      high = "red",
                      trans = "log")
# Plots error rate with respect to increase in number of trees generated
plot(dtree)

accuracy <- sum(diag(confMatrix))/sum(confMatrix)

print(accuracy)
