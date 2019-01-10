#### 1. grep의 결과로서 `bool2=1` 이 도출되었는데, `as.character(bool2) = "TRUE'` 가 바로 도출될 수 있나요?  

A. grep 함수는 R이 개발되고 상당히 초반에 나온 "고전"함수입니다. 그런 이유에서 `TRUE`이면 `1`로, `FALSE`이면 `0`으로 함수의 output을 반환합니다.  

`var1 <- grep(pattern='el', x='Hello World')`    
`var1`  
`[1] 1`  

+ 그렇기 때문에 `var1`은 그냥 숫자에 해당하고요. 아래는 당연한 결과가 되겠죠?   
+ `var1`을 logical인 `TRUE`로 변환시켜서 사용하고 싶다면 `as.logical(var1)` 이렇게 사용하면 되고,   
+ `var1`을 string인 `"TRUE"`로 변환시켜서 사용하고 싶다면 `as.character(as.logical(var1))` 이렇게 사용하시면 됩니다.  

#### 2. Problem7 및 'Date Type 변환'과 관련하여 이해가 다소 어렵습니다.  

`as.Date(aprilFool)`   

`## [1] "2018-04-01"`  

`class(aprilFool)`  

`## [1] "character" => "Date"` 가 나올 줄 알았는데 여전히 "character" 인 점  

`## [1] "ANS: Whoops! We have not assign conversion to the variable!"` => 이 부분에 대해 설명을 듣고 좀 더 공부해야할 것 같습니다.  

+ `as.Date(aprilFool)`를 실행하면 `aprilFool`을 `Date`객체로 바꾸어 "출력"을 합니다.    
+ `aprilFool <- as.Date(aprilFool)`을 실행해야지 `aprilFool`이 `Date`객체로 "바꾸어" 집니다.     
+ 이 과정에서 화살표 오른쪽의 `as.Date(aprilFool)`이 `aprilFool`로 할당("assign")되기 때문에 그렇습니다.    
+ 위의 예제는 이에 관해서 약간 꼬아놓은 문제입니다.    

#### 3. Problem 8 과 관련하여, `as.character(bool2))` will give "FALSE TRUE"  
`"TRUE"` 가 나오려면 `as.logical(bool2)` 아닌가요? `as.character(bool2) = "1"` 이라고 생각했습니다.  

+ `as.logical(bool2)`를 입력하면 `TRUE`라고 나오고 `as.character(bool2)`를 입력하면 `"TRUE"`라고 나옵니다. (`character`객체는 따옴표가 같이 나옵니다.)  
+ `as.numeric(bool2)`를 입력하면 `1`이 나옵니다.  
+ 따옴표를 관찰하시면 차이를 확인하실 수 있을 것입니다.  

