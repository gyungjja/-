install.packages("rmarkdown")
install.packages("knitr")
library(rmarkdown)
library(knitr)
#[벡터형 연습문제]
#1.seq()함수를 상용하여 
#date4라는 변수에 
#2015년 1월 1일 부터 2015년 1월 31일까지 
#1일씩 증가하는 31개의 날짜를 입력하는 방법을 쓰세요.
date4 <- seq(from=as.Date('2015-01-01'),
             to=as.Date('2015-01-31'),by=1)
date4

#2.아래 그림과 같이 vec1을 생성하세요.
vec1 <- c('사과','배','감','버섯','고구마')
vec1
#위의 vec1 에서 3번째 요소인 '감'을 제외하고 vec1읭 값을 출력하세요.
vec1[-3]

#3.아래그림과 같이 vec1과 vec2를 만드세요.
vec1 <- c('봄','여름','가을','겨울')
vec2 <- c('봄','여름','늦여름','초가을')
#1)vec1과 vec2 내용을 모두 합친 결과를 출력하는 코드를 쓰세요.
union(vec1,vec2)
#2)vec1 에는 있는데 vec2에는 없는 결과를 출력하는 코드를 쓰세요
setdiff(vec1,vec2)
#3)vec1과 vec2 모두 있는 결과를 출력하는 코드를 쓰세요.
intersect(vec1,vec2)

#[Matrix 형 연습문제]
#1.아래 그림과 같은 형태의 행렬을 만드세요.
seasons <- matrix(c('봄','여름','가을','겨울'),nrow=2)
seasons
seasons <- matrix(c('봄','여름','가을','겨울'),nrow=2,byrow=T)
seasons
#2.아래 그림과 같이 seasons 행렬에서 여름과 겨울만 조회하는 방법을 쓰세요.
seasons[,2]
#아래 그림과 같이 seasons 행렬에 3번 행을 추가하여 seasons_2 행렬을 만드세요.
seasons_2 <- rbind(seasons,c('초봄','초가을'))
seasons_2
#아래 그림처럼 seasons_2 변수에 열을 추가하여 seasons_3 행렬을 만드세요.
seasons_3 <- cbind(seasons_2,c('초여름','초겨울','한겨울'))
seasons_3
