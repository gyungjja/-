setwd("C:/Users/Administrator/Desktop/한림대/4-1학기/데이터시각화/4차이론과제")
getwd()
library(ggmap)
library(stringr)
library(grid)
x11()
dev.off()
#전국 공중화장실 데이터에서 거주지에 해당하는 속초에 대한 지도그래프.
loc <- read.csv("전국공중화장실표준데이터.csv",header = T)
loc
#거주지에 관한 구글 지도맵
kd <- get_map("Sokcho",zoom=13, maptype = "roadmap")
#경도와 위도를 설정해주고 빨강색 점으로 나타냄
kor.map <- ggmap(kd)+geom_point(data=loc, aes(x=경도, y=위도),
                                 size=3,alpha=0.7,color="red")
#데이터의 라벨을 지정(화장실명)
kor.map + geom_text(data=loc, aes(x = 경도, y = 위도+0.001, label=화장실명),size=3) +
  ggtitle("속초시의 공중화장실 현황_20167149 남경훈")
#화장실명에서 1번째 인덱스 2번째 인덱스만 추출
loc2 <- str_sub(loc$화장실명,start=1,end=2)
loc2
#for문을 이용한 색 지정 속초이면 빨강 영랑이면 파랑 나머지는 노랑
colors <- c()
for ( i in 1:length(loc2)) {
  if (loc2[i] == '속초' ) {
    colors <- c(colors,"red") }
  else if(loc2[i] == '영랑') { 
    colors <- c(colors,"blue") }
  else{
    colors <- c(colors,"yellow")}
  }
kd <- get_map("Sokcho",zoom=13, maptype = "roadmap")

kor.map <- ggmap(kd)+geom_point(data=loc, aes(x=경도, y=위도),
                                size=3,alpha=0.7,color=colors)
kor.map + geom_text(data=loc, aes(x = 경도, y = 위도+0.001, label=화장실명),size=3) +
  ggtitle("속초시의 공중화장실 현황_20167149 남경훈")

#전국 무료와이파이표준데이터

wifi <- read.csv("전국무료와이파이표준데이터.csv",header=T)
wifi

#춘천무료와이파이 설치 현황
#춘천으로 설정을 하여 구글 지도맵을 설정
s_m <- get_map("chuncheon", zoom=13, maptype="roadmap")
#경도 위도 설정 점 모양의 #980000 색상 설정
chuncheon.map <- ggmap(s_m) + geom_point(data=wifi, aes(x=경도, y=위도), size=2, 
                                      alpha=0.7, color="#980000") 
chuncheon.map +
  ggtitle("춘천시 무료와이파이 설치현황_20167149 남경훈")
#서비스제공사명이라는 컬럼에서 첫번째 두번째 인덱스까지 추출
loc2 <- str_sub(wifi$서비스제공사명,start=1,end=2)
loc2
#반복문으로 색상 설정
colors <- c()
for ( i in 1:length(loc2)) {
  if (loc2[i] == 'KT' ) {
    colors <- c(colors,"red") }
  else if(loc2[i] == 'SK') { 
    colors <- c(colors,"blue") }
  else{
    colors <- c(colors,"yellow")}
}
s_m <- get_map("chuncheon", zoom=15, maptype="roadmap")
chuncheon.map <- ggmap(s_m) + geom_point(data=wifi, aes(x=경도, y=위도), size=2, 
                                         alpha=0.7, color=colors)
chuncheon.map + geom_text(data=wifi, aes(x = 경도, y = 위도+0.001, label=서비스제공사명),size=3) +
  ggtitle("춘천시 무료와이파이 설치현황_20167149 남경훈")

lon <- wifi$경도
lat <- wifi$위도
data <- wifi$설치장소명
df <- data.frame(lon,lat,data)
df
x11()
dev.off()
map1 <- get_map("seoul",zoom=7 , maptype='roadmap')
map1 <- ggmap(map1)
map1 + geom_point(aes(x=lon,y=lat,colour=data,size=data),data=df)
