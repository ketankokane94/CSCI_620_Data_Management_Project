# Introduction to Big Data
# Phase 3
# 
# Data used:
#     The data is from a census bureau database. 
#
# This script file reads the data, cleans it of missing values and visualizes the data by plotting histograms of each feature
#
# Dependencies (Libraries used):
#     1. corrplot (used to display the correlation matrix of the dataset)
#

#
# Installing and loading dependencies
#

# Install the corrplot library
install.packages("corrplot")
#Load required libraries
library(corrplot)

#
# Preprocessing and cleaning the data
#

# Read the data into a data frame
dataset = read.table("adult.data", header= TRUE, sep = ",")
# Print the feature names
colnames(dataset)
# Dimensions of the raw data
dim(dataset)

# Convert the dataset to integer format
#dataset[] <- lapply(dataset,as integer)

# Removing null values
na.omit(dataset)
#Checking dimensions after getting rid of null values
dim(dataset)
# Attach the database to the R search path
attach(dataset)

#
# Printing details of the dataset
#

# Print the summary of the dataset
summary(dataset)
# Display internal structure of dataset
str(dataset)



#
# Visualization
#
# Our dataset inclused people ranging from 17-90years of age.
summary(age)
boxplot(age)

# Display histogram of feature "age" . Our dataset is concentrated 
# in the 28-38(first quartile~second quartile) year range i.e which is expected as that would  
# categorize the working age group
## Frequency table
counts <- table(age)
counts
## The most frequent and least frequent values. 
# Most frequently occuring value is of the 36year olds. 
# Least frequent values for age 86 and 87.
counts[which.max(counts)]
counts[which.min(counts)]
hist(age,main="Histogram for Age",xlab="Age", xlim=c(17,90),las=1, 
     breaks=20)
# Display histogram of feature "workclass". Majority of the dataset 
# are employed in the private sector
pie(table(workclass))

# Display histogram of feature "fnlwgt"
#hist(fnlwgt, main = "Final weight Histogram", xlab = "Final weights")
pie(as.numeric(fnlwgt), main = "Final weight Histogram")
# Display histogram of feature "education"
hist(education)
# Display histogram of feature "education.num"
hist(education.num)
# Display histogram of feature "marital.status"
hist(marital.status)
# Display histogram of feature "occupation"
hist(occupation)
# Display histogram of feature "relationship"
hist(relationship)
# Display histogram of feature "race"
hist(race)
# Display histogram of feature "sex"
hist(sex)
# Display histogram of feature "capital.gain"
hist(capital.gain)
# Display histogram of feature "capital.loss"
hist(capital.loss)
# Display histogram of feature "hours.per.week"
hist(hours.per.week)
# Display histogram of feature "native.country"
hist(native.country)
# Display histogram of feature "prediction"
hist(prediction)
# Display the lower correlation plot of the dataset
corrplot(cor(dataset), method="number", type = "lower")
