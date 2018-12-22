# R로 시작하는 데이터 분석 및 시각화    

+ 부제: 마케팅/영업/기획/매출관리 직무가 무엇이든 데이터 분석은 필수    
+ https://github.com/LearningSpoonsR/LS-DS (강의 페이지) 
+ https://www.facebook.com/groups/440130033101009/ (비공개 그룹 - 가입신청 해주세요)
+ 일정    
  + 2018.12.23 ~ 2019.01.27 (5회)     
  + **2018.12.30 휴강**     
  + 매주 일요일 10:30 ~ 13:30  
  + 2018.12.23, 2019.1.6, 2019.1.13, 2019.1.20, 2019.1.27   
+ 코스매니저: 김형종 (출결등 기타)  
+ 강사이메일: `learningSpoonsR@gmail.com`  

# 모듈 소개  

## 수업 순서  
M41->  
M11 -> M12 -> M13 ->    
M21 -> M22 -> M23 -> (M24, M25, M26, M27) ->    
(M31) -> M32 -> M33 -> (M34, M35) ->   
M42 -> M43 -> M44 -> M45 ->  
M51 -> M52 -> M53 -> M54 -> M55    

## M1X: Introduction & Basics    
  
|     | 제목    | 관련 packages | Description |      
| ----|:-------:|:------:|:-----------:|    
| M11 | intro   |             | 강의 계획서. Data Science와 R 프로그램에 대해 소개합니다. |  
| M12 | base    | `base`      | Data Type과 Data Structure에 대해서 논의합니다. |  
| M13 | Quiz 1  | `rmarkdown` | M12 review (`.docx`) |  
  
## M2X: The First Project - Carseat Sales    

+ 사용하기 편한 간단한 패키지들을 학습합니다. 
+ Carseats Sales 데이터를 이용해서 `rmarkdown`으로 작성된 report를 만듭니다.

|     | 제목    | 관련 packages | Description |      
| ----|:-------:|:------:|:-----------:|    
| M21 | flow    | `dplyr`, `ggplot2`, `rmarkdown`, `ISLR` | `ISLR`의 `Carseats` 매출데이터로 자료 처리, 시각화, 문서화의 전 과정을 다룹니다. |  
| M22 | CarseatsReport | `rmarkdown` (`.html`, `.docx`, `.pdf`) | 실제로 분석 결과를 보고서로 작성합니다. |  
| M23 | More on `ggplot2` | `ggplot2` | 시각화 기법에 대해서 좀 더 깊이있게 다룹니다. |  
| M24 | `ggplot2` Gallery | `ggplot2` | 사용성이 높은 `ggplot2`를 이용한 아름다운 시각화 예제를 살펴봅니다. |
| M25 | `.pdf` | `rmarkdown`, texlive | 한글로 된 pdf문서를 작성할 수 있는 템플릿입니다. `M22`에 pdf 조판을 위한 textlive 프로그램 설치 과정을 진행해야 합니다. |
| M26 | `beamer` | `rmarkdown`, texlive | 한글로 된 프리젠테이션 문서(수업 강의노트)를 작성할 수 있는 템플릿입니다. `M22`에 pdf 조판을 위한 textlive 프로그램 설치 과정을 진행해야 합니다. |
| M27 | `slidy` | `rmarkdown` | `rmarkdown`을 사용하면 손쉽게 `.html`로 된 프리젠테이션 문서를 만들 수 있습니다. 이에 해당하는 `slidy` 포맷의 템플릿입니다. |   

## **M3X** 부터는 dependency가 없습니다.  

+ 즉, M1X와 M2X까지를 익숙하게 다룰 수 있다면 M3X이후에는 모듈 각각에 대해서 독립적으로 이해하고 사용할 수 있습니다.  

## M3X: Textmining & Web Applications  

+ Textmining 기법(워드클라우드, 크롤링, 번역)에 대한 예제를 제공합니다.  
+ Flexdashboard와 Shiny Application으로 구현해 봅니다.  

|     | 제목    | 관련 packages | Description |      
| ----|:-------:|:------:|:-----------:|    
| M31 | I have a dream  | `tm`, `KONLP`, `wordcloud`, function | 마틴루터킹 목사의 "I have a dream"에 대해 Wordcloud 분석을 하고, 이를 다양한 텍스트 파일 포맷과 한/영 문서에 대해서도 일반화 시킵니다. |  
| M32 | `flexdashboard` | `flexdashboard`, `rmarkdown` | `rmarkdown`을 다룰수 있다면 손쉽게 이를 `.html`의 대시보드로 제작할 수 있습니다. 이는 반응형 대시보드(사용자의 마우스/키보드 동작에 반응)로 연장되는 `shiny` 패키지의 기본이 됩니다. |    
| M33 | `shiny` on fd | `shiny`, `flexdashboard`, `rmarkdown` | `flexdashboard`와 `rmarkdown`을 다룰수 있다면 손쉽게 반응형 대시보드(사용자의 마우스/키보드 동작에 반응)또한 구현할 수 있습니다. `shiny`는 빠른 시간에 구현할 수 있는, elegant하고 professional한 프리젠테이션 기법이 됩니다. |  
| M34 | Happy B-day, `ggplot` | `rvest`, `googleLanguageR` | `ggplot2`는 최근 10년에 걸쳐 데이터 시각화의 혁신을 가져왔습니다. 이에대한 영문 article을 web crawling하여 google 번역기를 이용해서 자동번역하는 프로그램을 제작합니다. |  
| M35 | R and Python are joining | `rvest`, `googleLanguageR` | 위의 **M34**와 같은 프로그램입니다. 데이터 사이언스에 있어서 R와 Python의 장단점과 둘의 융합이라는 트렌드에 대한 article을 역시 web crawling으로 얻어와 google 번역기를 자동으로 실행시켜 한글 문서로 제작합니다. |  

## M4X: Case Studies - Data Analysis  

|     | 제목    | 관련 packages | Description |      
| ----|:-------:|:------:|:-----------:|    
| M41 | longevity | `shiny` |  |    
| M42 | subway    |   |  |    
| M43 | retail    |   |  |  
| M44 | SNS       |   |  |  
| M45 | 전표분석   |   |  |  

## M5X: Other Advanced Applications  

|     | 제목    | 관련 packages | Description |          
| ----|:-------:|:------:|:-----------:|        
| M51 | tidyr       | `tidyr`, SQL     |  |        
| M52 | Time Series | `xts`, `dygraph`, `lubridate` |  |      
| M53 | python      | `feather`        |  |    
| M54 | KMA & Auto  | `jsonlite`, `mailR`, `taskscheduleR`|  |  
| M55 | Outtro      |   |   |  

## M6X: References  

| 폴더 | Description |           
| ---- |:-----------:|          
| Book        |   |          
| Cheatsheets |   |        
| Dr. Hadley  |   |  

---------------------------------------------------------------------




