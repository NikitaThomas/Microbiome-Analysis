setwd("~/Desktop/Astarte")
data<- read.csv("NEC_3.csv")

data$genome..infant...and.sample.in.name.<- as.character(data$genome..infant...and.sample.in.name.)
data$taxonomy<- as.character(data$taxonomy)
data["sample"]<- NA
data["infant"]<- NA

for (n in 1:nrow(data)){
  data$sample[n]<- substr(data$genome..infant...and.sample.in.name.[n],4,15)
}

for (n in 1:nrow(data)){
  data$infant[n]<- substr(data$sample[n],1,6)
}

write.csv(data, file = "NEC_3_fixed.csv")

