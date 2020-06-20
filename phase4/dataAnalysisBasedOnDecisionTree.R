library(GoodmanKruskal)
dataset = read.table("adult.data",
                     header = TRUE,
                     sep = ",",
                     na.strings = " ?")
names(dataset)
attach(dataset)
varset1<- c("relationship","capital.gain","education", "prediction")
datasetFrame1<- subset(dataset, select = varset1)
GKmatrix1<- GKtauDataframe(datasetFrame1)
plot(GKmatrix1, corrColors = "blue")



# Compute the analysis of variance
res.aov <- aov(as.numeric(education) ~ prediction, data = dataset)
# Summary of the analysis
summary(res.aov)

kruskal.test(x = prediction, g = as.factor(capital.gain))

