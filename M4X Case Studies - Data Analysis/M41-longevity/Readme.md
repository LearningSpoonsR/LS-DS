# QnA 게시판

<https://github.com/LearningSpoonsR/LS-DS/issues/13>

성별에 따른 차이를 보는 box plot 

```
library(tidyr)
dataset <- lifeCountry %>% select(Country, Continent, Population, Female, Male)
dataset <- dataset %>% gather(c("Female", "Male"), key = "Gender", value = "Exp_Life")
head(dataset)
tail(dataset)
ggplot(dataset, aes(x = Gender, y = Exp_Life)) + geom_boxplot() + facet_wrap(~ Continent) 
```
