# 패키지 설치 
install.packages("dplyr")
# 패키지 로드 
library(dplyr)

# csv_exam.csv 파일 로드 
exam = read.csv("../csv/csv_exam.csv")


# filter(조건식)
exam %>% filter(class == 1)

# select(컬럼의 조건)
exam %>% select(math, english)

exam %>% select('class':'english')

# 특정 컬럼을 제외한 나머지 컬럼을 확인(-부호를 사용하여 해당 컬럼을 제외)
exam %>% select(-id)

# 행과 열의 조건식을 모두 사용
exam %>% 
  filter(class == 1) %>% 
  select("math", "english")

# 정렬은 변경하는 함수 
# 기본값은 오름차순 정렬
exam %>% arrange(math)

# 내림차순 정렬
exam %>% arrange(desc(math))
exam %>% arrange(-math)

# 정렬의 기준이 2개인 경우 
# (class를 기준으로 오름차순 정렬, 수학 성적 기준으로 내림차순)
exam %>% arrange(class, desc(math))

exam %>% summarise(mean_math = mean(math))


# 그룹화
exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math), 
            mean_english = mean(english), 
            count = n())
# mean() : 평균
# sd() : 표준편차
# sum() : 합계
# median() : 중간값
# min() : 최소값
# max() : 최대값
# n() : 빈도(갯수)

# 새로운 컬럼을 생성 
exam %>% 
  mutate(total = math + english + science, 
         mean = round(total/3, 2) ) -> exam

# mpg 데이터프레임 로드 
mpg
mpg = ggplot2::mpg

View(mpg)

## mpg 데이터프레임에서 
## dplyr에 있는 함수들을 이용하여 
## 제조사(manufacturer)별로 그룹화
## class가 suv인 
## hwy 컬럼의 평균 값을 구하여
## 내림차순으로 정렬 변경
## 상위 5위까지의 데이터를 출력하시오
mpg %>% 
  group_by(manufacturer) %>% 
  filter(class == "suv") %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% 
  head(5)

## (cty+hwy)/2 -> total이라는 컬럼을 생성하여 
## model별 그룹화
## total 평균 값을 구하고
## total의 평균값을 기준으로 내림차순 정렬
## 상위 10개를 출력
mpg %>% 
  mutate(total = (cty + hwy) / 2 ) %>% 
  group_by(model) %>% 
  summarise(mean_total = mean(total)) %>% 
  arrange(-mean_total) %>% 
  head(10)

# join 결합
# 특정한 조건에 맞는 경우 데이터프레임의 열을 결합하는 함수
df_1 = data.frame(
  id = 1:5, 
  score = c(60, 70, 80, 90, 100)
)
df_2 = data.frame(
  id = 2:6, 
  weight = c(80, 70, 75, 60, 55)
)
df_1
df_2

# 교집합
# inner_join(데이터프레임1, 데이터프레임2, by='조건')
inner_join(df_1, df_2, by='id')

# 왼쪽의 데이터프레임을 기준으로 결합
left_join(df_1, df_2, by='id')

# 오른쪽의 데이터프레임을 기준으로 결합
right_join(df_1, df_2, by='id')

# 합집합
full_join(df_1, df_2, by='id')


df_3 = data.frame(
  id = 1:5, 
  item = c(1, 2, 1, 2, 3)
)
df_4 = data.frame(
  item = 1:3, 
  price = c(100, 200, 300)
)
df_3
df_4

inner_join(df_3, df_4, by='item')
left_join(df_3, df_4, by='item')
right_join(df_3, df_4, by='item')
full_join(df_3, df_4, by='item')

# 데이터프레임의 행 결합
df_1 = data.frame(
  id = 1:5, 
  score = c(70, 80, 90, 100, 70)
)
df_2 = data.frame(
  id = 6:10, 
  weight = c(80, 70, 60, 75, 65)
)
df_3 = data.frame(
  id = 11:15, 
  score = c(100, 80, 60, 50, 80)
)

#rbind()는 데이터프레임의 형태가 같은 경우에만 행을 추가해준다. 
rbind(df_1, df_2)
rbind(df_1, df_3)

# 단순한 행 결합 
bind_rows(df_1, df_2, df_3)

midwest = ggplot2::midwest

View(midwest)

# 컬럼의 이름을 변경
# rename(데이터프레임명, 변경될 컬럼명 = 변경시킬 컬럼명)
# midwest 데이터프레임에서  popasian컬럼을 asian 변경
# poptotal컬럼의 이름을 total 변경
rename(midwest, asian = popasian) -> midwest
midwest <- rename(midwest, total= poptotal)

## total, asian 컬럼을 이용하여 전체 인구 대비 아시아 인구 백분율
# (asian/total)*100
## 파생변수(ratio) 생성
# 내장함수 
(midwest$asian / midwest[['total']] ) * 100 -> midwest$ratio
# 외부 패키지
midwest %>% 
  mutate(ratio = (asian / total)*100 ) -> midwest

## ratio 히스토그램 
# hist(백터값)
hist(midwest$ratio)


## ratio의 전체 평균 값을 기준으로 평균을 초과하면 large, 이하면 small
## 파생변수(group) 생성
# ratio 전체 평균 값 출력
mean(midwest$ratio) -> mean_ratio
ifelse(midwest$ratio > mean_ratio, 'large', 'small') -> midwest$group

midwest %>% 
  mutate(group = ifelse(ratio > mean_ratio, 'large', 'small')) -> midwest

## group 컬럼의 해당하는 지역의 분포의 개수를 출력 막대그래프 출력
table(midwest$group)
qplot(midwest$group)

library(dplyr)
library(ggplot2)

midwest = ggplot2::midwest

## midwest 데이터프레임 정제 
## popadults 컬럼이 해당 지역의 성인 인구수
## poptotal 해당 지역의 총 인구 수 
## "전체 인구수 대비 미성년자의 인구 백분율"을 ratio_child 파생변수에 대입
## 미성년 인구 백분율이 가장 높은 지역 상위 5개를 출력

# 내장함수

# 미성년자의 인구 수 ( 총 인구수 - 성인 인구수 )
midwest$poptotal - midwest$popadults -> child_data
# 전체 인구수 대비 미성년자의 인구 백분율 ( 미성년자의 인구수 / 전체 인구수 * 100 )
child_data / midwest$poptotal * 100 -> midwest$ratio_child
# ratio_child를 기준으로 내림차순 정렬로 변경
order(midwest$ratio_child, decreasing = TRUE) -> flag
midwest[flag, c("county", "ratio_child")] -> child_data
head(child_data, 5)
# 패키지
midwest2 = ggplot2::midwest

midwest2 %>% 
  mutate(ratio_child = (poptotal - popadults) / poptotal * 100 ) -> midwest2 

midwest2 %>%   
  arrange(desc(ratio_child)) %>% 
  select(county, ratio_child) %>% 
  head(5)



## 미성년의 비율이 40% 이상이면 large
## 30% 이상 40% 미만이면 middle
## 30% 미만이면 small
## grade 파생변수 생성
## grade별 빈도수를 출력, 막대그래프 표시 

# 내장함수 
# ifelse(조건식, 참인경우 결과, 거짓인 경우 결과)
ifelse(
  midwest$ratio_child >= 40, 
  "large",  
  ifelse(
    midwest$ratio_child >= 30, 
    "middle", 
    "small"
  )
) -> midwest$grade

# 빈도수 출력
table(midwest$grade)
# 막대그래프 출력
qplot(midwest$grade)

# 패키지

midwest2 %>% 
  mutate(
    grade = ifelse(
      ratio_child >=40, 
      "large", 
      ifelse(
        ratio_child >= 30, 
        "middle", 
        "small"
      )
    )
  ) %>% 
  group_by(grade) %>% 
  summarise(count = n())





