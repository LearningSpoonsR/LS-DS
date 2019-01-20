## 참고: 그림크기 조정 (2019-01-20 추가)

1. R chunk에서 rendering 되는 그림의 크기 조정   
    + Chunk control 부분에서 크기 지정 (인치 단위로)       
    + `{r, fig.width = 7, fig.height = 2}`  
    
2. Markdown chunk에서 그림을 첨부하면서 크기 조정  
    + 아래와 같이 입력 (`rmarkdown` Cheatsheet 참고하세요!)  
    + `![](fig.png){width=400px, height=300px}\`  
