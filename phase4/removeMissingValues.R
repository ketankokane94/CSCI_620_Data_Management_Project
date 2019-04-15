

#install.packages("naniar")
library(naniar)

# Read the data into a data frame
dataset = read.table("adult.data",
                     header = TRUE,
                     sep = ",",
                     na.strings = " ?")
attach(dataset)
summary(dataset)
# total number of rows with NA value
sum(is.na(dataset))

row = sapply(dataset,  function(x)
  sum(is.na(x)))

row = data.frame(row)
row
colnames(row)
plot(row)
