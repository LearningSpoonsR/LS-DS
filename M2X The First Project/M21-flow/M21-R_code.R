#
# M21 - Flow
# Rscript Collection
# 

##########################################################
## Part 1. 수집 - from "ISLR" package

# install.packages("packageName") # playstore, Appstore
# library(packageName) # declaring "I will use this package!"
# dataset <- read.csv("fileName.csv", header = TRUE, stringsAsFactors = FALSE)
# dataset <- read.csv("fileName.csv", header = FALSE, stringsAsFactors = FALSE) # load
# write.csv(dataset, "fileName.csv") # save
# dataset <- read.table("fileName.txt", header = FALSE, sep = "\t", stringsAsFactors = FALSE) # load
# write.table(dataset, "fileName.txt") # save
# install.packages("readxl")
# library(readxl)
# dataset <- read_excel("fileName.xlsx")
# dataset <- read_excel("fileName.xlsx", col_names = FALSE) # (same as `header=FALSE`)
# save(dataset, "fileName.rda") # save
# load("fileName.rda") # load
# save("fileName.Rdata") # save
# load("fileName.Rdata") # load 

install.package("ISLR") # installation
library(ISLR) # load package
class(Carseats) # name of data structure
head(Carseats) # the first 6 observations
tail(Carseats, 5) # the last 5 observations
View(Carseats) # pop-up windows  
dim(Carseats) # dimensions
str(Carseats) # structural view  
summary(Carseats) # summary statistics

##########################################################
## Part 2. 전처리  

# 2. filter (관찰값 추출, Row 추출)  

library(dplyr)
# takes only if Income > 100
temp <- filter(Carseats, Income > 100) # dplyr
temp <- Carseats %>% filter(Income > 100) # dplyr, pipe
temp <- Carseats[Carseats$Income > 100,] # base
# takes only if Age between 30 and 40
temp <- filter(Carseats, Age >= 30 & Age < 40) # dplyr
temp <- Carseats %>% filter(Age >= 30 & Age < 40) # dplyr, pipe
temp <- Carseats[((Carseats$Age >= 30) & (Carseats$Age < 40)),] # base  

# 3. select (변수 추출, Column 선택)  

# Choose the variables Income and Population  
temp <- select(Carseats, Income, Population) # dplyr
temp <- Carseats %>% select(Income, Population) # dplyr
temp <- Carseats[,c("Income", "Population")] # base

# 4. arrange (정렬)  

# Ascending (1-2-3)
Carseats <- arrange(Carseats, Price) # dplyr
Carseats <- Carseats %>% arrange(Price) # dplyr
Carseats <- Carseats[order(Carseats$Price),] # base 
# Descending (3-2-1)
Carseats <- arrange(Carseats, desc(Price)) # dplyr
Carseats <- Carseats %>% arrange(desc(Price)) # dplyr
Carseats <- Carseats[order(Carseats$Price, decreasing = TRUE),] # base

# 5. mutate (새로운 변수)  

# base
Carseats$Revenue <- Carseats$Sales

# dplyr
Carseats <- mutate(Carseats, 
                   AdvPerCapita = Advertising/Population,
                   RevPerCapita = Revenue/Population) 

# dplyr (with pipe)
Carseats <- Carseats %>% 
  mutate(AdvPerCapita = Advertising/Population,
         RevPerCapita = Revenue/Population) 

# base
Carseats$AdvPerCapita <- Carseats$Advertising/Carseats$Population 
Carseats$RevPerCapita <- Carseats$Revenue/Carseats$Population

# mutate with ifelse
Carseats <- mutate(Carseats, AgeClass = ifelse(Age>=60, "Silver", "non-Silver"))
Carseats <- Carseats %>% mutate(AgeClass = ifelse(Age>=60, "Silver", "non-Silver"))
Carseats$AgeClass <- ifelse(Carseats$Age >= 60, "Silver", "non-Silver")

# Successive treatments by pipe
focusCity <- Carseats %>% 
  filter(Income > 100) %>%
  filter(Age >= 30 & Age < 40) %>%
  mutate(AdvPerCapita = Advertising/Population) %>%
  select(Sales, Income, Age, Population, Education, AdvPerCapita) %>%
  arrange(Sales) # ascending  
print(focusCity)

Carseats %>%
  mutate(AgeClass = 
           ifelse(Age < 30, "Twenties", 
                  ifelse(Age < 40, "Thirties", "FourtyAbove"))) %>%
  group_by(AgeClass) %>%
  summarise(avgRevenue = mean(Sales))

##########################################################
## Part 3. 분석 \& 시각화 - `ggplot2'

# basic ggplot command
# ggplot(data = <DATA>) + <GEOM_FUNCTION>(mapping = aes(<MAPPING>))
library(ggplot2)
? mpg # getting help    
mpg 
class(mpg)
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))

# color, size, alpha, shape 
library(gridExtra) # grid.arrange()
a <- ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class))
b <- ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, size = class))
grid.arrange(a, b, nrow=1, ncol=2)

c <- ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, alpha = class))
d <- ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, shape = class))
grid.arrange(c, d, nrow=1, ncol=2)

# Facets (1 variable) - `facet_wrap`
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_wrap(~ class, nrow = 2)

# Facets (2 variables) - `facet_grid`
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_grid(drv ~ cyl)

# Point vs Smooth
e <- ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))
f <- ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy))
grid.arrange(e, f, nrow = 1, ncol = 2)

# AES mapping의 중첩  
g <- ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy))
h <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_smooth()
grid.arrange(g, h, nrow = 1, ncol = 2)

# Point + Smooth  
i <- ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
j <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() +
  geom_smooth()
grid.arrange(i, j, nrow = 1, ncol = 2)

k <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(aes(linetype = drv))
l <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(aes(linetype = drv)) + 
  geom_point(aes(color = drv))
grid.arrange(k, l, nrow = 1, ncol = 2)

## Carseat  
str(Carseats)
a <- ggplot(data = Carseats, aes(x = Advertising, y = Sales)) + geom_point(aes(color = Urban))
print(a)
# Add features to existing ggplot object!
a <- a + facet_wrap(~ Urban)
print(a)

doAgeFacet <- TRUE
a <- ggplot(data = Carseats, aes(x = Advertising, y = Sales)) +
  geom_point(aes(color = Urban))
if (doAgeFacet) {
  a <- a + facet_wrap(~ Urban)
}
print(a)

doAgeFacet <- FALSE
a <- ggplot(data = Carseats, aes(x = Advertising, y = Sales)) +
  geom_point(aes(color = Urban))
if (doAgeFacet) {
  a <- a + facet_wrap(~ Urban)
}
print(a)
