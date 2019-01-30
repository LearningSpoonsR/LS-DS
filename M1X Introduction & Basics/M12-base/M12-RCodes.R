greeting <- 
  "Hello"


greeting <- "R says \"Hello World!\""
nchar(greeting) # number of characters
substr(greeting, 3, 6) # substring from 3 to 6 
greeting # show 
cat(greeting) # show cleanly 

10^2 + 36
a <- 4
a
a*5
a <- a + 10 # assign a+10 to a 
a

2==3
5>3

is.character(5)
is.character("5")
a <- as.character(5)
is.character(a)
b <- as.numeric(a)
is.numeric(b)
as.numeric(2==3)

class(5)
class("TRUE")
class(TRUE)

mydates <- as.Date(c("2007-06-22", "2004-02-13"))
mydates[1] - mydates[2]

today <- Sys.Date( ) # today 
today

# year
as.numeric(substr(today, 1, 4)) 
# month
as.numeric(substr(today, 6, 7)) 
# day
as.numeric(substr(today, 9, 10)) 

format(today, format="%B %d %Y") 

strVec1 <- c("Hello", "Hi", "What's up")
strVec1
strVec2 <- c("Ma'am", "Sir", "Your Honor")
strVec3 <- paste(strVec1, strVec2, sep = ", ")
strVec3

numVec1 <- c(30,50,70)
numVec1
numVec2 <- seq(30,70,20)
numVec2
numVec3 <- c(25,55,80)
numVec3
numVec4 <- seq(from=20, to=1, by=-3)
numVec4
2:6

min(numVec1) # by all 
min(numVec1, numVec3) # by all
pmin(numVec1, numVec3) # by element
numVec1 > numVec3 # by element 

numVec1[2]
numVec1[-2]
numVec1[1:2]
numVec1[c(1,3)]

mat <- matrix(data = c(9,2,3,4,5,6), ncol = 3)
mat

mat[1, 2] # first row, second column 
mat[2, ] # second row

mean(mat)
apply(mat, 2, mean) # colMeans(mat)
sapply(mat, mean)
apply(mat, 1, mean) # rowMeans(mat)

weather <-
  data.frame(date = c("2017-8-31", "2017-9-1", "2017-9-2"),
             sky  = c("Sunny", "Cloudy", "Rainy"), 
             temp = c(20, 15, 18),
             dust = c(24, 50, 23),
             stringsAsFactors = FALSE)
weather

colnames(weather)
weather$sky
weather$sky==weather[,2]

class(weather)
class(weather$date)
apply(weather, 2, class) 
sapply(weather, class) 

weather$date <- as.Date(weather$date)
str(weather)

HMPark <- 
  list(team = c("Korea", "Tottenham"), 
       birth = as.Date("1992-07-08"),
       goals = 
         data.frame(team = c("U-17", "U-23", "A"),
                    goals = c(4, 2, 7), 
                    stringsAsFactors = FALSE))
HMPark

str(HMPark)

names(HMPark)
sapply(HMPark, class)
HMPark[3]
class(HMPark[3])

HMPark[[3]]
HMPark[["goals"]]
class(HMPark[[3]])
HMPark[[3]]$team 
HMPark$team

