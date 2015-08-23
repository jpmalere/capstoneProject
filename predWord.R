# Prediction function
predWord <- function(inputPhrase,nGram,nWords){

    splitInput <- strsplit(inputPhrase," ")
    if (length(splitInput[[1]]) == 1){
        # 2-Gram
        tdmNgram <- nGram[[1]]
        expr <- paste("^",splitInput[[1]][1],sep="")
    } else if (length(splitInput[[1]]) == 2){
        # 3-Gram
        tdmNgram <- nGram[[2]]
        expr <- paste("^",splitInput[[1]][1],"\\s",splitInput[[1]][2],sep="")
    } else if (length(splitInput[[1]]) >= 3){
        # 4-Gram
        tdmNgram <- nGram[[3]]
        expr <- paste("^",splitInput[[1]][length(splitInput[[1]])-2],"\\s",splitInput[[1]][length(splitInput[[1]])-1],
                      "\\s",splitInput[[1]][length(splitInput[[1]])],sep="")
    } else {
        return(c("The","The","The"))
    }
    # finds the written words
    idx <- which(tdmNgram$i %in% grep(expr, tdmNgram$dimnames[1]$Terms))
    if (length(idx)>=1){
        # calculates the frequencies
        sumNGram <- aggregate(tdmNgram.v.idx. ~ tdmNgram.i.idx., data = data.frame(tdmNgram$i[idx],tdmNgram$v[idx]), sum)
        # finds the higher frequencies
        idx2 <- sumNGram[head(order(sumNGram[,2], decreasing = T),nWords),1]
        # shows the predicted words
        if (length(idx2)>=nWords){
            predWords <- strsplit(tdmNgram$dimnames[1]$Terms[idx2]," ")
            paste(predWords[[1]][length(splitInput[[1]])+1],
              predWords[[2]][length(splitInput[[1]])+1],
              predWords[[3]][length(splitInput[[1]])+1],sep=" ; ")
        }
        else {
            if (length(splitInput)[[1]] < 2) inputPhrase = ""
            else {
                inputPhrase <- paste(splitInput[[1]][2:length(splitInput[[1]])],collapse=' ')
            }
            predWord(inputPhrase, nGram, nWords)
        }
    } else {
        print(splitInput[[1]])
        print(length(splitInput)[[1]])
        if (length(splitInput[[1]]) < 2) {inputPhrase = ""}
        else {
            inputPhrase <- paste(splitInput[[1]][2:length(splitInput[[1]])],collapse=' ')
        }
        print(inputPhrase)
        predWord(inputPhrase, nGram, nWords)
    }
}

