setwd("~/Desktop/Astarte")
table1<- read.csv("NEC_1.csv")
table2<- read.csv("NEC_2.csv")
table3<- read.csv("NEC_3.csv")

table3$genome..infant...and.sample.in.name.<- as.character(table3$genome..infant...and.sample.in.name.)
table3$taxonomy<- as.character(table3$taxonomy)
table3["sample"]<- NA
table3["infant"]<- NA

# Parsing for sample name
for (n in 1:nrow(table3)){
  table3$sample[n]<- substr(table3$genome..infant...and.sample.in.name.[n],4,15)
}

# Parsing for infant id 
for (n in 1:nrow(table3)){
  table3$infant[n]<- substr(table3$sample[n],1,6)
}
# Rename genome column 
colnames(table3)[colnames(table3)=="genome..infant...and.sample.in.name."] <- "genome"

#Converting sample columns to same datatype
table2$sample<- as.character(table2$sample)

# Populate DOL column  
table3['DOL'] = NA

for(n in 1:nrow(table2)){
  temp_var<- table2$sample[n]
  for (m in 1:nrow(table3)){
    if (table3$sample[m] == temp_var){
      table3$DOL[m]= table2$DOL[n]
      next
    } 
  }
}

# Populate antibiotics_taken
table3['antibiotics_taken']<- NA
table2$antibiotics<- as.character(table2$antibiotics)

for(n in 1:nrow(table2)){
  temp_var<- table2$sample[n]
  for (m in 1:nrow(table3)){
    if (table3$sample[m] == temp_var){
      table3$antibiotics_taken[m]= table2$antibiotics[n]
      next
    } 
  }
}

# Populate diseases 
table3['diseases']<- NA
table2$diseases<- as.character(table2$diseases)

for(n in 1:nrow(table2)){
  temp_var<- table2$sample[n]
  for (m in 1:nrow(table3)){
    if (table3$sample[m] == temp_var){
      table3$diseases[m]= table2$diseases[n]
      next
    } 
  }
}

# Rename table1 column names 
colnames(table1)[colnames(table1)=="infant..primary.key."] <- "infant"
colnames(table1)[colnames(table1)=="Weight..g."] <- "weight"
colnames(table1)[colnames(table1)=="Survived."] <- "survived"

# Populate columns from table1 for each infant 
table3['gestational_age']<- NA
table3['gender']<- NA
table3['birth_mode']<- NA
table3['weight']<- NA
table3['survived']<- NA
table3['birthdate']<- NA
table3['season']<- NA
table3['NEC']<- NA
table3['feeding']<- NA
table3['maternal_disease']<- NA
table3['sepsis']<- NA

table1$infant<- as.character(table1$infant)
table1$gender<- as.character(table1$gender)
table1$birth_mode<- as.character(table1$birth_mode)
table1$survived<- as.character(table1$survived)
table1$season<- as.character(table1$season)
table1$feeding<- as.character(table1$feeding)
table1$birthdate<- as.character(table1$birthdate)


for(n in 1:nrow(table1)){
  temp_var<- table1$infant[n]
  for (m in 1:nrow(table3)){
    if (table3$infant[m] == temp_var){
      table3$gestational_age[m]= table1$gestational_age[n]
      table3$gender[m]= table1$gender[n]
      table3$birth_mode[m]= table1$birth_mode[n]
      table3$weight[m]= table1$weight[n]
      table3$survived[m]= table1$survived[n]
      table3$birthdate[m]= table1$birthdate[n]
      table3$season[m]= table1$season[n]
      table3$NEC[m]= table1$NEC[n]
      table3$feeding[m]= table1$feeding[n]
      table3$maternal_disease[m]= table1$maternal_disease[n]
      table3$sepsis[m]= table1$sepsis[n]
      next
    } 
  }
}

#write.csv(table3, file = "Combined_data.csv")

new_data<- table3
new_data$NEC<- as.factor(new_data$NEC)

omit<- na.omit(new_data)
omit$antibiotics_taken<- as.factor(omit$antibiotics_taken)
omit$diseases<- as.factor(omit$diseases)
omit$gender<- as.factor(omit$gender)
omit$birth_mode<- as.factor(omit$birth_mode)
omit$survived<- as.factor(omit$survived)
omit$season<- as.factor(omit$season)
omit$feeding<- as.factor(omit$feeding)
omit$maternal_disease<- as.factor(omit$maternal_disease)
omit$sepsis<- as.factor(omit$sepsis)

# Random Forest
require(randomForest)
RF<- randomForest(formula = omit$NEC ~ ., data = omit[ ,!names(omit) %in% c("NEC", "birthdate", "genome", "taxonomy", "sample", "infant")], importance = TRUE)
RF
varImpPlot(RF, main= "Variable Importance")
importanceOrder<-order(-RF$importance)
names<-rownames(RF$importance)[importanceOrder]
important_order<- na.omit(names)

# DBSCAN
require(dbscan)
omit_numeric<- omit[ ,!names(omit) %in% c("birthdate", "genome", "taxonomy", "sample", "infant")]
omit_numeric<- as.matrix(sapply(omit_numeric, as.numeric)) 
db <- dbscan(omit_numeric, eps = .3, minPts = 5)

#plot(omit_numeric, col=db$cluster)
#points(x[db$cluster==0,], pch = 3, col = "grey")
#hullplot(data3, db)


require(caret)
set_control <- trainControl(method = "repeatedcv", number = 10, repeats = 3, savePredictions = "final", classProbs=TRUE, search="grid")
tuned <- expand.grid(.mtry=c(1:15),.splitrule = "gini", .min.node.size = c(10, 20))
final_model<- randomForest(formula = omit$NEC ~ ., data = omit[ ,!names(omit) %in% c("NEC", "birthdate", "genome", "taxonomy", "sample", "infant")], tuneGrid = tuned, trControl = set_control)

#plot by season with nec correlation
#remove survived 


