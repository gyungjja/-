#작업디렉토리 설정
setwd("C:/Users/Administrator/Desktop/한림대/4-1학기/데이터시각화/lab3/데이터시각화_데이터")
getwd()

#필요한 패키지 설치
install.packages(c("KoNLP","wordcloud","stringi","dplyr","data.table","extrafont"))
library(KoNLP);library(wordcloud);library(data.table);library(dplyr);library(extrafont);


#분석할 데이터 읽어오기
data1 <- readLines("second.txt")
data1

#데이터 중에서 명사만 골라내기
useSejongDic()
data2 <- sapply(data1,extractNoun,USE.NAMES = F)
data2

#추출된 명사를 30 개만 출력
head(unlist(data2),30)
data3 <- unlist(data2)
data3

#출력 결과에서 원하지 않는 내용 걸러 내기
data3 <- gsub("속","",data3)
data3 <- gsub("수","",data3)
data3 <- gsub("들","",data3)
data3 <- gsub("점","",data3)
data3 <- gsub("자연경관","",data3)
data3

#테이블 형태로 파일을 저장후 변환
write(unlist(data3),"second_2.txt")
#수정 완료된 파일을 read.table로 부르기
data4 <- read.table("second_2.txt")
data4
#데이터 몇 건인지
nrow(data4)
wordcount <- table(data4)
wordcount
head(sort(wordcount, decreasing = T),20)
wordcloud

#for 문을 이용한 gsub()
txt <- readLines("gsubfile.txt")
txt
cnt_txt <- length(txt)
cnt_txt
for(i in 1:cnt_txt){
  data3 <- gsub((txt[i]),"",data3)
}
data3

write(unlist(data3), "second_3.txt")
data4 <- read.table("second_3.txt")
wordcount <- table(data4)
head(sort(wordcount,decreasing = T),20)

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
text(x = 0.5, y = 1,"<1.속초시청_자유게시판>", family = "myfont", cex = 2.3) ## x, y 포지션 (x < 1, y < 1)
dev.off()
#단어 빈도수대로 오름차순으로 정렬
wordcount <- sort(wordcount, decreasing = T) # decreasing = F , 오름차순
wordcount
top_20 <- head(wordcount, 20)
barplot(top_20,cex.names=0.8,ylim=c(0,10),space=1,border=T,horiz=F)
fill_colors = c()

for (i in 1:length(top_20)){
  if (top_20[i] >= "8"){
    fill_colors = c(fill_colors,"#821122")
  } else {
    fill_colors = c(fill_colors, "#cccccc")  
  }
}
fill_colors
x11()
barplot(top_20,
        col=fill_colors,
        cex.names=0.8,
        ylim=c(0,10),
        space=1,
        ylab = "Frequency",
        main = "<<빈도수에 따른 막대 그래프 TOP20>>",
        border=T,
        horiz=F)


#파이로 나타내기
color = rainbow(10)
pie(top_20,col=color,radius=1,main="주요 키워드를 pie로 나타낸 그래프")
#수치값 넣기
pct = round(top_20/sum(top_20)*100,1)
names(top_20)
lab = paste(names(a),"\n",pct,"%")
lab
pie(top_20, col=color,radius=1, labels=lab, main="20167149 남경훈")
#겹치게 하기
par(new=T)
#반지름 0.6인 원을 하얀색으로
pie(top_20, radius=0.6, labels=NA, border=NA, col="white")
dev.off()


library(wordcloud2)
#별모양의 wordcloud2
wordcloud2(top_20, fontFamily = "배달의민족 도현", size = 0.48,
           shape = "triangle", backgroundColor = "black",
           color = "random-light", fontWeight = "bold", shuffle = F)

