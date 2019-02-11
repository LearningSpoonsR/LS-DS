# Infile for Module-dplyr(2)

# options(stringsAsFactors = FALSE)
# 
# table1 <- 
#   data.frame(
#     ISO3  = c("AFG", "AFG", "BRA", "BRA", "CHN", "CHN"),
#     year  = c(1999, 2000, 1999, 2000, 1999, 2000),
#     cases = c(745, 2666, 37737, 80488, 212258, 213766),
#     popul = c(19987071, 201595360, 172006362, 
#               174504898, 1272915272, 1280428583)
#   )
# 
# table2 <- 
#   data.frame(
#     ISO3  = c("AFG", "AFG", "AFG", "AFG", "BRA", "BRA"),
#     year  = c(1999, 1999, 2000, 2000, 1999, 1999),
#     type  = rep(c("cases", "popul"), 3),
#     count = c(745, 19987071, 2666, 201595360, 37737, 172006362)
#   )
# 
# table3 <- 
#   data.frame(
#     ISO3  = c("AFG", "AFG", "BRA", "BRA", "CHN", "CHN"),
#     year  = c(1999, 2000, 1999, 2000, 1999, 2000),
#     rate  = paste0(table1$cases, "/", table1$popul)    
#   )
# 
# table4a <- # cases
#   data.frame(
#     ISO3 = c("AFG", "BRA", "CHN"),
#     `1999` = c(745, 37737, 212258),
#     `2000` = c(2666, 80488, 213766)
#   )
# colnames(table4a)[2:3] <- c(1999, 2000)
# 
# table4b <- # population
#   data.frame(
#     ISO3 = c("AFG", "BRA", "CHN"),
#     `1999` = c(19987071, 172006362, 1272915272),
#     `2000` = c(201595360, 174504898, 1280428583)
#   )
# colnames(table4b)[2:3] <- c(1999, 2000)

df1 <- data.frame(CustomerId = c(1:5), Product = c(rep("Toaster", 3), rep("Radio", 2)))
df2 <- data.frame(CustomerId = c(2, 4, 6), State = c(rep("Seoul", 2), rep("Busan", 1)))


