## About Chronic Kidney Disease Predictor
### Introduction
This shiny app uses Random Forest algorithm to predict whether a given set of medical measurements are predicting of the Chronic Kidney Disease.

The app used the dataset from [Chronic_Kidney_Disease Data Set](archive.ics.uci.edu/ml/datasets/Chronic_Kidney_Disease) from the UCI Machine Learning Repository.

### How to use ths app
1. Using the `Predictor` tab's sidebar, enter the measurements for the different medical values. For details on what each of the values means please refer to the [Chronic_Kidney_Disease Data Set description](archive.ics.uci.edu/ml/datasets/Chronic_Kidney_Disease) 
2. You will see that the prediction result for your entered values will appear on the right.
3. Hint - Since this is a statistical model, it might be difficult to get the "CKD Positive" prediction. One way to control this is to play with the `Hypertension` and `Diabetes Mellitus` selection tems.
