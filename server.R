# loads libraries
library(shiny)
library(tm)
# loads the prediction function
source("predWord.R")
# load terms-document matrix for 2, 3 and 4 grams
load("tdmNgram.RData")
nGram <- list(tdm2gram,tdm3gram,tdm4gram)
# number of words that results from the prediction
nWords <- 3
# shinyServer
shinyServer(function(input, output) {
    words <- reactive({
        input$predButton
        predWord(input$text,nGram,nWords)
    })
    output$predWords <- renderText({
        words()
    })

})