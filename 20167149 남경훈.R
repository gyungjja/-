x11()
str(iris)
data1 <- iris$Sepal.Length
data2 <- iris$Sepal.Width
data3 <- iris$Petal.Length
data4 <- iris$Petal.Width
head(data1,10)
plot(data1,main = "20167149")
head(data2,10)
plot(data2,main = "20167149")
head(data3,10)
plot(data3,main = "20167149")
head(data4,10)
plot(data4,main = "20167149")
#점의 형태변경 pch
par(mfrow = c(1,4)) #mfrow 를 사용하면 행렬을 주어서 그래프를 그림
plot(data1, pch=2,main = "20167149")
plot(data1, pch=3,main = "20167149")
plot(data1, pch=4,main = "20167149")
plot(data1, pch=5,main = "20167149")
par(mfrow = c(1,4))
plot(data1, pch=6,main = "20167149")
plot(data1, pch=7,main = "20167149")
plot(data1, pch=8,main = "20167149")
plot(data1, pch=9,main = "20167149")
#점의 크기 변경 cex
par(mfrow = c(1,3))
plot(data1, pch = 8, cex = 0.5,main = "20167149")
plot(data1, pch = 8, cex = 1,main = "20167149")
plot(data1, pch = 8, cex = 1.5,main = "20167149")
#엑셀처럼 데이터 확인하기 -> view
#mfrow 그만 사용하려면 dev.off()
dev.off()
#그래프 변형 type
plot(data1, type = "l",main = "20167149") ### 선
plot(data1, type = "b",main = "20167149") ### 점,선
plot(data1, type = "s",main = "20167149") ### 계단식
#그래프 제목 xlab, ylab, main
plot(data1, pch = 8, cex = 1, xlab="xxxxx",main = "20167149") # xlab x축 라벨
plot(data1, pch = 8, cex = 1, xlab="xxxxx", ylab= "yyyyy",main = "20167149") # xlab y축 라벨
plot(data1, pch = 8, cex = 1, xlab="xxxxx", ylab="yyyyy", main = "Hello Plot_20167149") # main 그래프 제목
#가로선 abline(h =)
plot(data1, pch = 8, cex = 1, xlab = "xxxxx", ylab = "yyyyy", main ="Hello Plot_20167149")
abline(h = 7, col="red")#가로선 추가 
#세로선 abline(v =)
plot(data1, pch = 8, cex = 1, xlab = "xxxxx", ylab = "yyyyy", main ="Hello Plot_20167149")
abline(h = 7, col="red")#가로선 추가 
abline(v = 50, col = "red")#세로선 추가
#그래프 색상 변경(col =)
head(colors(), 20) # 600개 이상의 color가 존재 
#그래프 겹치기 par(new = T)
plot(data1, pch=20, cex=1, type="p",xlab="X", ylab="Y", main="Hello Plot_20167149", ylim=c(1,7.5))
par(new = T)
plot(data3,pch=8,cex=1, type="p",xlab="X", ylab="Y",main="Hello Plot_20167149", col="tan3", ylim=c(1,7.5))
#범례 legned
plot(data1, pch=20, cex=1, type="p", xlab="X", ylab="Y", main="Hello Plot_20167149", ylim=c(1,7.5))
par(new = T)
plot(data3, pch=8, cex=1, type="p", xlab="X", ylab="Y", main="Hello Plot_20167149", col="tan3", ylim=c(1,7.5))

legend("bottomright", c("data1","data3"), col=c("black","tan3"),cex=1.5, pch = c(20,8))#범례 설정 

##과제
plot(data1, pch=20, cex=1, type="p", xlab="X", ylab="Y", main="Hello Plot_20167149", ylim=c(1,7.5))
par(new = T)
plot(data2, pch=20, cex=1, type="p", xlab="X", ylab="Y", main="Hello Plot_20167149", col="green", ylim=c(1,7.5))
par(new = T)

plot(data3, pch=8, cex=1, type="p", xlab="X", ylab="Y", main="Hello Plot_20167149", col="tan3", ylim=c(1,7.5))

legend("bottomright", c("data1","data2","data3"), col=c("black","green","tan3"),cex=1.5, pch = c(20,20,8))#범례 설정 

#2.barplot
#hotdog contest 데이터셋
hotdogs <- read.csv("http://datasets.flowingdata.com/hot-dog-contest-winners.csv",sep = ",",header = T, stringsAsFactors = F)
str(hotdogs)
View(hotdogs)
barplot(hotdogs$Dogs.eaten,main = "20167149")
#각 막대에 대한 라벨 추가 names.arg
barplot(hotdogs$Dogs.eaten, names.arg = hotdogs$Year,main = "20167149")
barplot(hotdogs$Dogs.eaten, names.arg = hotdogs$Year, las=2,main = "20167149")#las = 1(default) or las = 2 라벨의 90도 회전 

#축의 라벨,외곽선, 색상, 간격 등
barplot(hotdogs$Dogs.eaten,
        names.arg = hotdogs$Year,
        col = "red", ##색상 설정
        border = F, ##외곽선 설정, T 외곽선 존재
        xlab = "Year", ##x축 라벨
        ylab = "Hotdogs and buns (HDB) eaten", ##y축 라벨
        main = "20167149",
        las = 2) ## x축 라벨 기울기 

#for,if를 이용한 색상 설정
fill_colors = c()
for(i in 1:length(hotdogs$Country)){
  if(hotdogs$Country[i] == "United States"){
    fill_colors = c(fill_colors,"#821122")
  } else {
    fill_colors = c(fill_colors, "#cccccc")
  }
}

fill_colors

barplot(hotdogs$Dogs.eaten,
        names.arg = hotdogs$Year,
        col = fill_colors,
        border = F,
        space = 0.5,
        xlab = "Year",
        ylab = "Hotdogs and buns (HDB) eaten",
        main = "Nathan's Hot Dog Eating Contest Results, 1980-2010_20167149",
        las = 2,
        horiz = T)

legend("bottomright", c("United States", "etc"), fill = c("#821122", "#cccccc"), cex = 1)## 범례 설정 
#과제
barplot(hotdogs$Year,
        names.arg = hotdogs$Winner,
        col = "blue",
        border = F,
        space = 1,
        xlab = "Year",
        ylab = "Hotdogs and buns (HDB) eaten",
        main = "Nathan's Hot Dog Eating Contest Results, 1980-2010_20167149",
        las = 2)

legend("topleft", c("United States", "etc"), fill = c("#821122", "#cccccc"), cex = 1)## 범례 설정 

plot(hotdogs$Dogs.eaten, pch=20, cex=1, type="p", xlab="X", ylab="Y", main="Hotdogs Plot_20167149")
par(new = T)
plot(hotdogs$Year, pch=20, cex=1, type="p", xlab="X", ylab="Y", main="Hotdogs Plot_20167149", col="green")

legend("bottomright", c("hotdogs$Dogs.eaten","hotdogs$Year"), col=c("black","green"),cex=1.5, pch = c(20,20,8))#범례

plot(data3, pch=8, cex=1, type="p", xlab="X", ylab="Y", main="Hello Plot_20167149", col="tan3", ylim=c(1,7.5))

#3.pie
#라벨 설정
slices <- c(10, 12,4,16,8)
pie(slices, labels = c("US","UK","Australia","Germany","France"), main="Pie Chart of Countries_20167149")## 라벨 설ㅈ
#퍼센티지 추가
slices <- c(10,12,4,16,8)
label <- c("US","UK","Australia","Germany","France")
label

per <- round(slices / sum(slices) * 100)
per

label_com <- paste(label,per,"%", sep = " ")
label_com

pie(slices, labels = label_com, main="Pie Chart of Countries_20167149", col = c("tan1","black","snow3","khaki","red"))
legend("topright",label,fill = c("tan1","black","snow3","khaki","red"),cex=0.8)

