<style>
.reveal h1, .reveal h2, .reveal h3 {
  word-wrap: normal;
  -moz-hyphens: none;
}
.small-code pre code {
  font-size: 1em;
}
.midcenter {
    position: fixed;
    top: 50%;
    left: 50%;
}
.footer {
    color: black; background: #E8E8E8;
    position: fixed; top: 90%;
    text-align:center; width:100%;
}
.pinky .reveal .state-background {
  background: #FF69B4;
} 
.pinky .reveal h1,
.pinky .reveal h2,
.pinky .reveal p {
  color: black;
}
</style>


Predicting Chronic Kidney Disease
========================================================
author: Zee Cods
date: 2015-09-27
font-family: 'Arial'

Introduction
========================================================

Chronic kidney disease (CKD) is a condition characterized by a gradual loss of kidney function over time. CKD is also known as chronic renal disease. Below are some facts about CKD

- 26 million American adults have CKD
- Early detection can help prevent progression
- Hypertension causes CKD and CKD causes hypertension

Predicting CKD
========================================================

Using the [UCI Chronic_Kidney_Disease Data Set](archive.ics.uci.edu/ml/datasets/Chronic_Kidney_Disease) we get the training data that we use to build a Random Forest algorithm prediction model


```r
rfModel <- train(class ~ ., data = trainingData, method = 'rf', trControl = trainControl(method = 'cv',number = 5,repeats = 2,returnResamp = 'none'))
rfModel$modelInfo$tags
```

```
[1] "Random Forest"              "Ensemble Model"            
[3] "Bagging"                    "Implicit Feature Selection"
```

Accuracy of the Random Forest Model
========================================================
Using the 60:40, training:testing data split strategy we validated the model. 

```
Accuracy 
 0.99375 
```
The higher the accuracy of the model, the more credible is it to predict CKD.


See it in Action
========================================================
- This model to predict CKD is deployed as a [`shiny`](http://www.shinyapps.io) app. 
- You can play with it here: https://zcds.shinyapps.io/ckdpredictor
