# Introduction to Big Data
# Phase 3
#
# Data used:
#     The data is from a census bureau database.
#
# This script file reads the data,
# visualizes the data by plotting histograms of each feature
# Finds and states outlier of every attribute

#
# Analyzing the dataset
#

# Read the data into a data frame
dataset = read.table("adult.data", header = TRUE, sep = ",")
# Print the feature names
colnames(dataset)
# Dimensions of the raw data
dim(dataset)


# Attach the database to the R search path
attach(dataset)

#
# Printing details of the dataset
#

# Print the summary of the dataset
summary(dataset)
# Display internal structure of dataset, which tells what are the different values of every attribute along with its
#levels
str(dataset)

#
# Visualization
#
# Our dataset includes people ranging from 17-90 years of age which seems appropriate in census dataset.
summary(age)

# Display histogram of feature "age" . Our dataset is concentrated
# in the 28-38 (first quartile~second quartile) year range which is expected as that would
# categorize the working age group
## Frequency table
counts <- table(age)
## The most frequent and least frequent values.
# Most frequently occuring value is of the 36year olds.
# Least frequent values for age 86 and 87.
counts[which.max(counts)]
counts[which.min(counts)]
hist(
  age,
  main = "Histogram for Age",
  xlab = "Age",
  xlim = c(17, 90),
  las = 1,
  breaks = 20
)

# Display pie chart of feature "workclass". Majority of the dataset
# are employed in the private sector
pie(table(workclass))

# Display histogram of feature "fnlwgt".
hist(fnlwgt, main = "Final weight Histogram", xlab = "Final weights")
#Final weight attribute consists of
# continuous values. final weight doesn't seem to be
# correlated to any of the other values.
# fnlwgt doesn't seem very relevant in this datset. And so we might choose to drop
# this attribute.

#
# Display table of feature "education"
educationTable <-
  data.frame(count = sort(table(education), decreasing = TRUE))
educationTable
#We have a hypothesis that the higher the education, the higher the income. We would emphasise this using correlation in the later stages
under20yearsAge <- dataset[which(age < 20),]
dim(under20yearsAge)
table(under20yearsAge$education)
#demonstrates the education qualification frequency of people under the age of 20

# Display table of feature "education.num"
summary(education.num)
table(education.num)

dim(educationTable)
#the quantity education.num ranges from 1 to 16. Majority values concentrated between 9 and 12.
# Number of distinct values for education attribute is 16. There seems to be some correlation between the two values
# education.num seems to be certain measure of the education attribute

# Display pie chart of feature "marital.status". Majority of our dataset fall under the
# Married-civ-spouse or the never married category
pie(table(marital.status))
# Display feature "occupation". "?" represent null values
occupationTable <-
  data.frame(count = sort(table(occupation), decreasing = TRUE))
occupationTable
# Display pie chart of feature "relationship"
pie(table(relationship))

# Display pie chart of feature "race". More than 75% of the dataset are white people. This column would be dropped
pie(table(race))
# Display plot of feature "sex". Almost 3/4th of the dataset are male
pie(table(sex))
husbandData <-
  dataset[which(sex == " Female" & relationship == " Husband"),]
dim(husbandData)
#noisy data like the above state that an entry with relationship as Husband, has sex as Female exists. Other such
#data need to be identified

# Display histogram of feature "capital.gain".Most values have value zero. Hence the column will be dropped
hist(capital.gain)
# Display histogram of feature "capital.loss".Most values have value zero. Hence the column will be dropped
hist(capital.loss)
# Display histogram of feature "hours.per.week". As the working class is expected to work 40 hours a week the data seems
# appropriate
hist(hours.per.week)

# Display plot of feature "native.country". The dataset consists of values from people in the
#United States. Thus this column would be dropped
plot(table(native.country))
countries <- table(native.country)
countries[which.max(countries)]

# Display plot of feature "prediction"
plot(prediction)
