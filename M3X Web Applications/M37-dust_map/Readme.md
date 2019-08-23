# 미세먼지 예보 프로그램

## About
+ 가장 최근에 발표된 미세먼지 예보 API에 접근
+ 오늘과 내일의 미세먼지 예보를 지도에 표시
+ R 코드를 이용해 지도에 표시된 html 대시보드를 이메일로 전송

## Files
+ `kr_latlon.csv`: 우리나라 주요도시의 위경도 정보
+ `update_dust_fcst.R`: API로 데이터에 접근하고 전처리하여 `dust_fcst.Rdata`에 저장
+ `dust_map.Rmd`: 저장된 데이터 `dust_fcst.Rdata`를 이용하여 html 파일 rendering
+ `dust_map_slide.Rmd`: 저장된 데이터 `dust_fcst.Rdata`를 이용하여 xaringan으로 rendering
+ `dust_map_fd.Rmd`: 저장된 데이터 `dust_fcst.Rdata`를 이용하여 flexdashboard로 rendering
+ `render_sendmail.R`: 실행시에 아래 작업을 수행
    1. `update_dust_fcst.R`을 실행하여 `dust_fcst.Rdata`를 업데이트
    2. `dust_map_fd.Rmd`를 이용해 `dust_map_fd.html`을 rendering 
    3. `mailR` package를 이용해 `dust_map_fd.html`를 첨부파일로 하는 이메일을 보냄
    4. `taskscheduleR`패키지를 이용하면 정기적으로 메일을 보내는 것이 가능
    
## Issue
+ 이메일을 모바일에서 확인하였을 때에는 지도가 그려지지 않음
+ 지도 제공하는 source를 바꾸면 될지도 모른다는 생각
+ 모바일 웹브라우저에서도 팝업이 될지는 미지수
+ Javascript를 이용해야 하나?
+ 안타깝게도 현재로선 R의 `leaflet` package에 대해서 모바일 환경에서의 작동에 관해서는 discussion이 활발하지 않음

## `LeafLet` 사용예제

```
library(dplyr)
library(leaflet)
ls <- leaflet() %>% addTiles() %>%
  setView(lng = 127, lat = 37.5, zoom = 11) %>%
  addMarkers(lng = 127.028, lat = 37.499, popup="Learning Spoons")
ls
```
