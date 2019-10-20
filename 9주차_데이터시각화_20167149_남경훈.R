install.packages("tidyverse")
library(tidyverse)
data()
str(Orange)
Orange
#Orange 내장 데이터
#(1) 점 포인트로 ggplot 그리기 (나무의 나이와 나무의 둘레의 점 ggplot)
ggplot() +
  layer(data = Orange,
        mapping = aes(x = age, y= circumference, colour = Tree),
        geom = 'point',
        stat = 'identity',
        position = 'identity')

#(2)multiple layers,smooth (나무의 나이와 나무의 둘레의 점 ggplot + 상관관계의 선 표시(smooth))
ggplot() +
  geom_point(data = Orange, aes(x = age, y = circumference)) +
  geom_smooth(data = Orange, aes(x= age, y = circumference))

#cars 내장 데이터
str(cars)
#(3) 점 포인트로 ggplot 그리기 (차의 속도와 차의 거리를 점포인트로 나타낸 ggplot)
ggplot(data = cars, aes(x = speed, y=dist)) + 
  geom_point()

#(4) alpha, color 등… help() 또는 Cheat Sheet를 활용하여 옵션 적용
cars_plot <- ggplot(data = cars, aes(x=speed, y = dist))
cars_plot + geom_point(alpha = 0.1,color = "blue")


#mtcars 데이터
str(mtcars)
#(5) mtcars의 vs 의 막대 그래프
ggplot(mtcars, aes(x=vs)) + geom_bar()

#(6)position = 'stack'을 사용 (막대를 쌓아서 누적된 형태로)
ggplot(mtcars,
       aes(factor(gear), fill = factor(vs))) + 
  geom_bar(position="stack")

#airquality 데이터
str(airquality)
#(7)position='dodge' 각 막대를 옆으로 나열.
#Ozone과 Temp를 0.3간격을 떨어뜨려 놓고 흰색 점으로 표시.(겹치는 곳도 많음.)
dodge = position_dodge(0.3)

ggplot(airquality, aes(x = Ozone, y = Temp, Wind = Wind)) + 
  geom_line(position = dodge) +
  geom_point(position = dodge, size = 4, fill='white', shape = 21)

#(8)Multiple Layers
ggplot() + 
  geom_point(data = airquality, aes(x=Ozone, y = Temp)) +
  geom_smooth(data = airquality, aes(x=Ozone, y = Temp))

#msleep 내장데이터
str(txhousing)
txhousing
#(9)txhousing x축을 도시명, y값은 집의 중간가격을 넣어서 박스플롯을 그림.

ggplot(txhousing, aes(x=city, y = median,color = as.factor(city))) + 
  geom_boxplot()
#(10)텍사스 내의 x축 년도 y축 집의 중앙값을 설정하여 점포인트로 나타낸뒤 smooth 상관계수의 선을 표시.
ggplot() +
  geom_point(data = txhousing, aes(x=year, y = median, color = as.factor(city))) +
  geom_smooth(data = txhousing, aes(x=year, y= median))

#y축의 값은 70000~130000으로 지정.
ggplot() +
  geom_point(data = txhousing, aes(x=year, y = median, color = as.factor(city)),position="jitter") +
  geom_smooth(data = txhousing, aes(x=year, y= median)) +
  scale_y_continuous(limits=c(70000,130000))


