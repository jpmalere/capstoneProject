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
#    words <- reactive({
#        input$predButton
    words <- eventReactive(input$predButton,{
        
        inputPhrase <- Corpus(VectorSource(input$text),readerControl = list(language="en_US"))
        inputPhrase <- tm_map(inputPhrase, tolower)
        inputPhrase <- tm_map(inputPhrase, removePunctuation)
        inputPhrase <- tm_map(inputPhrase, removeNumbers)
        inputPhrase <- tm_map(inputPhrase, removeWords, stopwords("english"))
        inputPhrase <- tm_map(inputPhrase, removeWords, stopwords("SMART"))
        inputPhrase <- tm_map(inputPhrase, stripWhitespace)
        inputPhrase <- tm_map(inputPhrase, PlainTextDocument)
        inputPhrase <- lapply(inputPhrase,as.character)[[1]]
        aux <- strsplit(inputPhrase," ")
        inputPhrase <- paste(aux[[1]][(length(aux[[1]])-2):(length(aux[[1]]))],collapse=' ')
        print(paste("Input:",inputPhrase))
        
        predWord(inputPhrase,nGram,nWords)
    })
    output$predWords <- renderText({
        words()
    })

})