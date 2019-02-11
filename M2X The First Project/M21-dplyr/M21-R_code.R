# I. Packages & Files  

#### 설치  

install.packages("package_name")
install.packages("dplyr")

#### 사용 선언  

library(package_name)
library(dplyr)

## File types  

#### 1. `.csv` 

dataset <- read.csv("file_name.csv", header = TRUE, stringsAsFactors = FALSE)
dataset <- read.csv("file_name.csv", stringsAsFactors = FALSE)
dataset <- read.csv("file_name.csv", header = FALSE, stringsAsFactors = FALSE)
write.csv(dataset, "file_name.csv")

#### 2. `.txt`  

dataset <- read.table("file_name.txt", header = FALSE, sep = "\t", stringsAsFactors = FALSE) # load
write.table(dataset, "fileName.txt") # save

#### 3. `.xls`, `.xlsx`    

library(readxl)
dataset <- read_excel("file_name.xlsx")
dataset <- read_excel("file_name.xlsx", col_names = FALSE)

##  

#### 4. R 데이터 파일 

save(dataset, "file_name.rda") # save
load("file_name.rda") # load

save("file_name.Rdata") # save
load("file_name.Rdata") # load  

# II. `ISLR` 패키지의 `Carseats` 불러오기

install.package("ISLR") # install when using for the first time 

library(ISLR) # load `ISLR` package
class(Carseats) # data structure
head(Carseats) # the first 6 observations

tail(Carseats, 2) # the last 2 observations
View(Carseats) # a pop-up windows  
dim(Carseats) # dimensions
str(Carseats) # structural view  

summary(Carseats) # summary statistics

sapply(Carseats, class)

sapply(Carseats, function(x) length(unique(x)))

## Basic Manipulations

#### 1. `rename` (이름 바꾸기)    

library(dplyr)
# dplyr: rename `Sales` to `Revenue`  
temp <- rename(Carseats, Revenue = Sales) 
# base: rename `Revenue` to `Sales`
names(temp)[names(temp)=="Revenue"] <- "Sales"

#### 2. `filter` (관찰값 추출, Row 추출)  

# takes obs only if Income > 100
temp <- filter(Carseats, Income > 100) # dplyr + pipe 
temp <- Carseats %>% filter(Income > 100) # dplyr, pipe
temp <- Carseats[Carseats$Income > 100,] # base
# takes obs only if Age between 30 and 40
temp <- filter(Carseats, Age >= 30 & Age < 40) # dplyr
temp <- Carseats %>% filter(Age >= 30 & Age < 40) # dplyr + pipe
temp <- Carseats[((Carseats$Age >= 30) & (Carseats$Age < 40)),] # base  

#### 3. `select` (변수 추출, Column 선택)  

# Choose the variablse Income and Population  
temp <- select(Carseats, Income, Population) # dplyr
temp <- Carseats %>% select(Income, Population) # dplyr
temp <- Carseats[,c("Income", "Population")] # base

#### 4. `arrange` (정렬)    

# Ascending (1-2-3)
Carseats <- arrange(Carseats, Price) # dplyr
Carseats <- Carseats %>% arrange(Price) # dplyr
Carseats <- Carseats[order(Carseats$Price),] # base 
# Descending (3-2-1)
Carseats <- arrange(Carseats, desc(Price)) # dplyr
Carseats <- Carseats %>% arrange(desc(Price)) # dplyr
Carseats <- Carseats[order(Carseats$Price, decreasing = TRUE),] # base

#### 5. `mutate` (새로운 변수 만들기)    

# dplyr
Carseats <- mutate(Carseats, 
                   AdvPerCapita = Advertising/Population,
                   RevPerCapita = Sales/Population) 
# dplyr + pipe
Carseats <- Carseats %>% 
  mutate(AdvPerCapita = Advertising/Population,
         RevPerCapita = Sales/Population) 
# base
Carseats$AdvPerCapita <- Carseats$Advertising/Carseats$Population 
Carseats$RevPerCapita <- Carseats$Sales/Carseats$Population

# mutate with ifelse  
# dplyr
Carseats <- mutate(Carseats, AgeClass = ifelse(Age>=60, "Silver", "non-Silver")) 
# dplyr + pipe
Carseats <- Carseats %>% mutate(AgeClass = ifelse(Age>=60, "Silver", "non-Silver")) 
# base 
Carseats$AgeClass <- ifelse(Carseats$Age >= 60, "Silver", "non-Silver")  

#### 데이터셋에 대해 궁금한 점  

# Successive treatments by pipe
focusCity <- Carseats %>% 
  filter(Income > 100) %>% # high income 
  filter(Age >= 30 & Age < 40) %>% # Take only cities with avg age = 30s 
  mutate(AdvPerCapita = Advertising/Population) %>% # average per capita 
  select(Sales, Income, Age, Population, Education, AdvPerCapita) %>% # select variables
  arrange(Sales) # ascending (1-2-3)  
focusCity

#### 6. `group_by` + `summarise`  

ageDiff <- Carseats %>%
  mutate(AgeClass = # Step 1
           ifelse(Age < 30, "Twenties", 
                  ifelse(Age < 40, "Thirties", "FourtyAbove"))) %>%
  group_by(AgeClass) %>% # Step 2 
  summarise(avgRevenue = mean(Sales)) # Step 3 
ageDiff
