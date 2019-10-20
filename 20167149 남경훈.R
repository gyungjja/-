library(ggplot2)
args(geom_point)
args(geom_histogram)
args(geom_bar)

setwd("C:/Users/Administrator/Desktop/한림대/4-1학기/데이터시각화/lab9")
#파일 1. 경기도 물놀이형 수경시설 수질검사 현황.
water <- read.csv("경기도 물놀이형 수경시설 수질검사 현황.csv",fill=T,header=T)
str(water)

#x축은 탁도(물이 흐린 정도.)의 값 y축은 PH의 값 (물의 산성이나 알칼리성의 정도를 나타내는 수치)
#을 넣어서 탁도의 값에 따른 PH를 나타낸 (컬러는 시군구명기준) scatter plots입니다.
ggplot(water) +
  geom_jitter(aes(x = 탁도.4NTU이하. , y = PH.5.8.8.6. , color = 시군명))


#파일 2. 2016년도 민방위 훈련일정
training <- read.csv("2016년도 민방위 훈련일정.csv", fill = T, header = T)
str(training)

#x축 훈련시작시간 y축 훈련종료시간으로 설정을하여 나타낸 scatter plots입니다.
ggplot(training) + 
  geom_jitter(aes(x = 훈련시작시간, y = 훈련종료시간, color = 훈련대상))

#파일 3. 서울특별시 은평구 장애인현황 
file3 <- read.csv("서울특별시 은평구 장애인현황.csv")
str(file3)

#1급 남성과 1급여성에 대한 장애유형과 인원수를 나타낸 scatter plots 입니다.
ggplot(file3) +
  geom_jitter(aes(x = X1급남성 , y = X1급여성, color = 장애유형, drv = ))

#파일 4. 경기도 부천시 지하철승하차 현황

file4 <- read.csv("경기도_부천시_지하철승하차현황_20180930.csv", fill = T , header = T)
str(file4)
#기간에 따른 부천종합운동장역에 승차를 한 인원에 대한 scatter plots 입니다.
ggplot(file4) +
  geom_jitter(aes(x = 기간 , y = 부천종합운동장역.승차 ))

#파일 5 . 한국수자원공사 수문제원현황.
#유역면적에 따른 총저수용량을 나타낸 scater plot 입니다.

file5 <- read.csv("한국수자원공사 수문제원현황(20180426).csv", fill = T, header = T)
str(file5)

ggplot(file5) + 
  geom_jitter(aes(x = 유역면적 , y = 총저수용량,color = 하천 ))
