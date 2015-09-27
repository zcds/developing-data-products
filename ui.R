
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(markdown)
library(shiny)

shinyUI(
  fluidPage(
  
    navbarPage("Chronic Kidney Disease",
      tabPanel("Predictor",
    
        # Sidebar with a slider input for number of bins
        sidebarPanel (
          sliderInput('age', 'Age', value = 58, min = 2, max= 90, step = 1),
          sliderInput('bu', 'Blood Urea', 142, min = 1.50, max= 391, step = 10),
          selectInput('htn', 'Hypertension', choices = list("no","yes"), selected="no"),
          selectInput('dm', 'Diabetes Mellitus', choices = list("no","yes"), selected="yes"),
          selectInput('pe', 'Pedal Edema', choices = list("no","yes"), selected="yes"),
          sliderInput('sod', 'Sodium', 141.0, min = 4.5, max= 163, step = 5),
          sliderInput('pot', 'Potassium', 3.5, min = 2.5, max= 47, step = 2),
          sliderInput('bp', 'Blood Pressure', 80, min = 50, max= 180, step = 5),
          selectInput('sg', 'Specific Gravity', choices = list('1.005','1.010','1.015','1.020','1.025'), selected="1.005"),
          selectInput('al', 'Albumin', choices = list("0","1","2","3","4","5"), selected="0"),
          selectInput('su', 'Sugar', choices = list("0","1","2","3","4","5"), selected="0"),
          selectInput('rbc', 'RBC', choices = list("abnormal","normal"), selected="normal"),
          selectInput('pc', 'Plus Cells', choices = list("abnormal","normal"), selected="abnormal"),
          selectInput('pcc', 'Plus Cell Clumps', choices = list("notpresent","present"), selected="notpresent"),
          selectInput('ba', 'Bacteria', choices = list("notpresent","present"), selected="notpresent"),
          sliderInput('bgr', 'Blood Glucose Random', 131, min = 22, max= 490, step = 5),
          sliderInput('sc', 'Serum Creatinine', 1.1, min = 0.4, max= 76, step = 1),
          sliderInput('sod', 'Sodium', 141.0, min = 4.5, max= 163, step = 5),
          sliderInput('pot', 'Potassium', 3.5, min = 2.5, max= 47, step = 2),
          sliderInput('hemo', 'Hemoglobin', 15.8, min = 3, max= 17, step = 1),
          sliderInput('pcv', 'Packed Cell Volume', 53, min = 9, max= 54, step = 1),
          sliderInput('wbcc', 'White Blood Cells Count', 6800, min = 2200, max= 26400, step = 200),
          sliderInput('rbcc', 'Red Blood Cells Count', 6, min = 2.100, max= 8.000, step = 0.57),
          selectInput('appet', 'Appetite', choices = list("good","poor"), selected="no"),
          selectInput('cad', 'Coronary Artery', choices = list("no","yes"), selected="yes"),
          selectInput('ane', 'Anemia', choices = list("no","yes"), selected="no")
        ),
        mainPanel (
          textOutput("refreshTimeMessage"),
          h3 ('Chronic Kidney Disease Prediction:'),
          h2(textOutput("prediction"))
        )
      ),
      tabPanel("About",
               mainPanel(
                 includeMarkdown("about.md")
               )
      ),
      tabPanel("Debug",
               mainPanel(
                 h2('Server Request'),
                 tableOutput("values")
               )
      )
    )
  )
)

