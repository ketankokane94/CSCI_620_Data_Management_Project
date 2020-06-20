# Run dataPreprocessing.R and test_dataPreprocessing.R before this

# Tree generation

library(rpart)
library(rpart.plot)

dtree <- rpart(prediction ~ ., data = dataset, method = 'class', model = TRUE)

rpart.plot(dtree)

# predict using tree

# Read test data into a data frame
#test_data = read.table("adult.test",header = TRUE,sep = ",",na.strings = " ?")
#dim(test_data)

#test_data = subset(test_data, select = -c(fnlwgt,race,native.country) )
#dim(test_data)

#length(dataset$prediction)

#class(val_predicted)

# Check accuracy for prediction on training data

val_predicted <- predict(dtree, dataset, type = "class")

#print(val_predicted)

confMatrix <- as.data.frame(table(dataset$prediction, val_predicted))
names(confMatrix)
print(confMatrix)
ggplot(data =  confMatrix, mapping = aes(x = Var1, y = val_predicted)) +
  ggtitle("Decision Tree Training set confusion matrix")+
  geom_tile(aes(fill = Freq), colour = "white") +
  xlab("Actual class label")+
  ylab("Predicted class label")+
  geom_text(aes(label = sprintf("%1.0f", Freq)), vjust = 1) +
  scale_fill_gradient(low = "blue",
                      high = "red",
                      trans = "log")+
  theme(legend.text = element_text( size = 15, hjust = 3, vjust = 3, face = 'bold'))
   
accuracy <- sum(diag(confMatrix))/sum(confMatrix)

print(accuracy)

# Check accuracy for prediction on training data

val_predicted <- predict(dtree, test_data, type = "class")

#print(val_predicted)

confMatrix <- as.data.frame(table(test_data$prediction, val_predicted))

ggplot(data =  confMatrix, mapping = aes(x = Var1, y = val_predicted)) +
  ggtitle("Decision Tree Testing set confusion matrix")+
  geom_tile(aes(fill = Freq), colour = "white") +
  xlab("Actual class label")+
  ylab("Predicted class label")+
  geom_text(aes(label = sprintf("%1.0f", Freq)), vjust = 1) +
  scale_fill_gradient(low = "blue",
                      high = "red",
                      trans = "log")
print(confMatrix)
confMatrix <-table(test_data$prediction, val_predicted)

accuracy <- sum(diag(confMatrix))/sum(confMatrix)

print(accuracy)
