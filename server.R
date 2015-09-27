
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(caret)
library(randomForest)
library(e1071)

# Load CKD dataset
if (!file.exists('./chronic_kidney_disease_full.csv')) {
  download.file(url = 'https://raw.githubusercontent.com/zcds/developing-data-products/master/Chronic_Kidney_Disease/chronic_kidney_disease_full.csv', destfile = './chronic_kidney_disease_full.csv', method = 'curl')
}

ckd <- read.csv(file = './chronic_kidney_disease_full.csv', , na.strings = c("?"))

# Prepare Data
## Tranform the variables to factors
ckd$sg <- as.factor(ckd$sg)
ckd$al <- as.factor(ckd$al)
ckd$su <- as.factor(ckd$su)
ckd$class <- as.factor(ckd$class)


## Replace missing numeric values with column mean
for (i in which(sapply(ckd, is.numeric))) {
  ckd[is.na(ckd[, i]), i] <- mean(ckd[, i],  na.rm = TRUE)
}

## Replace missing factors with column samples
for (i in which(!sapply(ckd, is.numeric))) {
  ckd[is.na(ckd[, i]), i] <- sample(x = levels(ckd[,i]), size = sum(is.na(ckd[,i])), replace = TRUE)
}

## Train and Validate the model
trainingSplit <- createDataPartition(y = ckd$class, p=0.60, list=FALSE)
trainingData <- ckd[trainingSplit,]
testingData <- ckd[-trainingSplit,]

## Build the model
rfModel <- train(class ~ ., data = trainingData, method = 'rf', trControl = trainControl(method = 'cv',number = 5,repeats = 2,returnResamp = 'none'))
#rfModel <- train(class ~ age + bp + bgr + bu + hemo + wbcc + rbcc, data = ckd, method = 'rf', trControl = trainControl(method = 'cv',number = 5,repeats = 2,returnResamp = 'none'))

## Validate the model on the test data
testingResult <- predict(rfModel, testingData)
rfConfusionMatrix <- confusionMatrix(testingResult, testingData$class)

shinyServer(function(input, output) {
  values <- reactive({
    # Compose data frame
    data.frame(
      Name = c('Age',
               'Blood Pressure',
               'Specific Gravity',
               'Albumin',
               'Sugar',
               'RBC',
               'Plus Cells',
               'Plus Cell Clumps',
               'Bacteria',
               'Blood Glucose Random',
               'Blood Urea',
               'Serum Creatinine',
               'Sodium',
               'Potassium',
               'Hemoglobin',
               'Packed Cell Volume',
               'White Blood Cells Count',
               'Red Blood Cells Count',
               'Hypertension',
               'Diabetes Mellitus',
               'Coronary Artery',
               'Appetite',
               'Pedal Edema',
               'Anemia'),
      Value = as.character(c(input$age,
                             input$bp,
                             input$sg,
                             input$al,
                             input$su,
                             input$rbc,
                             input$pc,
                             input$pcc,
                             input$ba,
                             input$bgr,
                             input$bu,
                             input$sc,
                             input$sod,
                             input$pot,
                             input$hemo,
                             input$pcv,
                             input$wbcc,
                             input$rbcc,
                             input$htn,
                             input$dm,
                             input$cad,
                             input$appet,
                             input$pe,
                             input$ane)), 
      stringsAsFactors=FALSE)
  }) 
  
  # Show the values using an HTML table
  output$values <- renderTable({
    values()
  })
  
  getTime <- reactive({
    input$age
    input$age
    input$bp
    input$sg
    input$al
    input$su
    input$rbc
    input$pc
    input$pcc
    input$ba
    input$bgr
    input$bu
    input$sc
    input$sod
    input$pot
    input$hemo
    input$pcv
    input$wbcc
    input$rbcc
    input$htn
    input$dm
    input$cad
    input$appet
    input$pe
    input$ane
    
    Sys.time()
  })
  
  output$refreshTimeMessage <- renderText({
    paste('Prediction retrieved at:', as.character(getTime()))
  })
  
  getPrediction <- reactive({
    inputDf <- data.frame(
      age = input$age,
      bp = input$bp,
      sg = input$sg,
      al = input$al,
      su = input$su,
      rbc = input$rbc,
      pc =  input$pc,
      pcc= input$pcc,
      ba = input$ba,
      bgr = input$bgr,
      bu = input$bu,
      sc = input$sc,
      sod = input$sod,
      pot= input$pot,
      hemo = input$hemo,
      pcv = input$pcv,
      wbcc = input$wbcc,
      rbcc = input$rbcc,
      htn = input$htn,
      dm = input$dm,
      cad = input$cad,
      appet = input$appet,
      pe = input$pe,
      ane = input$ane)
    
    predResult <- predict(rfModel, inputDf)
    as.character(predResult)
    if (predResult == 'ckd') {
      'CKD Positive :('
    } else {
      'CKD Negative :)'
    }
  })
  
  output$prediction <- renderText ({
    getPrediction()
  })
  
  
  
})
