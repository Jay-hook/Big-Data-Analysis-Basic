# 결측치 

c1 <- c(1, 2, NA, NA, 5)
c2 <- c(1, 2, 3, 4, 5)
c3 <- c(NA, NA, 3, 4, 5)

df <- data.frame(c1, c2, c3)
df

# 결측치를 체크 하는 함수 
# is.na()
is.na(df)

# c1 컬럼의 결측치 체크 
is.na(df$c1)
df[!is.na(df$c1), ]

# 데이터프레임에서 결측치의 개수를 확인하려면?
# is.na()사용하여 결측치를 체크 -> True의 개수를 확인
table(is.na(df))

# na.rm 기억이 안 나는 경우?
df[!is.na(df$c1), ] -> data
mean(data$c1)

mean(df$c1, na.rm = T)
mean(df$c2)
mean(df$c3, na.rm = T)

# csv_exam.csv 파일 로드 
exam = read.csv("../csv/csv_exam.csv")
head(exam)

# 데이터프레임에 결측치를 추가 
exam[c(3, 8, 10), 'math'] = NA
exam


# class 별 수학 성적의 평균 값은 출력하시오

# mean(na.rm=T)를 사용한 방법
exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math, na.rm=T))


# 결측치를 제외하고 mean()
exam %>% 
  filter(!is.na(math)) %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math))

# 수학 성적의 결측치에 수학 성적의 평균 값으로 대체

# 평균 성적의 소수점 1자리를 두고 반올림
round(mean(exam$math, na.rm=T), 1) -> mean_math

# 수학 성적은 추출(백터데이터)
# 해당하는 백터데이터의 각각 원소들이 결측치인가? 확인
# 결측치가 아니라면 기존의 값을 유지 
# 결측치라면 mean_math로 대체
exam$math
ifelse(is.na(exam$math), mean_math, exam$math) -> exam$math

# 결측치의 개수 확인 
table(is.na(exam))

# 시각화 패키지(ggplot2)

# 산점도 그래프 
mpg = ggplot2::mpg
head(mpg, 1)

ggplot(
  data = mpg, 
  aes(x = displ, y = hwy)
) + geom_point() + xlim(3, 6) + ylim(20, 30)

# 막대그래프 
mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy)) -> group_data

group_data
ggplot(
  data = group_data, 
  aes(x = drv, y = mean_hwy)
) + geom_col()

ggplot(
  data = group_data, 
  aes(
    x = reorder(drv, desc(mean_hwy)), 
    y = mean_hwy
    )
) + geom_col()

# 데이터의 개수를 출력하는 그래프 
ggplot(
  data = mpg, 
  aes(x = drv)
) + geom_bar()

economics = ggplot2::economics

View(economics)
# 라인 그래프 생성
ggplot(
  data = economics, 
  aes(x = date, y = unemploy)
) + geom_line()

# 박스플롯 
ggplot(
  data = mpg, 
  aes(x = drv, y = hwy)
) + geom_boxplot()

# 극단치 
# boxplot(백터데이터)
boxplot(mpg$cty)

boxplot(mpg$cty)$stats

# 도심 연비(cty)의 값이 9미만이거나 
# 26 초과인 경우에 cty의 값을 NA로 변경
# mpg데이터에서 NA가 포함되어있는 행을 삭제

# 백터데이터 추출 (cty)
mpg$cty < 9 | mpg$cty > 26 -> flag

ifelse(flag, NA, mpg$cty) -> mpg$cty
table(is.na(mpg$cty))

mpg2 = ggplot2::mpg
mpg2$cty < 9 | mpg2$cty > 26 -> flag2
mpg2[flag, 'cty'] = NA
table(is.na(mpg2$cty))

# 결측치가 포함되어있는 행을 삭제하는 함수 
# na.omit(데이터프레임명)
dim(mpg)

na.omit(mpg) -> mpg
dim(mpg)

# 필터를 이용하여 결측치를 제거 

mpg2[!is.na(mpg2$cty), ] -> data
dim(data)

mpg2 %>% 
  filter(!is.na(cty)) -> data2
dim(data2)
