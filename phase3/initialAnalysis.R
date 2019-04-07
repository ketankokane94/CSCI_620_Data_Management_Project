


# the data contains null values

install.packages("corrplot")

library(corrplot)
corrplot(cor(data1[,2:17]), type = "lower")
corrplot(cor(data1[,2:5]))

data = read.table("Documents/GitHub/CSCI_620_Data_Management_Project/phase3/adult.data", header= TRUE, sep = ",")
colnames(data)
str(data)
summary(data)

# plotting histogram 
plot(data$age)
plot(data$workclass)
plot(data$fnlwgt)
plot(data$education)
plot(data$education.num)
plot(data$marital.status)
plot(data$occupation)
plot(data$relationship)
plot(data$race)
plot(data$sex)
plot(data$capital.gain)
plot(data$capital.loss)
plot(data$hours.per.week)
plot(data$native.country)
plot(data$prediction)

