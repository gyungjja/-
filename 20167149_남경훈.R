#Lab10 과제
#1. 실습자료(Lab10) 코드 및 그래프 
remove.packages("tidyverse")
install.packages("tidyverse")
install.packages("ggplot2")
#1.annotate()
library(ggplot2)
library(tidyverse)
args(annotate)

#1.annotate() geom = "text"
ferrari <- mtcars[rownames(mtcars) == "Ferrari Dino",]
# scatter plot
p <- ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
p <- p + geom_point(data = ferrari, colour = "red")

# geom = "text"
p + annotate(geom = "text", x = ferrari$wt, y = ferrari$mpg, 
             label = paste0("<--", rownames(ferrari)), hjust = -0.1, colour = "red")

# text 여러개 출력
merc <- mtcars[str_detect(string = rownames(mtcars), pattern = "Merc"), ]
anno_text <- rbind(ferrari, merc)

p <- ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
p <- p + geom_point(data = anno_text, colour = "red")

p + annotate(geom = "text", x = anno_text$wt, y = anno_text$mpg, 
             label = paste0("<--", rownames(anno_text)), hjust = -0.1, colour = "red")

#1.annotate() geom="rect"
# 이상치 계산, 박스 플롯을 만들 때 사용하는 튜키(Tukey)의 method
# 이상치 계산에 대한 자세한 내용, https://sosal.kr/945
wt_bounds <- IQR(mtcars$wt) * c(-1.5, 1.5) + fivenum(mtcars$wt) [c(2,4)]
mpg_bounds <- IQR(mtcars$mpg) * c(-1.5, 1.5) + fivenum(mtcars$mpg) [c(2,4)]

p + annotate(geom = "rect",
             xmin = wt_bounds[1], xmax = wt_bounds[2],
             ymin = mpg_bounds[1], ymax = mpg_bounds[2], alpha = 0.2)

#1.annotate() geom="segment"
#segment = 분할선
p + annotate(geom = "segment", x = 2.5, xend = 4, y = 15, yend = 25, colour = "blue")

#1.annotate() geom="pointrange"
p + annotate(geom = "pointrange", pch = 15, cex = 1.2,
             x = median(mtcars$wt), y = median(mtcars$mpg),
             ymin = mpg_bounds[1], ymax = mpg_bounds[2],
             colour = "red")

#1.2 annotation_custom()

install.packages("gridExtra")
library(gridExtra)
args(annotation_custom)

# plot위에 table 추가
top10 <- head(mtcars[order(mtcars$mpg, decreasing = T), ], 10)
table_grob <- tableGrob(top10[, c("mpg", "wt")]) # tableGrob, table to grob

p <- ggplot(data=mtcars, aes(x = wt, y = mpg))
p <- p + geom_point()
p <- p + expand_limits(xmax = 10)
p + annotate(geom = "text", x = 8.2, y = 33,
             label = "Best mpg Top 10 lists", hjust = 0.5, colour = "red") + 
  annotation_custom(grob = table_grob, xmin = 6, xmax = Inf, ymin = -Inf, ymax = Inf) # table 추가

#1.3 annotation_map & annotation_raster
install.packages("maps")
library(maps) # 위도 경도 데이터

# 동물의 이동 경로 표현, annotation_map
usamap <- map_data("state")
seals_sub <- subset(seals, long > -130 & lat < 45 & lat > 40)
ggplot(seals_sub, aes(x = long, y = lat)) +
  annotation_map(usamap, fill = "NA", colour = "grey50") +
  geom_segment(aes(xend = long + delta_long, yend = lat + delta_lat))

# help(hcl) or ?hcl
rainbow.color <- matrix(hcl(seq(0, 360, length = 10), 80, 70), nrow = 1)
qplot(mpg, wt, data = mtcars) +
  annotation_raster(rainbow.color, -Inf, Inf, -Inf, Inf) +
  geom_point()


#2. Annotation 함수 2개(annotate, annotation_custom)에 대한 공공데이터 그래프 각각 1개씩 생성(총 5개)
#annotate의 경우 geom(text, rect, segment, pointrage)마다 그래프 1개 
#공공데이터 활용 
#데이터 설명 추가할 것

#2.1 geom="text"
setwd("C:/Users/hallym/Desktop/Lab10_20167149")
data1 <- read.csv("2012년_1당사자_법규위반별_주야별_교통사고.csv")

overshousness <- data1[(data1$법규위반) == "과속",]
p <- ggplot(data1, aes(x = 발생건수, y = 사망자수)) + geom_point()
p <- p + geom_point(data = overshousness, colour = "red")

p + annotate(geom = "text", x = overshousness$발생건수, y = overshousness$사망자수,
             label = paste0("<--", overshousness$법규위반), hjust = -0.1, colour = "red")

#데이터는 공공데이터포털에서 교통사고에 대한 데이터를 가져왔고 
#과속이라는 rowname을 가져와서 저장을 하고 ggplot은 발생건수에대한 사망자 수를
#나타내었으며 annotate의 geom="text"를 사용해서 라벨을 나타내였습니다.


#2.2 geom="rect"(사각 영역에 의한 강조)
발생건수_bounds <- IQR(data1$발생건수) * c(-1.5,1.5) + fivenum(data1$발생건수) [c(2,4)]
발생건수_bounds
사망자수_bounds <- IQR(data1$사망자수) * c(-1.5, 1.5) + fivenum(data1$사망자수) [c(2,4)]                   
사망자수_bounds

p + annotate(geom = "rect",
             xmin = 발생건수_bounds[1], xmax = 발생건수_bounds[2],
             ymin = 사망자수_bounds[1], ymax = 사망자수_bounds[2], alpha = 0.2)

# rect를 사용하여 사각 영역의 구역을 표시를 한 ggplot입니다.
#2.3 geom="segment"(분할선을 이용한 영역의 구분)

p + annotate(geom = "segment", x = 2.5, xend = 70000, y = 15, yend = 2000, colour = "green")

#segment 를 사용하여 나타낸 분할선을 추가한 ggplot 입니다.
#x의 값은 2.5 값 지점으로 시작을 해서 70000까지 뻗어나가고
#y의 값은 15 값 지점으로 시작을 해서 2000까지 뻗어나가는 분할선입니다.

#2.4 geom = "pointrange" (점과 선에 의한 범위의 표현)

p + annotate(geom = "pointrange", pch = 15, cex = 1.2,
             x = median(data1$발생건수), y = median(data1$사망자수),
             ymin = 사망자수_bounds[1], ymax = 사망자수_bounds[2],
             colour = "yellow")

#발생건수의 평균값과 사망건수의 평균값을 점과 선에 의해 범위를 표현한 ggplot입니다.

#2.5 annotation_custom()
library(gridExtra)
args(annotation_custom)

top10 <- head(data1[order(data1$발생건수, decreasing = T), ], 10)
table_grob <- tableGrob(top10[,c("발생건수","사망자수")])

p <- ggplot(data=data1, aes(x = 발생건수, y = 사망자수))
p <- p + geom_point()
p <- p + expand_limits(xmax = 10)
p + annotate(geom = "text", x = 36000, y = 1750,
             label = "발생건수 Top 10 lists", hjust = 1.0, colour = "red") +
  annotation_custom(grob = table_grob, xmin = 6, xmax = Inf, ymin = -Inf, ymax = Inf)

#교통사고의 발생건수에 대한 사망자수를 테이블로 나타낸 ggplot 입니다.
#발생건수를 내림차순으로 정렬을 하여 나타내었습니다.