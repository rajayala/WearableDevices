

## Human Activity Recognition - based on data from wearable devices

## One time execution - building prediction models

library(shiny)
library(caret)
library(knitr)
library(kernlab)
library(MASS)
library(randomForest)
library(RcppEigen)
library("e1071")

## setwd("/Users/rajayala/Documents/datasciencecoursera/ShinyProject")

## Read training and test files

training <- read.csv("./training.csv", header = TRUE, stringsAsFactors=FALSE)
training$classe <- as.factor(training$classe)
levels(training$classe) <- c("STANDING","SITTING","WALKING", "SLEEPING", "RUNNING")

testing <- read.csv("./testing.csv", header = TRUE, stringsAsFactors=FALSE)

## Set the known outcomes in test data to be right predictions for accuracy comparison
right_pred <- as.factor(c("B", "A", "B", "A", "A", "E", "D", "B", "A", "A", "B", "C", "B", "A", "E", "E", "A", "B", "B", "B"))
levels(right_pred) <- c("STANDING","SITTING","WALKING", "SLEEPING", "RUNNING")

# Now create some prediction models on the training data
# Here, we'll use cross validation with trainControl to help optimize the model parameters

set.seed(18000)
## cvCtrl <- trainControl(method = "cv", number = 5)

## Random Forest 
## mrf <- train(classe ~ ., data = training, method = "rf", trControl = cvCtrl)
## saveRDS(mrf, "./rfmodel.rds")
mrf <- readRDS("./rfmodel.rds")

## SVM
## msvm <- train(classe ~ ., data = training, method = "svmRadial", trControl = cvCtrl)
## saveRDS(msvm, "./svmmodel.rds")
msvm <- readRDS("./svmmodel.rds")

## KNN
## mknn <- train(classe ~ ., data = training, method = "knn", trControl = cvCtrl)
## saveRDS(mknn, "./knnmodel.rds")
mknn <- readRDS("./knnmodel.rds")

## Now, let’s do predictions on the test set data. Here, we’ll do predictions using the 3 models 
## and look for concordance in the classifications.

test.pred.rf <- predict(mrf, testing)
test.pred.svm <- predict(msvm, testing)
test.pred.knn <- predict(mknn, testing)

testcases <- length(testing$problem_id)

## Random Forest model appears to have the highest cross-validation accuracy,
## with the SVM and KNN being second and third.


har <- function (testId, Model) {
  if (Model == "Random Forest (rf)") return (predict(mrf, testing[testId, ]))
  if (Model == "k-Nearest Neighbors (kNN)") return (predict(mknn, testing[testId, ]))
  if (Model == "Support Vector Machine (svm)") return (predict(msvm, testing[testId, ]))
}

mat <- function (Model) {
  if (Model == "Random Forest (rf)") return(confusionMatrix(test.pred.rf, right_pred)[[2]])
  if (Model == "k-Nearest Neighbors (kNN)") return(confusionMatrix(test.pred.knn, right_pred)[[2]])
  if (Model == "Support Vector Machine (svm)") return(confusionMatrix(test.pred.svm, right_pred)[[2]])
}

acc <- function () {
  accuracy <- data.frame(Model=c("Random Forest", "SVM (radial)", "KNN"),
                                      TrainAcc=c(round(max(head(mrf$results)$Accuracy), 3),
                                                 round(max(head(msvm$results)$Accuracy), 3),
                                                 round(max(head(mknn$results)$Accuracy), 3)),
                                      TestAcc=c(sum(test.pred.rf == right_pred)/testcases,
                                                sum(test.pred.svm == right_pred)/testcases,
                                                sum(test.pred.knn == right_pred)/testcases))
              return(accuracy)
}

shinyServer( function(input, output) {
  output$inputValue <- renderPrint({input$testId})
  output$dataModel <- renderPrint({input$Model})
  output$prediction <- renderPrint({har(input$testId, input$Model)})
  output$rightPrediction <- renderPrint({right_pred[input$testId]})
  output$ConfMatrix <- renderPrint({mat(input$Model)})
  output$accuracy <- renderPrint({acc()})
}
)

