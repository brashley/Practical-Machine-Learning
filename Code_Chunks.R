# code to do the Machine Learning

library("tidyr")
library("dplyr")
library("lubridate")
library(data.table)
library(ggplot2)
library(caret)
library(FSelector)

# if the file does not exist download it
if (!file.exists("pml-train.csv")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
    download.file(fileUrl, destfile="pml-train.csv", mode="wb")
}

if (!file.exists("pml-test.csv")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
    download.file(fileUrl, destfile="pml-test.csv", mode="wb")
}


# Read the file into memory
pml.train <- suppressWarnings(read.csv("pml-train.csv",stringsAsFactors=FALSE))
pml.test <- suppressWarnings(read.csv("pml-test.csv",stringsAsFactors=FALSE))

# remove the new window entries
pml.train <- pml.train[pml.train$new_window == 'no',]

# identify columns that have no variztion 
nzv <- nearZeroVar(pml.train,saveMetrics=TRUE)

# remove the near zero columns
pml.train <- pml.train[,!nzv$nzv]
pml.train <- pml.train[c(-1:-8)]

inTrain <- createDataPartition(y=pml.train$classe,
                               p=0.7, list=FALSE)
training <- pml.train[inTrain,]; testing <- pml.train[-inTrain,]

# convert responce to factore
training[, 'classe'] <- as.factor(training[, 'classe'])
testing[, 'classe'] <- as.factor(testing[, 'classe'])

# calculate feature importance weights
weights <- random.forest.importance(classe~., training, importance.type = 1)
hist(weights$attr_importance)
head(weights)


# select top 15 factors bassed on rf importance
subset <- cutoff.k(weights, 15)

featurePlot(training[c("yaw_belt","magnet_dumbbell_z")],training$classe, 
            "density",
            scales = list(x = list(relation="free"),
                          y = list(relation="free")),
            adjust = 1.5,
            pch = "|",
            auto.key = list(columns = 5))


# model for training
model <- as.simple.formula(subset, "classe")


set.seed(825)
# set up cross validation using training control - 10-fold CV
fitControl <- trainControl(
    method = "cv",
    number = 10)

rfFit2 <- train(model, data = training,
                method = "rf", prox=TRUE, trControl = fitControl,
                verbose = FALSE)

save(rfFit2, file="rfFit2.rda")
load(file="rfFit2.rda")

head(getTree(rfFit2$finalModel,k=2))

# build prediction off of testing part of data
pred <- predict(rfFit2,testing); testing$predRight <- pred==testing$classe
# look at table of actual v.s. predicted

test <- confusionMatrix(pred,testing$classe)

# output files for 20 test data measures provided
answers = rep("A", 20)
pred.t <- as.character(predict(rfFit2,pml.test))

pml_write_files(pred.t)

# function to write test files
pml_write_files = function(x){
    n = length(x)
    for(i in 1:n){
        filename = paste0("problem_id_",i,".txt")
        write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
    }
}


#class2ind <- function(cl)
#{
#    n <- length(cl)
#    cl <- as.factor(cl)
#    x <- matrix(0, n, length(levels(cl)) )
#    x[(1:n) + n*(unclass(cl)-1)] <- 1
#    dimnames(x) <- list(names(cl), levels(cl))
#    x
#}
# 