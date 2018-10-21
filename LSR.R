activate <- function(...) {
  # activate("dplyr")
  # activate("xts", "dygraphs")
  # activate(c("ggplot2", "ISLR"))
  packages <- unlist(list(...))
  for (i in 1:length(packages)) {
    package_i <- packages[i]
    if (!package_i %in% installed.packages()[,"Package"]) {
      print(paste("Installing", package_i))
      suppressMessages(install.packages(package_i))
    }
    suppressMessages(require(package_i, character.only = TRUE))
  }
}

rndGolfQuote <- function() {
  raw   <- read.csv("golf_quotes.csv", header = FALSE)
  quote <- raw[sample(nrow(raw),1),]
  cat(paste0(quote$V2, " - ", quote$V1))
}

rndQuote <- function(n = 1) {
  # rndQuote() # 2018-05-09
  fileName <- paste0(
    "https://raw.githubusercontent.com/ranjith19/",
    "random-quotes-generator/master/quotes.txt")
  activate("readr")
  quotes <- read_file(fileName)
  quotes <- gsub("\n.\n", "zzzzzz", quotes)
  quotes <- unlist(strsplit(quotes, split="zzzzzz"))
  return(quotes[sample(length(quotes), n)])
}

setLang <- function(toLang = NULL) {
  if (is.null(toLang)) {
    if (Sys.getenv("LANGUAGE") == "kr") {
      toLang <- "en"
    } else {
      toLang <- "kr"
    }
  }
  if (toLang == "en") {
    Sys.setenv(LANG = "en") 
    invisible(Sys.setlocale("LC_ALL", "English_United States.1252"))
  } else {
    Sys.setenv(LANG = "kr")
    invisible(Sys.setlocale("LC_ALL", "Korean"))
  }
}

getDocs <- function(fileName, lang) {
  # fileName <- paste0("../script/", input$theFile)
  # lang <- "kr"
  activate(c("tm", "SnowballC", "wordcloud", "KoNLP", "pdftools"))
  activate(c("ggplot2", "dplyr", "RColorBrewer"))
  fileType <- unlist(strsplit(fileName, split = "\\.")) %>% tail(1)
  if (fileType == "pdf") {
    text <- pdf_text(fileName)
  } else if (fileType == "txt") {
    text <- readLines(fileName)
  } else {
    stop("We only support pdf and txt!")
  }
  if (lang %in% c("English", "en", "Eng")) {
    docs <- Corpus(VectorSource(text))
  } else if (lang %in% c("Korean", "kr", "Kor")) {
    docs <- sapply(text, extractNoun, USE.NAMES = F) %>% unlist()
    docs <- Filter(function(x) {nchar(x) >= 2}, docs)
  } else {
    stop("We only support English or Korean!")
  }
  return(docs)
}

getDocs2 <- function(fileName) {
  activate("tm", "SnowballC", "wordcloud", "KoNLP", "pdftools")
  activate("ggplot2", "dplyr", "RColorBrewer", "cld3")
  fileType <- unlist(strsplit(fileName, split = "\\.")) %>% tail(1)
  if (fileType == "pdf") {
    text <- pdf_text(fileName)
  } else if (fileType == "txt") {
    text <- readLines(fileName)
  } else {
    stop("We only support pdf and txt!")
  }
  isKO <- "ko" %in% detect_language(text)
  if (isKO) {
    docs <- sapply(text, extractNoun, USE.NAMES = F) %>% unlist()
    docs <- Filter(function(x) {nchar(x) >= 2}, docs)
    attr(docs, "lang") <- "kr"
  } else {
    docs <- Corpus(VectorSource(text))
    attr(docs, "lang") <- "en"
  }
  return(docs)
}
  
  
cleanDocsGenerateFreqTable <- function(docs, lang) {
  activate(c("tm", "SnowballC", "wordcloud", "KoNLP", "pdftools"))
  activate(c("ggplot2", "dplyr", "RColorBrewer"))
  if (lang == "kr") {
    docs <- unlist(docs)
    docs <- Filter(function(x) {nchar(x) >= 2}, docs) # Character length >= 2
    freqTable <- data.frame(table(docs))
    names(freqTable) <- c("word", "freq")
    freqTable <- freqTable %>% arrange(desc(freq))
  } else { # lang == "en"
    toSpace <- content_transformer(
      function (x , pattern) gsub(pattern, " ", x))
    docs <- docs %>% 
      tm_map(toSpace, "/") %>% 
      tm_map(toSpace, "@") %>%
      tm_map(toSpace, "\\|")
    docs <- docs %>% 
      tm_map(content_transformer(tolower)) %>%         # Convert it to lower case
      tm_map(removeNumbers) %>%                        # Remove numbers
      tm_map(removeWords, stopwords("english")) %>%    # Remove english common stopwords
      tm_map(removeWords, c("blabla1", "blabla2")) %>% # Remove your own stop word
      tm_map(removePunctuation) %>%                    # Remove punctuations    
      tm_map(stripWhitespace)                          # Eliminate extra white spaces
    termMat   <- TermDocumentMatrix(docs)
    termTable <- as.matrix(termMat)
    freqTable <- data.frame(word = rownames(termTable),
                            freq = rowSums(termTable))
    freqTable$word <- rownames(freqTable)
    freqTable <- freqTable %>% arrange(desc(freq))
  }
  return(freqTable)
}

renderBarplotWordcloud <- function(freqTable) {
  ## not official
  output <- list()
  output[[1]] <-
    ggplot(head(freqTable,20)) +
    geom_bar(aes(x=reorder(word, freq), y=freq), stat="identity") +
    coord_flip()
  tempFile <- paste0(gsub(":", "-", Sys.time()), ".png")
  png(tempFile)
  wordcloud(words = freqTable$word, freq = freqTable$freq, 
            min.freq = 1, max.words=200, random.order=FALSE, rot.per=0.35, 
            colors=brewer.pal(8, "Dark2"))
  dev.off()
  output[[2]] <- tempFile
  return(output)
}

importK200Members <- function() {
  tryCatch({
    K200Members <- read.csv(paste0("data/K200Constituent.csv"), header=TRUE)[-(1:2),]
    colnames(K200Members) <- rep(c("Industry", "Code", "Security_Name"), 2)
    rownames(K200Members) <- NULL
    K200Members <- rbind(K200Members[,1:3], K200Members[,4:6])
    K200Members$Industry[K200Members$Industry==""] <- NA
    K200Members <- K200Members %>% fill(Industry)
    return(K200Members)
  }, 
  error = function(e) {
    print(paste("data/K200Constituent.csv", "is not available!"))
  })
}

mdd <- function(xtsVecPx) {
  dd <- rep(0,length(xtsVecPx))
  for (t in 1:length(xtsVecPx)) {
    dd[t] <- (xtsVecPx[t]-max(xtsVecPx[1:t]))/max(xtsVecPx[1:t])
  }
  toIdx   <- which(dd==min(dd))
  fromIdx <- which(xtsVecPx[1:toIdx]==max(xtsVecPx[1:toIdx]))
  return(list(xtsVecPx[c(fromIdx,toIdx)], 
              as.numeric(xtsVecPx[toIdx])/as.numeric(xtsVecPx[fromIdx])-1))
}

genRetVol <- function(xtsVec, lookBack, 
                      toDate=tail(index(xtsVec),1), pa=FALSE) {
  suppressMessages(library(lubridate)) 
  if (lookBack=="1M") {
    fromDate <- toDate - months(1)
  } else if (lookBack=="3M") {
    fromDate <- toDate - months(3)
  } else if (lookBack=="6M") {
    fromDate <- toDate - months(6)
  } else if (lookBack=="YTD") {
    fromDate <- floor_date(toDate, "year") - days(1)
  } else if (lookBack=="1Y") {
    fromDate <- toDate - years(1)
  } else if (lookBack=="3Y") {
    fromDate <- toDate - years(3)
  } else if (lookBack=="5Y") {
    fromDate <- toDate - years(5)
  } else if (lookBack=="10Y") {
    fromDate <- toDate - years(10)
  }
  index0 <- max(which(fromDate >= index(xtsVec)))
  indexT <- max(which(toDate   >= index(xtsVec)))
  
  ## Working on Ret
  P0     <- as.numeric(xtsVec[index0])
  PT     <- as.numeric(xtsVec[indexT])
  if (pa) {
    # numYear <- as.numeric(as.duration(fromDate,toDate),
    #                      unit="years")
    numYear <- as.numeric(as.duration(
      interval(fromDate,toDate)), unit="years")
    Ret     <- 100*((PT/P0)^(1/numYear)-1)
  } else {
    Ret <- 100*(PT/P0-1)
  }
  
  ## Working on Volatility
  P   <- as.numeric(xtsVec[index0:indexT])
  Vol <- 100*sd((tail(P,-1)/head(P,-1)-1))*sqrt(252)
  
  result <- data.frame(lookBack, fromDate, Ret, Vol, 
                       stringsAsFactors=F)
  return(result)
}

genSTLTmdd <- function(myXts) {
  ST <- t(sapply(c("1M","3M","6M","YTD"),
                 function(lookBack) 
                   genRetVol(myXts, lookBack, pa=FALSE)))
  LT <- t(sapply(c("1Y","3Y","5Y","10Y"),
                 function(lookBack) 
                   genRetVol(myXts, lookBack, pa=TRUE)))
  mdd <- mdd(myXts)
  ST     <- data.frame(ST, stringsAsFactors=FALSE)
  LT     <- data.frame(LT, stringsAsFactors=FALSE)
  ST[,2] <- sapply(ST[,2], as.character)
  LT[,2] <- sapply(LT[,2], as.character)
  names(ST)[2:4] <- 
    c("Ref. Date", "Return", "Volatility (p.a.)")
  names(LT)[2:4] <- 
    c("Ref. Date", "Return (p.a.)", "Volatility (p.a.)")
  return(list(ST,LT,mdd))
}

genCalYr <- function(myXts) {
  fromYear  <- year(min(index(myXts)))
  toYear    <- year(max(index(myXts)))
  yearID    <- fromYear:toYear
  yrPerform <- data.frame(yearID,
                          matrix(0,length(yearID),4))
  names(yrPerform)[2:5] <-
    c("fromIdx","toIdx","Return","Volatility")
  yrPerform$toIdx   <- sapply(yrPerform$yearID, function(yr) 
    max(which(yr >= year(index(myXts)))))
  yrPerform$fromIdx <- c(1, head(yrPerform$toIdx,-1))
  yrPerform$Return  <- 
    apply(yrPerform[,2:3], 1, function(x)
      100*(as.numeric(myXts[x[2]])/as.numeric(myXts[x[1]])-1))
  genXts <- function(interval, xtsVec) {
    P <- as.numeric(xtsVec[interval[1]:interval[2]])
    Vol <- 100*sd((tail(P,-1)/head(P,-1)-1))*sqrt(252)
    return(Vol)
  }
  yrPerform$Volatility <- 
    apply(yrPerform[,2:3], 1, function(x) 
      genXts(x, myXts))
  return(yrPerform)
}

