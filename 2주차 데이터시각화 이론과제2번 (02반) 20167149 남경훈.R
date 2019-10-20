#작업디렉토리 설정
setwd("C:/Users/Administrator/Desktop/한림대/4-1학기/데이터시각화/lab3/데이터시각화_데이터")
getwd()

#필요한 패키지 설치
install.packages(c("KoNLP","wordcloud","stringi","dplyr","data.table","extrafont"))
library(KoNLP);library(wordcloud);library(data.table);library(dplyr);library(extrafont);
library(stringr)

#분석할 데이터 읽어오기
data1 <- readLines("first.txt")
data1

#데이터 중에서 명사만 골라내기
useSejongDic()
data2 <- sapply(data1,extractNoun,USE.NAMES = F)
data2

#추출된 명사를 30 개만 출력
head(unlist(data2),30)
data3 <- unlist(data2)
data3 <- Filter(function(x){nchar(x) >= 2}, data3)
#대통령 키워드를 ""으로 치환
data3 <- str_replace_all(data3,"[대통령]","")
data3
txt <- readLines("문재인대통령gsub.txt")

cnt_txt <- length(txt)
cnt_txt
for(i in 1:cnt_txt){
  data3 <- gsub((txt[i]),"",data3)
}
#문자열 길이가 2이상인것만 추출
data3 <- Filter(function(x) {nchar(x) >= 2},data3)
write(unlist(data3),"moon.txt")
data4 <- read.table("moon.txt")
nrow(data4)
wordcount <- table(data4)
wordcount
a <- head(sort(wordcount, decreasing=T),20)
a
#wordcloud 생
#글꼴 및 글자색 변경
mycolor <- c("deeppink", "firebrick1", "yellow1", "blue","cyan2", "chartreuse2", "salmon2")
# color in r 파일의 색을 참고하여 원하는 색상 선택. 
mycolor
windowsFonts(myfont = windowsFont("배달의민족 도현")) # myfont에 폰트 지정(임의 지정), 윈도우 - 글꼴
x11(width = 1024, height = 768)
wordcloud(words = names(wordcount), freq = wordcount, 
          scale = c(4, 0.2), 
          rot.per = 0.25, 
          min.freq = 1, 
          random.order = F, 
          random.color = T,
          family = "myfont", # 폰트 지정
          color = mycolor # 색 지정 
)

text(x = 1, y = 1,"20167149", family = "myfont", cex = 2.3)

# 제목 설정
text(x = 0.5, y = 1,"<2.문재인 대통령 취임사>", family = "myfont", cex = 2.3) ## x, y 포지션 (x < 1, y < 1)
dev.off()

##막대그래프에 수치넣기
x11()
bp = barplot(a, main="문재인 대통령취임사 TOP 20", col=color,space=0.8, ylim=c(0,30),cex.name=0.7,las=1 )
pct_bar = round(top_20/sum(a)*100,1)
pct_bar
barplot(a, main="문재인 대통령취임사 TOP 20", col=color,space=0.8, ylim=c(0,30),cex.name=0.7,las=1)
#퍼센티지
text(x=bp, y=a*1.05, labels=paste("(",pct_bar,"%",")"), col="black", cex=0.7)
#빈도수
text(x=bp, y=a*0.95, labels=paste(a,"건"), col="black", cex=0.7)



#막대그래프 수치값 넣기 (옆으로)
bp_h = barplot(a, main="막대그래프 TOP 20", col=color,space=0.8, xlim=c(0,30),cex.name=0.7,las=1,horiz=T)
text(x=a*1.15, y=bp_h, labels=paste("(",pct,"%",")"), col="black", cex=0.7)
text(x=a*0.9, y=bp_h, labels=paste(top_20,"건"), col="black", cex=0.7)

#선 그래프
plot(a, x=, col="red", type="o", axes=F,main="문재인 대통령 취임사 TOP20")
axis(side=1,at=1:length(a),labels=names(a),las=2)
axis(side=2,las=1)

#히스토그램
par(mfrow = c(1,3))
         
         
