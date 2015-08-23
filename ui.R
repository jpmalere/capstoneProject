library(shiny)
shinyUI(fluidPage(
    titlePanel("Predict words after a given input text"),
    fluidRow(
        column(8, wellPanel(
            textInput("text", "input text:", "input text"),
            
            br(),
            actionButton("predButton", "Predict Word")
        )),
        column(8,
               h4("Predicted Words"),
               textOutput("predWords")
        )
    )
))