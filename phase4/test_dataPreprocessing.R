#install.packages("naniar")
library(naniar)

# Read the data into a data frame
test_data = read.table("adult.test",header = TRUE,sep = ",",na.strings = " ?")
dim(test_data)

#Based on the initial analysis, the columns workclass,fnlwgt,race,sex,capital.gain,capital.loss,native.country 
#are dropped. Values stored in this column are skewed and do not contribute to any useful information
test_data = subset(test_data, select = -c(fnlwgt,race,native.country) )
dim(test_data)
summary(test_data)

# total number of rows with NA value
sum(is.na(test_data))

# find the number of null values for each attribute
row = sapply(test_data,  function(x)
  sum(is.na(x)))

row = data.frame(row)
print(row)

# find only those instances where workclass is null
d1 <- filter(test_data, is.na("workclass"))
summary(d1)
head(d1)
# found out that whenever the value of workclass is missing then the value of occupation is also missing,
# this suggest some co-relation between them.

#replace the NA of WORKCLASS WITH "X".
test_data$workclass <- as.character(test_data$workclass)
test_data$workclass[is.na(test_data$workclass)] <- "x"
test_data$workclass <- factor(test_data$workclass)

test_data$occupation <- as.character(test_data$occupation)
test_data$occupation[is.na(test_data$occupation)] <- "x"
test_data$occupation <- factor(test_data$occupation)

# when the native.country is NA, the other attribute shows the same trend, assumed the value is missing 
# because the particular individual was simply unaware of his/her native.country.

summary(test_data)
