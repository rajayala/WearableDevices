
### UI module (UI.R)

library(shiny)

shinyUI( pageWithSidebar(
  # Application title
  headerPanel("Human Activity Recognition from Wearables Data"),
  
  sidebarPanel(
    selectInput("Model", "Choose Prediction Model:", choices = c('k-Nearest Neighbors (kNN)',
                                                                 'Random Forest (rf)',
                                                                 "Support Vector Machine (svm)")),
    numericInput('testId', 'Choose the test case for prediction', 1, min = 1, max = 20, step = 1),
    submitButton('Submit')
    
  ),
  mainPanel(
    h3('Results of prediction'),
    h4('The test case chosen was'),
    verbatimTextOutput("inputValue"),
    h4('The prediction model chosen was'),
    verbatimTextOutput("dataModel"),
    h4('Which resulted in a prediction of '),
    verbatimTextOutput("prediction"),
    h4('The correct outcome is '),
    verbatimTextOutput("rightPrediction"),
    h4("Confusion Matrix for the Chosen Model"),
    verbatimTextOutput("ConfMatrix"),
    h4("Accuracy of Models on Training vs Test Data"),
    verbatimTextOutput("accuracy")
  ) )
)




 

