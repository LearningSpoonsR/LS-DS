# I. Country - Code from Wikipedia
# (https://en.wikipedia.org/wiki/ISO_3166-1)
CountryCode <- read.delim("data/Country-Code.txt", stringsAsFactors = FALSE)

# II. Country - Continent
CC2Continent <- function(CC) {
  if (CC=="AF") {
    return("Africa")
  } else if (CC=="AN") {
    return("Antartica")
  } else if (CC=="AS") {
    return("Asia")
  } else if (CC=="SA") {
    return("South America")
  } else if (CC=="EU") {
    return("Europe")
  } else if (CC=="OC") {
    return("Oceania")
  } else {
    return("North America")
  }
}
CodeContinent <- read.delim("data/Code-Continent.txt", stringsAsFactors = FALSE)
CodeContinent$CC[is.na(CodeContinent$CC)] <- "NA"
CodeContinent$Continent <- sapply(CodeContinent$CC, CC2Continent)  

# III. Life Expectancy from Wikipedia
# (https://en.wikipedia.org/wiki/List_of_countries_by_life_expectancy)
LifeExpectancy <- read.delim("data/Life Expectancy.txt", 
                             stringsAsFactors = FALSE)

# Iv. GDP per capita from OECD
# library(OECD)
# OECD_data_list <- get_datasets()
# # gdpRelated <- OECD_data_list[grepl("GDP",OECD_data_list$title),]
# # WEOrelated <- OECD_data_list[grepl("EO",OECD_data_list$id),]
# EO102_desc <- get_data_structure("EO102_INTERNET") # Nov 2017
# str(EO102_desc)
# EO102_desc$VAR_DESC
# EO102_desc$VARIABLE[grepl("capita",EO102_desc$VARIABLE$label),]
# GDPVD_CAP <- get_dataset("EO102_INTERNET", filter=list(NULL,"GDPVD_CAP"))
# GDPVD_CAP <- GDPVD_CAP[GDPVD_CAP$obsTime==2017,c("LOCATION","obsValue")]
# names(GDPVD_CAP) <- c("ISO3", "OECD_GDP")
# dim(GDPVD_CAP)
# write.csv(GDPVD_CAP, paste0(crtDir, "data/OECDGDP.csv"))
GDPVD_CAP <- read.csv("data/OECDGDP.csv", stringsAsFactors = FALSE)[,2:3]

# V. GDP per capita from Wikipedia
# (https://en.wikipedia.org/wiki/List_of_countries_by_GDP_(nominal)_per_capita)
GDP <- read.delim("data/GDPIMF2017.txt", stringsAsFactors = FALSE)

# VI. Population
# (https://en.wikipedia.org/wiki/List_of_countries_by_population_(United_Nations))
population <- read.delim("data/population.txt", stringsAsFactors = FALSE)

# VII. MERGE
# Available: CountryCode, CodeContinent, GDP, population, LifeExpectancy
# Goal: lifeCountry = [ISO3, Country, Continent, GDP, OECDGDP, Population, Life Expectancies]

lifeCountry <- data.frame(ISO3 = CountryCode[,3], Country = CountryCode[,1])
lifeCountry <- merge(lifeCountry, CodeContinent[,c(3,6)], by.x = "ISO3", by.y="a.3")
lifeCountry <- merge(lifeCountry, GDPVD_CAP, by = "ISO3", all.x = TRUE)
lifeCountry <- merge(lifeCountry, GDP, by = "Country")
lifeCountry <- merge(lifeCountry, population[,c(2,6)], by.x="Country", by.y="Country.or.area")
lifeCountry <- merge(lifeCountry, LifeExpectancy, by="Country")
colnames(lifeCountry)[5:6] <- c("GDP_per_Capita","Population")
lifeCountry$Country        <- as.character(lifeCountry$Country)
lifeCountry$GDP_per_Capita <- as.numeric(sub(",","",lifeCountry$GDP_per_Capita))
lifeCountry$Population     <- as.numeric(sub(",","",(sub(",","",lifeCountry$Population))))
lifeCountry <- lifeCountry[-which(is.na(lifeCountry$GDP_per_Capita)),]
lifeCountry <- lifeCountry[-which(is.na(lifeCountry$Population)),]
write.csv(lifeCountry, "data/lifeCountry.csv")
lifeCountry <- read.csv("data/lifeCountry.csv", stringsAsFactors = FALSE)[,-1]



# sapply(lifeCountry, class)
# sapply(lifeCountry, function(x) which(is.na(x)))

lifeCountry <- lifeCountry[lifeCountry$Population>=1000000,]
lifeCountry <- lifeCountry[lifeCountry$GDP_per_Capita>=5000,]

library(ggplot2)
ggplot(lifeCountry, 
       aes(x=log(GDP_per_Capita), y=Life.Expectancy, size=Population)) + 
  geom_point(aes(color=Continent)) +
  geom_text(aes(label=Country), size=3, vjust=1.5) + 
  geom_smooth(method='lm', se=TRUE)




+
  geom_smooth(aes(group=Continent, color=Continent), method='lm', se=FALSE)


