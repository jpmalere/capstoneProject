library(shiny)
shinyUI(fluidPage(
    titlePanel("Predict words after a given input text"),
    fluidRow(
        column(12, wellPanel(
            p("This data product consists of three elements. An input text box, a 'Predict' button and a text space where three words on descending order of scores are presented separated by ';'"),
            p(""),
            p("After the input text is inserted and the 'Predict' button is pressed, three words with the highest scores appear after a few seconds;"),
            p(""),
            p("If no text is available on the input text box or the last words are not available on the term-document matrix, the word 'the' appears as the result."),
            p(""),
            p("More details about the characteristics and limitations of this data product can be found on the links below:"),
            p("Github:"),
            a(href="https://github.com/jpmalere/capstoneProject","https://github.com/jpmalere/capstoneProject"),
            p(""),
            p("Rpubs:"),
            a(href="http://rpubs.com/jpmalere/capstoneProject","http://rpubs.com/jpmalere/capstoneProject"),
            p(""), 
            p(""),
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