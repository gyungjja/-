#데이터
#[문제]
#1번:국어는 v1, 영어는 v2, 그리고 수학은 v3 벡터들을 만든다.
v1 <- c(100,80,60,40,70)#국어
v2 <- c(80,70,50,60,100)#영어
v3 <- c(60,70,100,90,80)#수학
v1
v2
v3

#2번:3개의 벡터로 scoreTable을 만들기.
scoreTable <-data.frame(KOR=v1,ENG=v2,MATH=v3)
scoreTable

#3번:socreTable$KOR 로 점그래프 그리기(점은 파란색 사각형으로 표시)
plot(scoreTable$KOR,type="p")
plot(scoreTable$KOR,type="p",pch=7,col=4)
legend("topright",c("scoreTable$KOR"),cex=0.9,col=c("blue"),pch=c(7),lty=1)
#4번:scoreTable$KOR 로 선 그래프 그리기(점과 선으로 된 굵은 선)
plot(scoreTable$KOR,type="b",lwd="3")
legend("topright",c("scoreTable$KOR"),cex=0.9,col=c("black"),pch=c(20,8),lty=1)

#5번:scoreTable로 국어,영어,수학 3개의 선 그래프를 한 화면에 그리기(3개선은 선모양과 색을 다르게)
par(mfrow = c(1,3))
plot(scoreTable$KOR,type="l",lty="dashed",col=1)
plot(scoreTable$ENG,type="l",lty="solid",col=2)
plot(scoreTable$MATH,type="l",lty="dotted",col=3)
legend("top",c("KOR","ENG","MATH"),cex=0.9,col=c("black","red","green"),lty=1)

dev.off()

#6번:scoreTable$ENG로 막대그래프 그리기(90점이상은 파란색,60점이상 녹색,60점 미만 붉은색)
colors <- c()
for(i in 1:length(scoreTable$ENG))
{if(scoreTable$ENG[i] >= 90)
{colors <- c(colors,"blue")}
  else if(scoreTable$ENG[i] >= 60)
  {colors <- c(colors,"green")}
  else
  {colors <- c(colors,"red")}
}
barplot(scoreTable$ENG,col=colors)
legend("top",c("80","70","50","60","100"),cex=0.9,col=c("green","blue","red"),lty=1)

#7번:scoreTable$MATH 로 파이차트 그리기(레이블은 퍼센티지로 표시,3D 파이 차트도 그리기)
scoreTable$MATH
pct <- round(scoreTable$MATH/sum(scoreTable$MATH) * 100,1)
lab1 <-c(scoreTable$MATH)
lab2 <- paste(lab1,"\n",pct,"%")
pie(scoreTable$MATH,radius=1,init.angle=90,col=rainbow(length(scoreTable$MATH)),
    label=lab2)
legend("bottomright",c("60","70","100","90","80"),
       cex=1,fill=rainbow(length(scoreTable$MATH)))
install.packages("plotrix")
library(plotrix)
pie3D(scoreTable$MATH,main="3D Pie Chart",col=rainbow(length(scoreTable$MATH)),
      cex=0.5,labels=lab2,explode=0.05)
legend("topright",c("60","70","100","90","80"),
       cex=1,fill=rainbow(length(scoreTable$MATH)))

#8번:scoreTable로 여러 개의 막대 그래프를 그룹으로 그리기(2가지 beside사용)
x <- matrix(c(v1,v2,v3),5,3)
x
barplot(x,beside=T,names=c("KOR","ENG","MATH"), col=c("green","yellow","red"))
barplot(x,beside=F,names=c("KOR","ENG","MATH"), col=c("green","yellow","red"))
legend("topleft",c("KOR","ENG","MATH"),cex=0.9,col=c("green","yellow","red"),lty=1)
#9번 : scoreTable로 박스 그래프를 그룹으로 그리기(박스 색을 넣고, 상사의 허리부분을 가늘게 표시)
boxplot(scoreTable,notch=TRUE,col=c("green","blue","red"),
        names=c("KOR","ENG","MATH"))
legend("bottomright",c("KOR","ENG","MATH"),cex=0.9,col=c("green","blue","red"),lty=1)
#10번 : 공통사항-제목 x,y 레이블(임의로 지정가정),범례 등을 독창적으로 추가.

#11번 : 할아버지와 할머니를 포함한 가족관계를 데이터로 관계도 그리기.
install.packages("igraph")
library(igraph)
g1 <- graph(c("할아버지","할머니",
              "할머니","할아버지",
              "할머니","아버지",
              "할아버지","아버지",
              "아버지","어머니",
              "어머니","아버지",
              "아버지","나",
              "어머니","나",
              "아버지","동생",
              "어머니","동생",
              "나","동생",
              "동생","나",
              "아버지","할아버지",
              "아버지","할머니",
              "나","아버지",
              "나","어머니",
              "동생","아버지",
              "동생","어머니"),directed=T)
plot(g1,main="가족 관계도")

#name <- c('할아버지,할머니','아버지','어머니','나','동생')
#pemp <- c('할아버지,할머니','할아버지,할머니','아버지','어머니','나')
#emp <- data.frame(이름 = name,관계=pemp)
#emp
#g<- graph.data.frame(emp,direct=T)
#plot(g,layout=layout.fruchterman.reingold,vertex.size=8,edge.arrow.size=0.5)

