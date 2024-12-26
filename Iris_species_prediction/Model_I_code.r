# Importing libraries
library(RCurl) # for downloading the iris CSV file
library(randomForest) #to create the prediction model
library(caret) #for data splitting

#we will be using the iris dataset already in Rstudio

# Performs stratified random split of the data set
TrainingIndex <- createDataPartition(iris$Species, p=0.8, list = FALSE)
TrainingSet <- iris[TrainingIndex,] # Training Set
TestingSet <- iris[-TrainingIndex,] #remainder 0.2 as Testing Set

write.csv(TrainingSet, "training.csv") #saving for preventing shuffling and allowing reproducibility
write.csv(TestingSet, "testing.csv")

TrainSet <- read.csv("training.csv", header = TRUE)
TrainSet <- TrainSet[,-1]

# Building Random forest model and saving into model

model <- randomForest(Species ~ ., data = TrainSet, ntree = 500, mtry = 4, importance = TRUE)

# Save model to RDS file
saveRDS(model, "model.rds")