## 1. avgGDP, avgLIFE 값에 대해 반올림을 하고 싶습니다만, round(data, digits=2) 사용시 data 범위를 설정하는 단계에서 시행착오를 겪고 있습니다

`temp <- dataset %>% group_by(Continent) %>% summarise(avgGDP = mean(GDP_per_Capita), avgLIFE = mean(Life.Expectancy))` 에서 바로 `round`를 적용시킬 순 없나요?

+ `avgLIFE` 보다는 `avgLife`라고 쓰는것 추천드립니다. (낙타 혹 같이 생겼다고 해서 Camel 표기법이라고 해요)
+ `avgGDP = round(mean(GDP_per_Capita),1)` 이렇게 하면 됩니다.
+ `temp <- dataset %>% group_by(Continent) %>% summarise(avgGDP = mean(GDP_per_Capita), avgLIFE = mean(Life.Expectancy))
+ `temp <- dataset %>% group_by(Continent) %>% summarise(avgGDP = round(mean(GDP_per_Capita),1), avgLIFE = round(mean(Life.Expectancy),1))

## 2. 이외에도 다른 명령들에서 앞에서 summarise의 결과로 도출된 avgGDP, avgLIFE 값을 바로 사용하는데 다소 에러사항이 발생했습니다.  

`avgGDP` 라는 object 를 찾을 수 없다는 경고가 자주 보였는데, summarised figures 은 이후에 독립적인 variable 로 사용할 수 없나요?
별도로 `mutate`를 통해 `data.frame`을 다시 작성해주는 과정이 필요한가요?  

+ `dataset`은 nrow=161, ncol=11 (number of variables = 10)크기의 원래 데이터 셋이고 
+ `temp`는 대륙별로 집계된 6 obs. of  3 variables의 data.frame입니다.
+ 그러므로 `avgGDP`라는 변수는 `temp`에 있습니다.
+ (제가 질문을 정확히 이해했는지 모르겠습니다. 아니라면 다시 질문 주세요!) 
 
## 3. `geom_text` 를 넣는 과정에서 굳이 `x=Continent, y=avgGDP or y=avgLIFE` 를 다시 입력해주어야 하나요?

이 과정없이 단순히 label 으로 바로 넘어가면 오류가 발생했습니다.

`temp <- dataset %>% group_by(Continent) %>% summarise(avgGDP = round(mean(GDP_per_Capita),1), avgLIFE = round(mean(Life.Expectancy),1))`   

`e <- ggplot(data = temp) + geom_col(mapping = aes(x= Continent, y= avgGDP), fill='blue') + geom_text(aes(x= Continent, y=avgGDP, label = avgGDP),vjust=1.5, color ='white')`  

`f <- ggplot(data = temp) + geom_col(mapping = aes(x= Continent,y= avgLIFE), fill= 'red') + geom_text(aes(x= Continent, y=avgLIFE,label = avgLIFE), vjust=1.5, color = 'white')`    

1: e <- ggplot(data = temp) +   
2:  geom_col(mapping = aes(x= Continent, y= avgGDP), fill='blue') +   
3:  geom_text(aes(x= Continent, y=avgGDP, label = avgGDP),vjust=1.5, color ='white')  
4: e2 <- ggplot(data = temp, mapping = aes(x= Continent, y= avgGDP)) +   
5:   geom_col(fill='blue') +   
6:   geom_text(aes(label = avgGDP),vjust=1.5, color ='white')  

+ 실력이 많이 느셔서 상속에 대해서도 시도해 보시려고 하시는군요. 아주 좋습니다. 
+ 1번 라인에서 `ggplot`은 `data`만 가지고 있습니다.
+ 2번 라인에서는 추가로 `aes`의 `x`와 `y`를 지정했고요.
+ 3번 라인에서는 추가로 `aes`의 `x, y, label`을 지정했습니다.
+ 반면,
+ 4번 라인에서는 `ggplot`이 `data`외에 `aes`의 `x`와 `y`를 지정했습니다.
+ 5번 라인에서는 `aes`의 `x`와 `y`를 4번 라인에서 받아와서 사용합니다.
+ 6번 라인에서는 `aes`의 `x`와 `y`를 4번 라인에서 받아와서 사용합니다.
+ 즉, `geom_OBJECT`에서 `aes`의 정보가 missing 되었을 경우에는 상위에 있는 `ggplot`에 지정이 되어있는 `aes`를 사용합니다.  

## 4. 이전에 matrix solving 과 관련하여 여쭤봤던 문제입니다.

정방행렬이 아닌 `m`에 대해 `solve(m,n)`에서 자꾸 square 가 되어야 한다는 경고가 뜹니다 

`m <- matrix(1:6, nrow = 3, ncol = 2)`  
`n <- matrix(7:9, nrow = 3)`  
`solve(m,n)`  
`qr.solve(m,n)`   
 
+ 에러 메시지 Error in solve.default(m, n) : 'a' (3 x 2) must be square로 구글에 검색해서
+ https://stackoverflow.com/questions/30610678/how-to-solve-linear-equations-in-r-with-rectangular-matrix
+ 를 찾았습니다. 
+ 즉, `qr.solve(m,n)`를 사용하면 됩니다.
+ 정방행렬의 경우에는 `m` 매트릭스를 LU decomposition으로 해를 찾고,
+ 직사각행렬의 경우에는 `m` 매트릭스를 QR decomposition해서 해를 찾기에,
+ R에서는 두 가지를 분리해둔 것 같습니다.
+ (프로그램 언어에 따라서 1개로 통합되있는 것이 더 일반적일 수도 있는 경우인것 같네요.)
+ (MATLAB에서는 1개로 통합되어있는 것으로 기업합니다.) 

감사합니다.
