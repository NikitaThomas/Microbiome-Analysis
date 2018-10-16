setwd("~/Desktop/Astarte")
combo<- read.csv("Combined_data.csv")
#new<- rm_between(new, "'", "'", extract=TRUE)

require(qdapRegex)
require(rlist)
combo$antibiotics_taken<- as.character(combo$antibiotics_taken)
combo$antibiotics_taken<- rm_between(combo$antibiotics_taken, "'", "'", extract=TRUE)

for (n in 1:nrow(combo)){
  if (is.na(combo$antibiotics_taken[n]) == FALSE){
    for (i in length(combo$antibiotics_taken[n][[1]]))
    name<- combo$antibiotics_taken[n][[1]][i]
    print(name)
  }
}

combo["cefazolin"]<- NA
combo["claforan"]<- NA
combo["gentamycin"]<- NA
combo["nafcillin"]<- NA
combo["ampicillin"]<- NA
combo["amoxicillin"]<- NA
combo["vancomycin"]<- NA
combo["ofloxacin"]<- NA

# Cefazolin 
for (n in 1:nrow(combo)){
  for (i in length(combo$antibiotics_taken[n][[1]])){
    if (is.na(combo$antibiotics_taken[n][[1]])){
      combo$cefazolin[n] = 0
      next 
    } else {
      name<- combo$antibiotics_taken[n][[1]][i]
      if (colnames(combo)[20] == name){
        combo$cefazolin[n] = 1
      } else {
        combo$cefazolin[n] = 0
      }
    }
  }
}

# Claforan
for (n in 1:nrow(combo)){
  for (i in length(combo$antibiotics_taken[n][[1]])){
    if (is.na(combo$antibiotics_taken[n][[1]])){
      combo$claforan[n] = 0
      next 
    } else if (combo$claforan[n] == 1) {
      print(combo$claforan[n])
      next 
    } else {
      name<- combo$antibiotics_taken[n][[1]][i]
      if (colnames(combo)[21] == name){
        combo$claforan[n] = 1
      } else {
        combo$claforan[n] = 0
      }
    }
  }
}

# Gentamycin
for (n in 1:nrow(combo)){
  for (i in length(combo$antibiotics_taken[n][[1]])){
    if (is.na(combo$antibiotics_taken[n][[1]])){
      combo$gentamycin[n] = 0
      next 
    } else {
      name<- combo$antibiotics_taken[n][[1]][i]
      if (colnames(combo)[22] == name){
        combo$gentamycin[n] = 1
      } else {
        combo$gentamycin[n] = 0
      }
    }
  }
}

# Nafcillin
for (n in 1:nrow(combo)){
  for (i in length(combo$antibiotics_taken[n][[1]])){
    if (is.na(combo$antibiotics_taken[n][[1]])){
      combo$nafcillin[n] = 0
      next 
    } else {
      name<- combo$antibiotics_taken[n][[1]][i]
      if (colnames(combo)[23] == name){
        combo$nafcillin[n] = 1
      } else {
        combo$nafcillin[n] = 0
      }
    }
  }
}

#Ampicillin
for (n in 1:nrow(combo)){
  for (i in length(combo$antibiotics_taken[n][[1]])){
    if (is.na(combo$antibiotics_taken[n][[1]])){
      combo$ampicillin[n] = 0
      next 
    } else {
      name<- combo$antibiotics_taken[n][[1]][i]
      if (colnames(combo)[24] == name){
        combo$ampicillin[n] = 1
      } else {
        combo$ampicillin[n] = 0
      }
    }
  }
}

# Amoxicillin
for (n in 1:nrow(combo)){
  for (i in length(combo$antibiotics_taken[n][[1]])){
    if (is.na(combo$antibiotics_taken[n][[1]])){
      combo$amoxicillin[n] = 0
      next 
    } else {
      name<- combo$antibiotics_taken[n][[1]][i]
      if (colnames(combo)[25] == name){
        combo$amoxicillin[n] = 1
      } else {
        combo$amoxicillin[n] = 0
      }
    }
  }
}

# Vancomycin
for (n in 1:nrow(combo)){
  for (i in length(combo$antibiotics_taken[n][[1]])){
    if (is.na(combo$antibiotics_taken[n][[1]])){
      combo$vancomycin[n] = 0
      next 
    } else {
      name<- combo$antibiotics_taken[n][[1]][i]
      if (colnames(combo)[26] == name){
        combo$vancomycin[n] = 1
      } else {
        combo$vancomycin[n] = 0
      }
    }
  }
}

# Ofloxacin
for (n in 1:nrow(combo)){
  for (i in length(combo$antibiotics_taken[n][[1]])){
    if (is.na(combo$antibiotics_taken[n][[1]])){
      combo$ofloxacin[n] = 0
      next 
    } else {
      name<- combo$antibiotics_taken[n][[1]][i]
      if (colnames(combo)[27] == name){
        combo$ofloxacin[n] = 1
      } else {
        combo$ofloxacin[n] = 0
      }
    }
  }
}
