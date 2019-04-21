#install.packages("naniar")
library(naniar)
library(tidyverse)
library(GoodmanKruskal)
library(randomForest)
library(ggplot2)
library(rpart)
library(rpart.plot)
library(party)
library(e1071)

# Read the data into a data frame
dataset = read.table("adult.data",header = TRUE,sep = ",",na.strings = " ?")
dim(dataset)
attach(dataset)
#Based on the initial analysis, the columns fnlwgt,race,capital.loss,native.country 
#are dropped. Values stored in this column are skewed and do not contribute to any useful information

#fnlwgt is an attribute used in data generation during taking the census, it tells the instance belongs to which sample, 
#and provides no use for the defined tasks

#Skewed graph for Race attribute
ggplot(data.frame(dataset)) +
  geom_bar(aes(x=race,fill = as.factor(prediction)))+ ggtitle(label = "Race-Prediction Relationship")+
  labs(fill = "Prediction")  + xlab("Race")+ylab("Count")+
  theme(axis.text.x=element_text(color="black", size=8),
        axis.ticks.x=element_blank())  

#Skewed graph for Native.countries attribute
ggplot(data.frame(dataset)) +
  geom_bar(aes(x=native.country,fill = as.factor(prediction)))+ ggtitle(label = "Prediction-Native Countries Relationship ")+
  labs(fill = "Prediction")  + xlab("Native Countries")+ylab("Count")+
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

#Hence we dropped the attribute fnlwgt, race and native.country
dataset = subset(dataset, select = -c(fnlwgt,race,native.country) )
dim(dataset)

#As Education number and the "education" attribute are highly correlated, both signify the same 
#thing. Hence "education.num" is dropped
varset1<- c("education.num","education")
datasetFrame1<- subset(dataset, select = varset1)
GKmatrix1<- GKtauDataframe(datasetFrame1)
plot(GKmatrix1, corrColors = "blue")


dataset = subset(dataset, select = -c(education.num,capital.loss) )
dim(dataset)


#Skewed graph for Native.countries attribute
ggplot(data.frame(dataset)) +
  geom_bar(aes(x=marital.status,fill = as.factor(prediction)))+ ggtitle(label = "Prediction-maritalStatus Relationship ")+
  labs(fill = "Prediction")  + xlab("Native Countries")+ylab("Count")+
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

summary(dataset)


#Missing value analysis
# total number of rows with NA value
sum(is.na(dataset))

# find the number of null values for each attribute
row = sapply(dataset,  function(x)
  sum(is.na(x)))

row = data.frame(row)
print(row)

# find only those instances where workclass is null
d1 <- filter(dataset, is.na("workclass"))
summary(d1)
head(d1)
# found out that whenever the value of workclass is missing then the value of occupation is also missing,
# this suggest some co-relation between them.

#replace the NA of WORKCLASS WITH "Unknown".
dataset$workclass <- as.character(dataset$workclass)
dataset$workclass[is.na(dataset$workclass)] <- "Unknown"
dataset$workclass <- factor(dataset$workclass)

dataset$occupation <- as.character(dataset$occupation)
dataset$occupation[is.na(dataset$occupation)] <- "Unknown"
dataset$occupation <- factor(dataset$occupation)

names(dataset)
# attribute importance based on correlation
varset1<- c("relationship","capital.gain","education", "prediction")
datasetFrame1<- subset(dataset, select = varset1)
GKmatrix1<- GKtauDataframe(datasetFrame1)
plot(GKmatrix1, corrColors = "blue")

#Preparing Test data

# tree creation


dtree <- rpart(prediction ~ ., data = dataset, method = 'class', model = TRUE)
rpart.plot(dtree)

val_predicted <- predict(dtree, dataset, type = "class")

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
# given error
#accuracy <- sum(diag(confMatrix))/sum(confMatrix)

#print(accuracy)

# run the model on test data
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

accuracy <- sum(diag(confMatrix))/sum(confMatrix)

print(accuracy)


# Build Naive Bayes Model

model <- naiveBayes(prediction ~ ., data = dataset)

print(model)

# Test model on training data

vals_predicted <- predict(model, newdata = dataset)

confMatrix <- table(dataset$prediction, vals_predicted)

# Prints confusion matrix indicating number of values correctly predicted and not

print(confMatrix)

accuracy <- sum(diag(confMatrix))/sum(confMatrix)

print(accuracy)

# Test model on test data

vals_predicted <- predict(model, newdata = test_data)

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


# random Forest
dtree <- randomForest(prediction ~ ., data = dataset)


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

