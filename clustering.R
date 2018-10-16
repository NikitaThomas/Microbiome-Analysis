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

new_df<- data[ , names(data) %in% c("infant", "taxonomy")]

library(dummies)
df_dummies<- dummy.data.frame(new_df, sep = ".")
df_dummies_t<- t(df_dummies)

library(factoextra)
library(heatmap3)
data_dist <- get_dist(df_dummies_t, method = "pearson", stand = TRUE)
hc <- hclust(data_dist, method = "average")
my_palette <- colorRampPalette(c("lightyellow", "red", "green"))(n = 299)

heatmap3(as.matrix(df_dummies_t), Rowv=as.dendrogram(hc),
         labRow =  "",
         col = my_palette,
         main = "Clustering the infants by taxonomy "
)

d <- dist(as.matrix(df_dummies_t))   
hc <- hclust(d)                
plot(hc)                    


data2<- read.csv("NEC_1.csv")
data2$NEC<- as.factor(data2$NEC)
rownames(data2)<- data2$infant_number

d <- dist(as.matrix(data2))   
hc <- hclust(d)                
plot(hc)

clusterCut <- cutree(hc, 4)
table(clusterCut, data2$NEC)

data3<- read.csv("NEC_2.csv")
data3<- data3[ , names(data3) %in% c("infant", "DOL", "antibiotics", "diseases")]

d <- dist(as.matrix(data3))   
hc <- hclust(d)                
plot(hc)

clusterCut <- cutree(hc, 4)
table(clusterCut, data3$DOL)


library(dbscan)
db <- dbscan(data3, eps = .3)

plot(data3, col=db$cluster)
points(x[db$cluster==0,], pch = 3, col = "grey")
hullplot(data3, db)
