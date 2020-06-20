library(tidyverse)
dataset = read.table("adult.data",
                     header = TRUE,
                     sep = ",",
                     na.strings = " ?")
names(dataset)
attach(dataset)
dataset<-na.omit(dataset)
dim(dataset)
#education vs occupation
ggplot(data = dataset) +
  geom_point(mapping = aes(x = education, y = occupation, color = prediction))

ggplot(data = dataset) +
  geom_point(mapping = aes(x = education, y = occupation, size = prediction))

#checking plots of continuous values
ggplot(data = dataset) +
  geom_point(mapping = aes(x = capital.gain, y = relationship, color = prediction))
#facet wrap
ggplot(data = dataset) + 
  geom_point(mapping = aes(x = prediction, y = capital.gain)) + 
  facet_wrap(~ education, nrow = 2)

#facet grid-> 2 variable evaluation
ggplot(data = dataset) + 
  geom_point(mapping = aes(x = prediction, y = capital.gain))+ 
  facet_grid(workclass ~ occupation)

#smoothcurve
ggplot(data = dataset) + 
  geom_smooth(mapping = aes(x = prediction, y = capital.gain))
ggplot(data = dataset) + 
  geom_point(mapping = aes(x = prediction, y = capital.gain))

ggplot(data = dataset) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

plot(table(native.country))

ggplot(data.frame(dataset)) +
  geom_bar(aes(x=native.country,fill = as.factor(prediction)))+ ggtitle(label = "Prediction-Native Countries Relationship ")+
  labs(fill = "Prediction")  + xlab("Native Countries")+ylab("Count")+
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank())
ggplot(data.frame(dataset)) +
  geom_bar(aes(x=race,fill = as.factor(prediction)))+ ggtitle(label = "Race-Prediction Relationship")+
labs(fill = "Prediction")  + xlab("Race")+ylab("Count")+
  theme(axis.text.x=element_text(color="black", size=8),
        axis.ticks.x=element_blank())  

#Computed variables for stat_count while making bar charts-geombar and geomcol
#count-number of points in bin
#prop-groupwise proportion

#Bar plot

ggplot(data = dataset) + 
  geom_bar(mapping = aes(x = native.country))


#Percentage plot for workclass differentiated on the basis of sex
ggplot(dataset, aes(x = workclass, group = sex)) + 
  geom_bar(aes(y = ..prop.., fill = factor(..x..)), stat="count") + 
  geom_text(aes( label = scales::percent(..prop..),
                 y= ..prop.. ), stat= "count", vjust = -.5) +
  labs(y = "Percent", fill="Workclass") +
  facet_grid(~sex) +
  scale_y_continuous(labels = scales::percent)+
  theme(axis.text.x=element_text(color="black", size=7),
        axis.ticks.x=element_blank())  

ggplot(data = dataset) + 
  geom_bar(aes(x=education,fill = as.factor(prediction)))+ 
  facet_grid(education~sex)

ggplot(data.frame(dataset)) +
  geom_bar(aes(x=race,fill = as.factor(prediction)))+ ggtitle(label = "Race-Prediction Relationship")+
  
