data = read.table("Documents/GitHub/CSCI_620_Data_Management_Project/phase3/letter-recognition.data.txt", sep = ",")

summary(data)
# the data contains not null values

install.packages("corrplot")

library(corrplot)
corrplot(cor(data1[,2:17]), type = "lower")
corrplot(cor(data1[,2:5]))