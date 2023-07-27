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





