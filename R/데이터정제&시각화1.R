## sav 파일 로드 
## 패키지 설치 
install.packages('foreign')
library(foreign)


welfare = read.spss("../csv/Koweps_hpc10_2015_beta1.sav", 
          to.data.frame = T) 

# 컬럼의 이름을 변경 

welfare = rename(
  welfare, 
  gender = h10_g3, 
  birth = h10_g4, 
  marriage = h10_g10, 
  religion = h10_g11, 
  income = p1002_8aq1, 
  code_job = h10_eco9
)

# 컬럼을 gender, birth, 
# marriage, religion, income, code_job를 따로 추출하여 
# 새로운 변수에 저장

welfare %>% 
  select(
    gender, 
    birth, 
    marriage, 
    religion, 
    income, 
    code_job
  ) -> welfare_copy

## 데이터프레임의 결측치를 확인 
table(is.na(welfare_copy))



## gender컬럼의 데이터의 빈도수를 체크 '
table(welfare_copy$gender)
table(is.na(welfare_copy$gender))
## gender가 1 인 경우 'male', 
## gender가 2 인 경우 'female',
## gender가 9 인 경우 'n'
ifelse(
  welfare_copy$gender == 1, 
  "male", 
  ifelse(
    welfare_copy$gender == 2, 
    'female', 
    'n'
  )
) -> welfare_copy$gender

# 데이터프레임[]를 이용하여 값을 대체하는 방법
welfare_copy[welfare_copy$gender == 1 , 'gender'] = 'male'
welfare_copy[welfare_copy$gender == 2 , 'gender'] = 'female'
welfare_copy[welfare_copy$gender == 9 , 'gender'] = 'n'

table(welfare_copy$gender)

## 성별을 기준으로 월급의 차이가 실제로 존재하는가???
welfare_copy$income == 9999 | welfare_copy$income == 0
table(welfare_copy$income %in% c(0, 9999))

#case1
welfare_copy[welfare_copy$income %in% c(0, 9999), 'income'] = NA

#case2
ifelse(
  welfare_copy$income %in% c(0, 9999), 
  NA, 
  welfare_copy$income
) -> welfare_copy$income

## 성별에 따른 평균 월급의 차이
## 1. income데이터에서 결측치를 제외
## 2. gender를 기준으로 그룹화
## 3. 그룹화한 데이터에서 income의 평균을 구한다. 
## 4. 해당하는 데이터를 시각화

welfare_copy %>% 
  filter(!is.na(income)) %>% 
  group_by(gender) %>% 
  summarise(income_mean = mean(income)) -> gender_income

ggplot(
  data = gender_income, 
  aes(x = gender, y=income_mean)
) + geom_col()


## 나이와 관련해서 월급에 차이가 어느정도 날것인가?
## 나이(age) 컬럼이 존재하지 않는다
## birth을 이용하여 age 컬럼을 하나 생성 ( 현재 년도 2015 )
## age에 이상치가 존재하는지 확인( 음수의 데이터가 존재하는지 )
## income의 결측치를 제거 
## age를 기준으로 그룹화
## income의 평균값을 출력
## 막대그래프로 시각화

## age 컬럼을 생성 
## 현재 년도 - 생년

2015 - welfare_copy$birth -> welfare_copy$age

welfare_copy %>% 
  mutate(age = 2015 - birth) -> welfare_copy

table(is.na(welfare_copy$age))
table(welfare_copy$age < 0)

welfare_copy %>%
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(income_mean = mean(income)) -> age_income

## 시각화
ggplot(
  data = age_income, 
  aes(x = age, y = income_mean)
) + geom_col()

# 가장 많은 임금을 받는 나이를 확인해보자
age_income %>% 
  arrange(desc(income_mean)) %>% 
  head(10)


## 연령대별 임금의 차이가 얼마나 나는가?
## 연령대(ageg) 
## 나이가 30세 미만 -> young
## 나이가 30세 이상 60세 미만 -> middle
## 60세 이상이면 -> old
## 연령대별 임금의 차이를 확인 (수치화, 시각화)

## 그래프의 순서를 young , middle, old 순으로 그래프의 순서를 변경



