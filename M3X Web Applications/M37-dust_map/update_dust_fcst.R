rm(list=ls())
options(stringsAsFactors = FALSE)
library(tidyverse)

# Prepare query 
url <- 'http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMinuDustFrcstDspth'
svc_key <- "athSwG16TabsGNW4800qCKe%2Fn2IV47bKvlLPYrz3JB8r8PQfql5GPoQgs6faR99yx1OcDpDtHATDKBoER29TuA%3D%3D"
fields <- c("ServiceKey", "searchDate")
values <- c(svc_key, as.character(Sys.Date()))
request <- paste(fields, values, sep = "=") %>% paste(collapse = "&") %>% paste0("&_returnType=json")
query <- paste0(url, "?", request)

# Load raw data and filter
raw <- readLines(query, encoding = "UTF-8", warn = FALSE) %>% str_split("[[{]]") %>% unlist()
raw <- raw[str_detect(raw, "f_data_time")] %>% tail(-1) %>% head(-1)
f_dt_end <- str_locate(raw[1], "f_data_time")[,2] %>% as.numeric()
f_dts <- rep(0, length(raw))
for (i in 1:length(raw)) {
  f_dts[i] <- raw[i] %>% substr(f_dt_end + 4, f_dt_end + 13) %>% as.numeric()
}
raw <- raw[f_dts == max(f_dts)]

# Preprocessing 1
dataset <- data.frame(stringsAsFactors = FALSE)
for (i in 1:length(raw)) {
  raw_i <- raw[i] %>% str_split(",") %>% unlist()
  idx0 <- raw_i %>% str_split(":") %>% lapply(function (x) str_detect(x, paste0("f_data_time"))) %>% lapply(any) %>% unlist() %>% which() %>% head(1)
  # idx1 <- raw_i %>% str_split(":") %>% lapply(function (x) str_detect(x, paste0("f_inform_data"))) %>% lapply(any) %>% unlist() %>% which()
  # idx2 <- raw_i %>% str_split(":") %>% lapply(function (x) str_detect(x, paste0("informCause"))) %>% lapply(any) %>% unlist() %>% which()
  idx3 <- raw_i %>% str_split(":") %>% lapply(function (x) str_detect(x, paste0("informCode"))) %>% lapply(any) %>% unlist() %>% which()
  idx4 <- raw_i %>% str_split(":") %>% lapply(function (x) str_detect(x, paste0("informData"))) %>% lapply(any) %>% unlist() %>% which()
  idx5 <- raw_i %>% str_split(":") %>% lapply(function (x) str_detect(x, paste0("informGrade"))) %>% lapply(any) %>% unlist() %>% which()
  idx6 <- raw_i %>% str_split(":") %>% lapply(function (x) str_detect(x, paste0("informOverall"))) %>% lapply(any) %>% unlist() %>% which()
  msg_i <- NULL
  msg_i$f_data_time    <- raw_i[[idx0]] %>% str_split(":") %>% unlist() %>% tail(1)
  # msg_i$f_inform_data <- raw_i[[idx1]] %>% str_split(":") %>% unlist() %>% tail(1)
  # msg_i$informCause   <- raw_i[[idx2]] %>% str_split(":") %>% unlist() %>% tail(1)
  msg_i$informCode    <- raw_i[[idx3]] %>% str_split(":") %>% unlist() %>% tail(1)
  msg_i$informData    <- raw_i[[idx4]] %>% str_split(":") %>% unlist() %>% tail(1)
  msg_i$informOverall <- raw_i[[idx6]] %>% str_split(":") %>% unlist() %>% tail(1)
  msg_i$informGrade   <- raw_i[idx5:(idx6-1)] %>% paste(collapse = ",")
  msg_i$informGrade   <- substr(msg_i$informGrade, nchar(msg_i$informGrade)-155, nchar(msg_i$informGrade))
  dataset <- rbind(dataset, msg_i)
}

announce_date <- substr(dataset$f_data_time[1], 2, 9) %>% as.Date("%Y%m%d")
dataset$informData <- as.Date(substr(dataset$informData, 2, 11))
dataset <- dataset %>%
  mutate(day = paste0("day", informData - announce_date)) %>% 
  arrange(day, informCode)

# Preprocessing 2
announce_hour <- substr(dataset$f_data_time[1], 10, 11)
msgs <- dataset %>% group_by(day, informData) %>%
  summarise(msg = paste(unique(informOverall), collapse = "seperator"))
for (i in 1:nrow(dataset)) {
  area <- dataset[i, "informGrade"] %>% str_split(pattern = ",") %>% unlist() %>%
    sapply(function(x) unlist(str_split(x, " : "))[1])
  value <- dataset[i, "informGrade"] %>% str_split(pattern = ",") %>% unlist() %>%
    sapply(function(x) unlist(str_split(x, " : "))[2]) %>% str_replace('"', '')
  value_i <- data.frame(area, value)
  names(value_i)[2] <- 
    paste(dataset$day[i], dataset$informCode[i], sep = "_") %>% 
    str_replace_all('"', '')
  if (i==1) {
    values <- value_i
  } else {
    values <- left_join(values, value_i)
  }
}
values <- left_join(values, read.csv("kr_latlon.csv")) 
values <- values %>% select_if(~ !any(is.na(.)))
# Preprocessing 3
for (dayx in c("day0", "day1")) {
  data <- values %>% select(starts_with(dayx)) %>% t()
  ID <- rownames(data) %>% str_replace(paste0(dayx, "_"), "")
  values$msg_x <- paste(
    values$area, 
    apply(data, 2, function(x) paste(ID, x, sep = ":")) %>% 
      apply(2, function(x) paste(x, collapse = ", ")),
    sep = " ")
  colnames(values)[ncol(values)] <- dayx
  values$code_x <- 
    apply(data, 2, 
          function(x) ifelse(sum(x=="나쁨")>0, "나쁨", 
                             ifelse(sum(x=="보통")>0, "보통", "좋음")))
  colnames(values)[ncol(values)] <- paste0(dayx, "_code")
}
save.image(file = "dust_fcst.Rdata")
