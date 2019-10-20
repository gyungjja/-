setwd("C:/Users/Administrator/Desktop/한림대/4-1학기/데이터시각화/6차 이론과제")
getwd()
#[과제 1] 
#mtcars 데이터 프레임에서 mpg를 변환한 
#kpl(Km per litter) 컬럼을 추가하고, 
#추가로 파운드로 표시된 wt를 
#킬로그램으로 변환한 wtkg 컬럼을 
#추가한 데이터 프레임 mtcarsKMS를 만드세요. 
#그 다음 새로운 데이터 프레임 
#mtcarsKMS를 사용하여 kpl과 wtkg이 
#포함된 그래프를 3개를 만드세요.

library(ggplot2)
data("mtcars")
head(mtcars)
#mile to km 1.609를 곱함.(1마일 = 1.60934km)
kpl <- mtcars$mpg * 1.609
#데이터프레임 변환
data.frame(kpl=kpl)
#wtkg
wtkg <- mtcars$wt / 2.205
data.frame(wtkg = wtkg)
#mtcarsKMS 데이터프레임
mtcarsKMS <- cbind(mtcars,kpl,wtkg)
head(mtcarsKMS)

#점포인트 ggplot
p <- ggplot(mtcarsKMS, aes(kpl,wtkg, colour=cyl))
p <- p + geom_point()
p

#레이어 ggplot
p <- ggplot(mtcarsKMS, aes(kpl,wtkg))
p <- p + geom_point()
p <- p + geom_smooth(method="loess")
p
#색상은 cyl 크기는 gear로 나타낸 ggplot
p <- ggplot(data=mtcarsKMS, aes(x=wtkg, y=kpl))
p + geom_point(aes(colour=cyl, size = gear))

#[과제 2] - 거주지의 하천이나 호수의 수위데이터가 없는것 같아서
          # K-water 공공데이터개방포털의 실시간 수도정보 수위(시간)파일을 사용하였습니다.
#http://opendata.kwater.or.kr/pubdata/rwiswater/water_level.do?seq_no=130



#거주지나 고향의 주변에 있는 하천이나 호수의 수위 데이터를 
#찾아서 2개의 그래프를 그리고 분석 결과를 설명하세요.

library(readxl)
a <- read.csv("과제2.csv")
head(a)
#(1) geom_area() + coord_cartesian()을 사용하는 경우

p <- ggplot(data = a, aes(x = 발생일자))
p <- p + geom_area(aes(y = 수위))
p + coord_cartesian(ylim = c(2,20))

#(2) geom_ribbon(aes(ymin=level-2, ymax=level+2), colour="blue")을 이용하는 경우

p <- ggplot(a, aes(x=발생일자))
p + geom_ribbon(aes(ymin=min(수위)-2, ymax=수위+2),colour="blue")



#[과제 3] 


#관심있는 회사의 주가를 찾아서 애플과 
#같은 그래프(소스순번: 037 참고)를 그리고 분석결과를 설명하세요.

if (!require(quantmod)) {
  install.packages("quantmod")
  require(quantmod)
}
#네이버 주식정보 불러오기
naver <- getSymbols("035420.KS", from=as.Date("2014-05-01"),to=as.Date("2014-05-31"),auto.assign = FALSE) # 애플의 주가정보 가져오기
colnames(naver) <- c('Open','High','Low','Close','Volume','Adjusted')
head(naver)
p <- ggplot(naver, aes(x=index(naver), y=naver$Close))     # 리본 플롯과 loess 곡선 등 그리기
p <- p + geom_ribbon(aes(min=naver$Low, max=naver$High), fill="lightblue", colour="black")
p <- p + geom_point(aes(y=naver$Close), colour="black", size=5)
p <- p + geom_line(aes(y=naver$Close), colour="blue")
p <- p + stat_smooth(method="loess", se=FALSE, colour="red", lwd=1.2)
p

#2014-05-01~2014-05-31의 주식 정보를 불러온뒤 ggplot(ribbon,point,line,smooth)를 이용하여 그래프를 표현
#x의 값은 5월1일에서 31일까지이고 y의 값은 주식이 어느가격에서 닫혔는지를 나타내었고 
#ribbon 그래프를 그리고 점으로 표시를 한뒤 파랑선을 그리고 빨강색의 회귀선을 나타낸 ggplot 