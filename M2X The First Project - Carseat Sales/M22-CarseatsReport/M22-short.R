library(ISLR)
library(dplyr)
library(ggplot2)
str(Carseats) 

xyPlot <- 
  ggplot(data = Carseats, aes(x = Advertising, y = Sales)) + 
  geom_point()
xyPlot

colnames(Carseats)
# `Income`, `Population`, `Age`, `Education`, **`Urban`**, **`US`**   
# `CompPrice`, `Price`, **`ShelveLoc`**  
  
xyPlot + facet_wrap(~ Urban) + ggtitle("by Urban")
xyPlot + facet_wrap(~ US) + ggtitle("by US")

generateQuartile <- function(x) {
  return(summary(x)[c(2,3,5)])
}

Carseats <- Carseats %>% 
  mutate(IncomeF = 
           ifelse(Income < generateQuartile(Income)[1], "Q1",
                  ifelse(Income < generateQuartile(Income)[2], "Q2",
                         ifelse(Income < generateQuartile(Income)[3], "Q3", "Q4")))) %>%
  mutate(PopulationF = 
           ifelse(Population < generateQuartile(Population)[1], "Q1",
                  ifelse(Population < generateQuartile(Population)[2], "Q2",
                         ifelse(Population < generateQuartile(Population)[3], "Q3", "Q4")))) %>%

xyPlot <- 
  ggplot(data = Carseats, aes(x = Advertising, y = Sales)) + 
  geom_point() # Let xyPlot to update the dataset 
xyPlot + facet_wrap(~ IncomeF) + 
  labs(title = "by IncomeF", 
       subtitle = generateQuartile(Carseats$Income) %>% as.numeric() %>% paste(collapse = ","))
xyPlot + facet_wrap(~ PopulationF) +
  labs(title = "by PopulationF", 
       subtitle = generateQuartile(Carseats$Population) %>% as.numeric() %>% paste(collapse = ","))

