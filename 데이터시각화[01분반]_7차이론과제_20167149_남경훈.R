library(ggplot2)
args(geom_point)
args(geom_histogram)
args(geom_bar)

setwd("C:/Users/Administrator/Desktop/한림대/4-1학기/데이터시각화/7차 이론과제")

#geom_boxplot()
#1.소스순번:038번
#1973년 뉴욕의 기후 자료를 통해서
#월 마다 온도가 어땠는지 나타낸 boxplot()입니다.
data("airquality")
str(airquality)
p <- ggplot(airquality, aes(x=Month, y = Temp, group = Month))
p + geom_boxplot()

#geom_histogram()
#2.소스순번:041번
#바람에 대한 히스토그램을 나타내어보았습니다.
p <- ggplot(airquality, aes(x=Wind))
p + geom_histogram(binwidth = 1)

#3.소스순번:042번
#바람에 대한 히스토그램을 나타내어보면서
#density를 빨간선으로 사용을 함으로써 나타내었고
#그라데이션 컬러를 사용한 ggplot 입니다.
p <- ggplot(airquality, aes(x= Wind))
p <- p + geom_histogram(binwidth = 1, aes(y = ..density.., fill=..count..), colour="black")
p <- p + geom_density(colour = "red")
p + scale_fill_gradient(low = "white", high = "#496ff5")


#4.geom_density() - 커널밀도함수
#iris 데이터의 target인 Species를 곡선으로 나타낸
#ggplot입니다.

data(iris)
str(iris)
p <- ggplot(iris, aes(x = Species))
p + geom_density()

#5.stat_density()
#Sepal.length를 밀도분포 그래프로 나타낸 ggplot입니다.
p <- ggplot(iris,aes(x = Sepal.Length, fill = Species))
p + stat_density(aes(ymax = ..density.., ymin = -..density..),
                 colour = "black", alpha = 0.15,
                 geom = "area", position = "identity")
