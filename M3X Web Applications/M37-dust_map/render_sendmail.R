# Render
library(rmarkdown)
# rmarkdown::render('dust_map_slide.Rmd', encoding = 'UTF-8')
rmarkdown::render('dust_map_fd.Rmd', encoding = 'UTF-8')

# Send email
library(mailR)
email <- send.mail(
  from = "LearningSpoonsR@gmail.com",
  to   = "LearningSpoonsR@gmail.com",
  subject = paste("Dust forecast", Sys.Date()),
  body = paste("Dust forecast", Sys.Date()),
  # attach.files = "dust_map_slide.html",
  attach.files = "dust_map_fd.html",
  smtp = list(host.name = "smtp.gmail.com", port = 465,
              user.name = "learningspoonsr",
              passwd = readLines("password.txt"),
              ssl = TRUE),
  authenticate = TRUE,
  html = TRUE,
  send = TRUE)
