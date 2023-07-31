install.packages('ggiraphExtra')

library(ggiraphExtra)
library(ggplot2)

# 미국 주별 강력 범죄 데이터 
head(USArrests)
str(USArrests)

install.packages("tibble")
library(tibble)

# rownames_to_column() -> 인덱스를 컬럼으로 변경
crime <- rownames_to_column(USArrests, var='state')
head(crime)

# 문자열 데이터를 모두 소문자로 변경
tolower(crime$state) -> crime$state
# 문자열 데이터를 모두 대문자로 변경
toupper(crime$state)

install.packages('maps')
# maps 패키지는 주별 위,경도가 들어있는 패키지 
map_data('state') -> states_map

ggChoropleth(
  data = crime,   # 지도에 표현이 될 데이터의 값
  aes(
    fill = Murder, # 색으로 표현될 데이터 변수
    map_id = state # 지역 지군 변수
  ), 
  map = states_map, # 지도 데이터
  interactive = T
)

# 한국 시도별 인구가 어떻게 되는가?
install.packages('devtools')

devtools::install_github("cardiomoon/kormaps2014")
library(kormaps2014)

# korpop1 : 2014년도 기준 인구 데이터(시도별)
# korpop2 : 2014년도 기준 인구 데이터(시군구별)
# korpop3 : 2014년도 기준 인구 데이터(읍면동별)
# kormap1 : 2014년도 기준 행정 지도(시도별)
# kormap2 : 2014년도 기준 행정 지도(시군구별)
# kormap3 : 2014년도 기준 행정 지도(읍면동별)
str(korpop1)

korpop1 <- rename(
  korpop1, 
  pop = 총인구_명, 
  name = 행정구역별_읍면동
)

View(korpop1)
head(korpop1)
# 한글 깨짐 현상 시 인코딩의 방식을 UTF-8에서 CP949로 변경
iconv(korpop1$name, "UTF-8", "CP949")

ggChoropleth(
  data = korpop1, 
  aes(
    fill = pop, 
    map_id = code, 
    tooltip = name
  ), 
  map = kormap1, 
  interactive = T
)


## 인터렉티브 그래프 
# plotly, dygraph 패키지를 이용하여 그래프를 출력

install.packages("plotly")
install.packages("dygraphs")

library(plotly)
library(ggplot2)

a = ggplot(
  data = mpg, 
  aes(
    x = displ, 
    y = hwy, 
    col = drv
  )
) + geom_point()
a

ggplotly(a)

diamonds
b = ggplot(
  data = diamonds, 
  aes(
    x = cut, 
    fill = clarity
  )
) + geom_bar(position='dodge')
ggplotly(b)

library(dygraphs)

economics

# 시계열데이터 타입(xts) 변경
library(xts)

eco = xts(economics$unemploy, order.by = economics$date)

dygraph(eco) %>% 
  dyRangeSelector()


eco_1 = xts(economics$psavert, order.by = economics$date)
eco_2 = xts(economics$unemploy/1000, order.by = economics$date)
head(eco_1)
head(eco_2)

eco2 = cbind(eco_1, eco_2)



dygraph(eco2) %>% dyRangeSelector()
