Q. grep의 결과로서 `bool2=1` 이 도출되었는데, `as.character(bool2) = "TRUE'` 가 바로 도출될 수 있나요?  

A. grep 함수는 R이 개발되고 상당히 초반에 나온 "고전"함수입니다. 그런 이유에서 `TRUE`이면 `1`로, `FALSE`이면 `0`으로 함수의 output을 반환합니다.  

`var1 <- grep(pattern='el', x='Hello World')`    
`var1`  
`[1] 1`  

+ 그렇기 때문에 `var1`은 그냥 숫자에 해당하고요. 아래는 당연한 결과가 되겠죠?   
+ `var1`을 logical인 `TRUE`로 변환시켜서 사용하고 싶다면 `as.logical(var1)` 이렇게 사용하면 되고,   
+ `var1`을 string인 `"TRUE"`로 변환시켜서 사용하고 싶다면 `as.character(as.logical(var1))` 이렇게 사용하시면 됩니다.  
