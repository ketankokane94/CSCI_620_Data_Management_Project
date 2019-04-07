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
adultDataset = read.table("adult.data", header= TRUE, sep = ",")
# Convert the dataset to integer format
adultDataset[] <- lapply(adultDataset,as.integer)
# Removing null values
na.omit(adultDataset)
# Attach the database to the R search path
attach(adultDataset)

#
# Printing details of the dataset
#

# Print the summary of the dataset
summary(adultDataset)
# Display internal structure of dataset
str(adultDataset)
# Print the feature names
colnames(adultDataset)

#
# Visualization
#

# Display the lower correlation plot of the dataset
corrplot(cor(adultDataset), method="number", type = "lower")
# Display histogram of feature "age" 
hist(age)
# Display histogram of feature "workclass"
hist(workclass)
# Display histogram of feature "fnlwgt"
hist(fnlwgt)
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

