install.packages("ggmap") # 지도그래프 packages
install.packages("readxl") # excel packages
install.packages("tidyverse")
getwd()
setwd("C:/Users/Administrator/Desktop/한림대/4-1학기/데이터시각화/Lab5")
#라이브러리 
library(ggmap)
library(data.table)
library(tidyverse)

#구글맵 API 획득하기
register_google(key = "AIzaSyBymIq_W1R4vkYA0J0GS0YLAilXVgzXdIk") # api_lee.txt 에서 복사
has_google_key() # api 인증

x11()
dev.off()
#default 지도 그래프
qmap()

#location 및 option을 활용한 지도 그래프
qmap(location = '서울',zoom = 14, maptype = 'roadmap', source = 'google')

#경도,위도 직접입력
qmap(location = c(lon = 126.978,lat = 37.56654),zoom = 14, maptype = 'satellite', source = 'google')

#geocode를 이용한 lon, lat 획득
geocode(location = "서울", output = "more", source = "google")
geocode(location = "강원도 춘천시 한림대학길 1", output = "more", source = "google")

#gecode를 이용한 지도 그래프(return 데이터프레임)
myLoc <- geocode(location = "강원도 춘천시 한림대학길 1", output = "more", source = "google")
center <- c(myLoc$lon, myLoc$lat) # myLoc의 lon, lat 추출

# geom_point를 이용한 해당 위치 mapping. 여기서 aes는 축을 설정하는 function
qmap(location = center, zoom = 18, maptype = 'hybrid',source = 'google') + 
  geom_point(data = myLoc, mapping = aes(x = lon,y = lat),shape = '★',color = 'red',stroke = 10, size = 12)


#2.공공데이터 및 google api를 이용한 ggmap 그래프

#전국의 cctv 현황
library(readxl)

cctv_list <- list()
excel_sheets(path= "전국cctv표준데이터.xls")

for(index in 1:length(excel_sheets(path = "전국cctv표준데이터.xls"))){ # excel의 sheet 수 만큼 반복 진행
  cctv_list[[index]] <- read_xls(path = "전국cctv표준데이터.xls") # list의 요소로 각 sheet를 데이터프레임으로 저장
}
cctv_list_df <- cctv_list %>% bind_rows() %>% as_tibble() # bind_rows() list의 데이터프레임의 row를 하나의 데이터프레임으로 변환
str(cctv_list_df)

cctv_list_df_lat_lon <- cctv_list_df %>% select(., 관리기관명,위도, 경도) %>% # 필요한 열만 추출
  mutate(., 위도 = as.numeric(위도), 경도 = as.numeric(경도)) # mutate를 이용하여 열의 type을 변경 (chr -> numeric)
str(cctv_list_df_lat_lon)

# x11(width = 1928, height = 1024)
# 데이터의 크기를 20,000까지 인덱싱하여 사용함.
qmap(location = "서울", zoom = 6, maptype = 'satellite', source = 'google') + 
  geom_point(data = cctv_list_df_lat_lon[1:20000,], aes(x = 경도, y = 위도), color = 'red', size = 2, alpha = 0.5)

#춘천의 cctv 현황
# dplyr::filter(), stringr::str_detect(), help()를 이용해서 확인할 것
cctv_list_chunchen <- cctv_list %>% bind_rows() %>% as_tibble() %>%
  filter(., str_detect(.$관리기관명, "춘천시")) %>% select(., 관리기관명, 위도, 경도, 설치목적구분) %>% 
  mutate(., 위도 = as.numeric(위도), 경도 = as.numeric(경도), 설치목적구분 = as.factor(설치목적구분))

#지도 그래프의 중심점
myLoc <- geocode(location = "춘천", output = "more", source = "google")
center <- c(myLoc$lon, myLoc$lat) 
center

#위치 표시의 위도, 경도 정보
head(cctv_list_chunchen, 20)

#내장 및 사용자 font load
library(extrafont)
loadfonts()
head(fonts()) # 출력된 값을 이용하여 font 설정

#factor 변수를 이용한 색 설정
qmap(location = center, zoom = 15, maptype = 'hybrid', source = 'google') + 
  geom_point(data = cctv_list_chunchen, aes(x = 경도, y = 위도, color = 설치목적구분), size = 4, alpha = 0.5)

#ggtitle를 이용한 title 설정
qmap(location = center, zoom = 15, maptype = 'hybrid', source = 'google') + 
  geom_point(data = cctv_list_chunchen, aes(x = 경도, y = 위도, color = 설치목적구분), size = 4, alpha = 0.5) +
  ggtitle("<<춘천시내 CCTV 현황>>_공공데이터")

#theme를 이용한 title 및 legend 설정
qmap(location = center, zoom = 15, maptype = 'hybrid', source = 'google') + 
  geom_point(data = cctv_list_chunchen, aes(x = 경도, y = 위도, color = 설치목적구분), size = 4, alpha = 0.5) +
  ggtitle("<<춘천시내 CCTV 현황>>_공공데이터") +
  theme(legend.text=element_text(face = "bold",size = 15, family = "BM HANNA Pro"), 
        legend.title = element_text(size = 15, face = "bold", family = "BM HANNA Pro"),
        legend.position = "top",
        plot.title = element_text(family = "BM HANNA Pro", face = "bold", hjust = 0.5,size =  25))

#facet_warp을 이용한 factor별(설치목적구분) 지도 그래프
qmap(location = center, zoom = 15, maptype = 'hybrid', source = 'google') +
  geom_point(data = cctv_list_chunchen, aes(x = 경도, y = 위도, color = 설치목적구분), size = 5, alpha = 0.5) +
  ggtitle("<<춘천시내 CCTV 현황>>_공공데이터") +
  theme(legend.text=element_text(face = "bold",size = 15, family = "BM HANNA Pro"), 
        legend.title = element_text(size = 15, face = "bold", family = "BM HANNA Pro"),
        legend.position = "top",
        plot.title = element_text(family = "BM HANNA Pro", face = "bold", hjust = 0.5,size =  25)) +
  facet_wrap(~설치목적구분)

#3.공공데이터, leaflet 패키지를 이용한 interaction 그래프
#leaflect default
install.packages("leaflet")
library(leaflet)
#addTiles() api 호출, setView() 중앙점 지정(feat.한림대학교)
m <- leaflet() %>% addTiles() %>%
  setView(lng = 127.7377722, lat = 37.8862292, zoom = 16)
m

#위도,경도 Marker 생성
dak <- geocode("강원도 춘천시 조운동 명동길 9") # 닭갈비 골목 lat, lon
m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles, OpenStreeMap API를 이용한 그래프
  addMarkers(lng=dak$lon, lat=dak$lat, popup="닭갈비 지겹다..gg.;")
m  # Print the map

#leaflect 옵션 추가
pal <- colorFactor(rainbow(6), domain = levels(cctv_list_chunchen$설치목적구분)) # 색 지정을 위한 fucntion 생성
pal("생활방범")

#~:data의 각 열에 해당하는 모든 값 호출
leaflet(cctv_list_chunchen) %>% addTiles() %>% 
  setView(lng = 127.7377722, lat = 37.8862292, zoom = 12) %>%
  addCircleMarkers(lat = ~위도, lng = ~경도, color = ~pal(설치목적구분), popup = ~설치목적구분) %>%
  addLegend(pal = pal, values = cctv_list_chunchen$설치목적구분, opacity = 0.7,
            title = "설치목적구분", position= "bottomright") %>%
  addProviderTiles(providers$OpenStreetMap) %>% addMiniMap()

#leaflect 저장 방법
library(htmlwidgets)
dak <- geocode("강원도 춘천시 조운동 명동길 9") # 닭갈비 골목 lat, lon
m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles, OpenStreeMap API를 이용한 그래프
  addMarkers(lng=dak$lon, lat=dak$lat, popup="닭갈비 지겹다..gg.;")

saveWidget(m, file="m.html") # html로 저장


------------------------------------------------------
  
install.packages("ggmap") # 지도그래프 packages
install.packages("readxl") # excel packages
install.packages("tidyverse")
getwd()
setwd("C:/Users/Administrator/Desktop/한림대/4-1학기/데이터시각화/Lab5")
#라이브러리 
library(ggmap)
library(data.table)
library(tidyverse)

#구글맵 API 획득하기
register_google(key = "AIzaSyBymIq_W1R4vkYA0J0GS0YLAilXVgzXdIk") # api_lee.txt 에서 복사
has_google_key() # api 인증

x11()
dev.off()
#default 지도 그래프
qmap()

#location 및 option을 활용한 지도 그래프
qmap(location = '서울',zoom = 14, maptype = 'roadmap', source = 'google')

#경도,위도 직접입력
qmap(location = c(lon = 126.978,lat = 37.56654),zoom = 14, maptype = 'satellite', source = 'google')

#geocode를 이용한 lon, lat 획득
geocode(location = "서울", output = "more", source = "google")
geocode(location = "서울특별시 광진구 강변역로 50 동서울종합터미널", output = "more", source = "google")

#gecode를 이용한 지도 그래프(return 데이터프레임)
myLoc <- geocode(location = "서울특별시 광진구 강변역로 50 동서울종합터미널", output = "more", source = "google")
center <- c(myLoc$lon, myLoc$lat) # myLoc의 lon, lat 추출
center
# geom_point를 이용한 해당 위치 mapping. 여기서 aes는 축을 설정하는 function
qmap(location = center, zoom = 18, maptype = 'hybrid',source = 'google') + 
  geom_point(data = myLoc, mapping = aes(x = lon,y = lat),shape = '★',color = 'red',stroke = 10, size = 12)


#2.공공데이터 및 google api를 이용한 ggmap 그래프

#전국의 cctv 현황
library(readxl)

cctv_list <- list()
excel_sheets(path= "전국금연구역표준데이터.xls")

for(index in 1:length(excel_sheets(path = "전국금연구역표준데이터.xls"))){ # excel의 sheet 수 만큼 반복 진행
  cctv_list[[index]] <- read_xls(path = "전국금연구역표준데이터.xls") # list의 요소로 각 sheet를 데이터프레임으로 저장
}
cctv_list_df <- cctv_list %>% bind_rows() %>% as_tibble() # bind_rows() list의 데이터프레임의 row를 하나의 데이터프레임으로 변환
str(cctv_list_df)

cctv_list_df_lat_lon <- cctv_list_df %>% select(., 시도명,위도, 경도) %>% # 필요한 열만 추출
  mutate(., 위도 = as.numeric(위도), 경도 = as.numeric(경도)) # mutate를 이용하여 열의 type을 변경 (chr -> numeric)
str(cctv_list_df_lat_lon)

x11(width = 1928, height = 1024)
# 데이터의 크기를 20,000까지 인덱싱하여 사용함.
qmap(location = "서울", zoom = 6, maptype = 'satellite', source = 'google') + 
  geom_point(data = cctv_list_df_lat_lon[1:20000,], aes(x = 경도, y = 위도), color = 'red', size = 2, alpha = 0.5)

#서울의 금연구역 현황
# dplyr::filter(), stringr::str_detect(), help()를 이용해서 확인할 것
cctv_list_seoul <- cctv_list %>% bind_rows() %>% as_tibble() %>%
  filter(., str_detect(.$시도명, "서울")) %>% select(., 시도명, 위도, 경도, 시군구명) %>% 
  mutate(., 위도 = as.numeric(위도), 경도 = as.numeric(경도), 시군구명 = as.factor(시군구명))

#지도 그래프의 중심점
myLoc <- geocode(location = "서울특별시", output = "more", source = "google")
center <- c(myLoc$lon, myLoc$lat) 
center

#위치 표시의 위도, 경도 정보
head(cctv_list_kangwon, 20)

#내장 및 사용자 font load
library(extrafont)
loadfonts()
head(fonts()) # 출력된 값을 이용하여 font 설정
#x11()
#dev.off()
#factor 변수를 이용한 색 설정
qmap(location = center, zoom = 11, maptype = 'hybrid', source = 'google') + 
  geom_point(data = cctv_list_seoul, aes(x = 경도, y = 위도, color = 시군구명), size = 4, alpha = 0.5)

#ggtitle를 이용한 title 설정
qmap(location = center, zoom = 11, maptype = 'hybrid', source = 'google') + 
  geom_point(data = cctv_list_seoul, aes(x = 경도, y = 위도, color = 시군구명), size = 4, alpha = 0.5) +
  ggtitle("<<전국금연구역표준데이터_20167149 남경훈>>")

#theme를 이용한 title 및 legend 설정
qmap(location = center, zoom = 11, maptype = 'hybrid', source = 'google') + 
  geom_point(data = cctv_list_seoul, aes(x = 경도, y = 위도, color = 시군구명), size = 4, alpha = 0.5) +
  ggtitle("<<전국금연구역표준데이터_20167149 남경훈>>") +
  theme(legend.text=element_text(face = "bold",size = 15, family = "BM HANNA Pro"), 
        legend.title = element_text(size = 15, face = "bold", family = "BM HANNA Pro"),
        legend.position = "top",
        plot.title = element_text(family = "BM HANNA Pro", face = "bold", hjust = 0.5,size =  25))

#facet_warp을 이용한 factor별(시군구명) 지도 그래프
qmap(location = center, zoom = 11, maptype = 'hybrid', source = 'google') +
  geom_point(data = cctv_list_seoul, aes(x = 경도, y = 위도, color = 시군구명), size = 5, alpha = 0.5) +
  ggtitle("<<전국금연구역표준데이터_20167149 남경훈>>") +
  theme(legend.text=element_text(face = "bold",size = 15, family = "BM HANNA Pro"), 
        legend.title = element_text(size = 15, face = "bold", family = "BM HANNA Pro"),
        legend.position = "top",
        plot.title = element_text(family = "BM HANNA Pro", face = "bold", hjust = 0.5,size =  25)) +
  facet_wrap(~시군구명)

#3.공공데이터, leaflet 패키지를 이용한 interaction 그래프
#leaflect default
install.packages("leaflet")
library(leaflet)
#addTiles() api 호출, setView() 중앙점 지정(feat.동서울터미널)
m <- leaflet() %>% addTiles() %>%
  setView(lng = 127.09404, lat = 37.53439, zoom = 16)
m

#위도,경도 Marker 생성
#dak <- geocode("서울특별시 송파구 올림픽로 240") # 롯데월드 lat, lon
dak <- geocode("서울특별시 광진구 강변역로 50 동서울종합터미널") # 동서울터미널 lat, lon
m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles, OpenStreeMap API를 이용한 그래프
  addMarkers(lng=dak$lon, lat=dak$lat, popup="터미널 지옥..gg.;")
m  # Print the map

#leaflect 옵션 추가
pal <- colorFactor(rainbow(6), domain = levels(cctv_list_seoul$시군구명)) # 색 지정을 위한 fucntion 생성
pal("광진구")

#~:data의 각 열에 해당하는 모든 값 호출
leaflet(cctv_list_seoul) %>% addTiles() %>% 
  setView(lng = 127.09404, lat = 37.53439, zoom = 12) %>%
  addCircleMarkers(lat = ~위도, lng = ~경도, color = ~pal(시군구명) ,popup = ~시군구명) %>%
  addLegend(pal = pal, values = cctv_list_seoul$시군구명, opacity = 0.7,
            title = "<<전국금연구역표준데이터_20167149 남경훈>>", position= "bottomright") %>%
  addProviderTiles(providers$OpenStreetMap) %>% 
  #항목에 들어가는 체크박스를 만드는 옵션.
  addLayersControl(overlayGroups = c('강북구', '광진구', '구로구','금천구','동작구','송파구','영등포구'),
                   options = layersControlOptions(collapsed = FALSE)) %>% addMiniMap()


#leaflect 저장 방법
library(htmlwidgets)
dak <- geocode("서울특별시 광진구 강변역로 50 동서울종합터미널") # 터미널 lat, lon
m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles, OpenStreeMap API를 이용한 그래프
  addMarkers(lng=dak$lon, lat=dak$lat, popup="터미널..gg.;")

saveWidget(m, file="m.html") # html로 저장


#------------------------------------------------------------#
#옵션추가
x <- read.xls("전국금연구역표준데이터.xls",stringsAsFactor=FALSE)
leaflet(cctv_list_seoul) %>% 
  setView(lng = 127.09404, lat = 37.53439, zoom = 12) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircleMarkers(data = cctv_list_df %>% filter(시군구명 == '강북구'), 
             lat = ~위도, lng = ~경도, popup = ~시군구명, group = '강북구', 
             color = ~pal(시군구명)) %>% 
  addCircleMarkers(data = cctv_list_df %>% filter(시군구명 == '광진구'), 
             lat = ~위도, lng = ~경도, popup = ~시군구명, group = '광진구', 
             color = ~pal(시군구명)) %>% 
  addCircleMarkers(data = cctv_list_df %>% filter(시군구명 == '구로구'), 
             lat = ~위도, lng = ~경도, popup = ~시군구명, group = '구로구', 
             color = ~pal(시군구명)) %>% 
  addCircleMarkers(data = cctv_list_df %>% filter(시군구명 == '금천구'), 
             lat = ~위도, lng = ~경도, popup = ~시군구명, group = '금천구', 
             color = ~pal(시군구명)) %>% 
  addCircleMarkers(data = cctv_list_df %>% filter(시군구명 == '동작구'), 
             lat = ~위도, lng = ~경도, popup = ~시군구명, group = '동작구', 
             color = ~pal(시군구명)) %>% 
  addCircleMarkers(data = cctv_list_df %>% filter(시군구명 == '송파구'), 
             lat = ~위도, lng = ~경도, popup = ~시군구명, group = '송파구', 
             color = ~pal(시군구명)) %>% 
  addCircleMarkers(data = cctv_list_df %>% filter(시군구명 == '영등포구'), 
             lat = ~위도, lng = ~경도, popup = ~시군구명, group = '영등포구', 
             color = ~pal(시군구명)) %>% 
  addLayersControl(overlayGroups = c('강북구', '광진구', '구로구','금천구','동작구','송파구','영등포구'),
                   options = layersControlOptions(collapsed = FALSE))

















#------------------------------------------------------