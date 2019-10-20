getwd()
setwd("C:/Users/Administrator/Desktop/한림대/4-1학기/데이터시각화/20167149")
install.packages("data.table")
install.packages("readr")
library(data.table)
library(readr)
readr::guess_encoding(file = "2013년_서울_주요구별_병원현황.csv")
data <- fread(file = "2013년_서울_주요구별_병원현황.csv", header = T, stringsAsFactors = F)
head(data, 20)
str(data)
as.matrix(data[1:9, 2:11])
barplot(as.matrix(data[1:9, 2:11]))
barplot(as.matrix(data[1:9, 2:11]), beside = T, las = 2, col = rainbow(9), ylim = c(0,350), 
        ylab = "병원수", xlab = "구명",
        main = paste0("서울시 주요 구별 과목별 병원현황","\n","출처[국민건강보험공단]"))

legend("topright", data$표시과목, fill = rainbow(9), cex = 0.9)
library(dplyr)
library(stringr)
data2 <- fread(file = "연도별요양기관별보험청구건수_2001_2013.csv", header = T, stringsAsFactors = F, data.table = F) %>% as_tibble()
str(data2)
data2_convert <- data2 %>% select(-종류) %>% lapply(X = ., FUN = function(x){
  str_replace_all(string = x, pattern = ",", replacement = "") %>% as.integer()
}) %>% bind_rows() %>% t()  # 행열 치환 및 , 제거 후 integer로 type 변경 
colnames(data2_convert) <- data2$종류
data2_convert
plot(data2_convert[,1]/100000) # 2004년도의 상급종합병원 그래프
set.seed(98)
colors <- colors()[sample(1:100, size = 10)] # sample을 이용한 무작위 추출

plot(data2_convert[,1]/100000, axes = F, xlab = "", ylab = "",col = colors[1], type = "o", lwd = 2, 
     main = paste0("연도별 요양 기관별 보험 청구 건수(단위:십만건)","\n","출처[국민건강보험공단]"),
     ylim = c(0,10000))
axis(1, at = 1:10, labels = rownames(data2_convert), las = 2) # x축 설정
axis(2, las = 2) # y축 설정

for(index in 2:ncol(data2_convert)){ # line 추가
  lines(data2_convert[,index]/100000, type = "o", col = colors[index],lwd = 2)
}
legend("topleft", colnames(data2_convert), fill = colors, cex = 0.8, lwd = 2)

#과제 1-(1)
x11()
#2행 5열 로 분할
par(mfrow = c(2,5))
#막대그래프로 각 데이터의 열을 추출하여 막대그래프 표현.
barplot(as.matrix(data$강남구), beside = T, las = 2, col = rainbow(9), ylim = c(0,400),
        ylab = "병원수", names.arg = data$표시과목,
        main = paste0("강남구 병원현황","\n20167149_남경훈"))
barplot(as.matrix(data$강동구), beside = T, las = 2, col = rainbow(9), ylim = c(0,400),
        ylab = "병원수", names.arg = data$표시과목,
        main = paste0("강동구 병원현황","\n20167149_남경훈"))
barplot(as.matrix(data$강서구), beside = T, las = 2, col = rainbow(9), ylim = c(0,400),
        ylab = "병원수", names.arg = data$표시과목,
        main = paste0("강서구 병원현황","\n20167149_남경훈"))
barplot(as.matrix(data$관악구), beside = T, las = 2, col = rainbow(9), ylim = c(0,400),
        ylab = "병원수", names.arg = data$표시과목,
        main = paste0("관악구 병원현황","\n20167149_남경훈"))
barplot(as.matrix(data$구로구), beside = T, las = 2, col = rainbow(9), ylim = c(0,400),
        ylab = "병원수", names.arg = data$표시과목,
        main = paste0("구로구 병원현황","\n20167149_남경훈"))
barplot(as.matrix(data$도봉구), beside = T, las = 2, col = rainbow(9), ylim = c(0,400),
        ylab = "병원수", names.arg = data$표시과목,
        main = paste0("도봉구 병원현황","\n20167149_남경훈"))
barplot(as.matrix(data$동대문구), beside = T, las = 2, col = rainbow(9), ylim = c(0,400),
        ylab = "병원수", names.arg = data$표시과목,
        main = paste0("동대문구 병원현황","\n20167149_남경훈"))
barplot(as.matrix(data$동작구), beside = T, las = 2, col = rainbow(9), ylim = c(0,400),
        ylab = "병원수", names.arg = data$표시과목,
        main = paste0("동작구 병원현황","\n20167149_남경훈"))
barplot(as.matrix(data$마포구), beside = T, las = 2, col = rainbow(9), ylim = c(0,400),
        ylab = "병원수", names.arg = data$표시과목,
        main = paste0("마포구 병원현황","\n20167149_남경훈"))
barplot(as.matrix(data$서대문구), beside = T, las = 2, col = rainbow(9), ylim = c(0,400),
        ylab = "병원수", names.arg = data$표시과목,
        main = paste0("서대문구 병원현황","\n20167149_남경훈"))
dev.off()



#과제 1-(2)
x11()
#subset으로 특정열 삭제 
data2_convert <- subset(data2_convert, select =-c(의원))
data2_convert

set.seed(98)
colors <- colors()[sample(1:100, size = 10)] # sample을 이용한 무작위 추출
#data2_convert[,1]/100000
plot(data2_convert[,1]/10000, axes = F, xlab = "", ylab = "",col = colors[1], type = "o", lwd = 2, 
     main = paste0("연도별 요양 기관별 보험 청구 건수(단위:만건)","\n","20167149_남경훈"),
     ylim = c(0,10000))
axis(1, at = 1:10, labels = rownames(data2_convert), las = 2) # x축 설정
axis(2, las = 2) # y축 설정

for(index in 2:ncol(data2_convert)){ # line 추가
  lines(data2_convert[,index]/10000, type = "o", col = colors[index],lwd = 2)
}
legend("topleft", colnames(data2_convert), fill = colors, cex = 0.8, lwd = 2)

dev.off()

##과제2
## 2.공공데이터포털의 데이터를 이용한 그래프 생성(그래프, 소스, 설명 첨부)
##정형데이터 그래프(1)
##데이터를 읽어와서 데이터의 인코딩형식을 추론
readr::guess_encoding(file = "2012년_1당사자_법규위반별_주야별_교통사고.csv")
#data <- read.csv("2012년_1당사자_법규위반별_주야별_교통사고.csv", header = T)
#데이터 읽어오기
data <- fread(file = "2012년_1당사자_법규위반별_주야별_교통사고.csv", header = T, stringsAsFactors = F)
#데이터의 상위 20개 추출
head(data, 20)
#데이터의 타입보기
str(data)
x11()
#1~9행,3~8열까지 행렬로 바꿈
as.matrix(data[1:9,3:8])
#막대그래프로 나타냄
barplot(as.matrix(data[1:9, 3:8]))
#막대그래프에 y축의 값과 주제,색상을 나타냄
barplot(as.matrix(data[1:9, 3:8]), beside = T, las = 2, col = rainbow(9), ylim = c(0,20000), 
        ylab = "통계",xlab = "사고후 인명",
        main = paste0("2012년_1당사자_법규위반별_주야별_교통사고.csv","\n","출처[공공데이터포털]","\n20167149_남경훈"))
#범례를 추가
legend("topright", data$법규위반, fill = rainbow(9), cex = 0.4)
dev.off()
##정형데이터 그래프(2)
library(dplyr)
library(stringr)
data2 <- fread(file = "2012년_1당사자_법규위반별_주야별_교통사고.csv", header = T, stringsAsFactors = F, data.table = F) %>% as_tibble()
str(data2)
#데이터의 법규위반과 주야의 속성을 제거.
data2_convert <- data2 %>% select(-법규위반,-주야) %>% lapply(X = ., FUN = function(x){
  str_replace_all(string = x, pattern = ",", replacement = "") %>% as.integer()
}) %>% bind_rows() %>% t()  # 행열 치환 및 , 제거 후 integer로 type 변경 
colnames(data2_convert) <- data2$법규위반
data2_convert
plot(data2_convert[,1]/100) #100건으로 나누어 나타냄

#시드값 설정
x11()
set.seed(98)
colors <- colors()[sample(1:100, size = 10)] # sample을 이용한 무작위 추출
#데이터를 1000건으로 나누어서 그림, y축은 0~50, 색상추
plot(data2_convert[,1]/1000, axes = F, xlab = "", ylab = "",col = colors[1], type = "o", lwd = 2, 
     main = paste0("2012년_1당사자_법규위반별_주야별_교통사고.csv","\n","출처[공공데이터포털]","\n20167149_남경훈"),
     ylim = c(0,50))
axis(1, at = 1:6, labels = rownames(data2_convert), las = 2) # x축 설정
axis(2, las = 2) # y축 설정

for(index in 2:ncol(data2_convert)){ # line 추가
  lines(data2_convert[,index]/1000, type = "o", col = colors[index],lwd = 2)
}
legend("topleft", colnames(data2_convert), fill = colors, cex = 0.4, lwd = 2)
dev.off()
