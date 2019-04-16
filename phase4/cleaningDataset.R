# Read the data into a data frame
dataset = read.table("adult.data",header = TRUE,sep = ",",na.strings = " ?")
dim(dataset)
#attach(dataset)

#Based on the initial analysis, the columns workclass,fnlwgt,race,sex,capital.gain,capital.loss,native.country 
#are dropped. Values stored in this column are skewed and do not contribute to any useful information
dataset = subset(dataset, select = -c(workclass,fnlwgt,race,sex,capital.gain,capital.loss,native.country) )
dim(dataset)
summary(dataset)
