#install.packages("naniar")
library(naniar)
#library(dplyr)

# Read the data into a data frame
dataset = read.table("adult.data",
                     header = TRUE,
                     sep = ",",
                     na.strings = " ?")
#attach(dataset)
summary(dataset)
# total number of rows with NA value
sum(is.na(dataset))

# find the number of null values for each attribute
row = sapply(dataset,  function(x)
  sum(is.na(x)))

row = data.frame(row)
print(row)

# find only those instances where workclass is null
d1 <- filter(dataset, is.na(workclass))
summary(d1)
head(d1)
# found out that whenever the value of workclass is missing then the value of occupation is also missing,
# this suggest some co-relation between them.

#replace the NA of WORKCLASS WITH "X".
dataset$workclass <- as.character(dataset$workclass)
dataset$workclass[is.na(dataset$workclass)] <- "x"
dataset$workclass <- factor(dataset$workclass)

dataset$occupation <- as.character(dataset$occupation)
dataset$occupation[is.na(dataset$occupation)] <- "x"
dataset$occupation <- factor(dataset$occupation)

d1 <- filter(dataset, is.na(native.country))
summary(d1)

# when the native.country is NA, the other attribute shows the same trend, assumed the value is missing 
# because the particular individual was simply unaware of his/her native.country.