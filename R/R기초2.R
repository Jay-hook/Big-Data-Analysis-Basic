# 데이터프레임 
name = c('test', 'test2', 'test3', 'test4')
grade = c(1, 3, 2, 1)

student = data.frame(name, grade)
print(student)

score = c(60, 70, 80)

# 데이터프레임 생성시에는 같은 길이의 백터를 결합해야된다. 
# 길이가 다를 시에는 에러가 발생
data.frame(name, score)


# 행렬 생성 
midturm = c(70, 80, 60, 90)
final = c(60, 90, 80, 90)
score = cbind(midturm, final) 
print(score)

# 백터의 합
total_score = midturm + final 
print(total_score)

# 데이터프레임 + 행렬 + 백터 -> 새로운 데이터프레임을 생성
print(data.frame(student, score))
print(data.frame(student, total_score))
students = data.frame(student, score, total_score)
print(students)

# 새로운 컬럼을 추가 
gender = c("F", "M", "M", "F")
# data.frame()을 이용하여 새로운 데이터프레임 생성
print(data.frame(students, gender))
# cbind()을 이용하여 컬럼을 추가한다. 
print(cbind(students, gender))

print(students)

# 데이터프레임의 필터 기능 
# 하나의 열을 선택
print(students$name)
print(students[["name"]])
print(students[[1]])

# 인덱스를 필터
# 데이터프레임[행의 조건, 열의 조건]
print(students[1,])
print(students[c(2, 4), ])
print(students[1:3, ])

# 조건식 하나 생성
students[['grade']] >= 2

students[students[['grade']] >= 2, ]

# 중간의 성적이 70점 이상이고, 
# 기말의 성적이 90점 이상인 학생의 정보 출력
students$midturm >= 70 & students$final >= 90 -> flag

students[flag, ]

# 새로운 파생변수를 생성 (컬럼 추가)
students$gender = gender
print(students)

# 성별이 "M"인 학생의 중간 성적과 기말 성적을 출력
students[students$gender == 'M', c('midturm', 'final')]

# 데이터프레임에서 새로운 열을 추가 

new_student = data.frame(name = 'test5', 
                         grade = 2,  
                         gender = 'F', 
                         midturm = 90, 
                         final = 70, 
                         total_score = 160)
print(new_student)
# rbind()를 이용하여 새로운 데이터프레임에 행을 추가 
rbind(students, new_student)

# 함수 생성 
# 매개변수 2개 생성(df, c)
# df에는 데이터프레임, c에는 컬럼의 위치
# 데이터프레임의 특정한 열을 출력
# c의 기본값은 1로 지정
func_1 = function(df, c=1){
  result = df[[c]]
  return (result)
}
func_1(students, 6)
func_1(students)

# 데이터프레임의 정렬을 변경 
# order(데이터프레임$컬럼) -> 
  # 해당하는 컬럼의 데이터를 오름차순 정렬로 행의 값들은 정렬
order(students$grade, decreasing = FALSE)
students[order(students$grade), ]

# 내림차순 정렬로 데이터의 순서를 변경
# order(데이터프레임$컬럼, decreasing=TRUE)
order(students$grade, decreasing = TRUE)
students[order(students$grade, decreasing = TRUE), ]

# 경로 설정 
# 절대 경로 
  # 절대적인 주소
  # 환경이 변하더라도 위치는 변하지 않는다. 
  # ex) c:/users/admin/documents, url(www.google.com, www.naver.com)
# 상대 경로
  # 상대적인 주소
  # 환경이 변하면 유동성이 있게 위치가 변화한다. 
  # ./ : 현재 파일의 위치
  # ../ : 현재 위치에서 상위로 이동
  # 폴더명/ : 해당하는 하위 폴더로 이동

# 외부의 있는 데이터파일 로드 
# read.csv(파일의 위치 지정)
read.csv("./csv_exam.csv")

# R폴더에서 -> 상위 폴더로 이동 -> csv 하위폴더 이동 -> csv_exam.csv
# 절대 경로
read.csv("C:/Users/moons/Desktop/ubion-8/csv/csv_exam.csv")
# 상대 경로
read.csv("../csv/csv_exam.csv") -> df

# 데이터프레임에 상위 n개를 출력
# head(데이터프레임명, n)
head(df, 3)
head(df)
# 데이터프레임에 하위 n개를 출력
# tail(데이터프레임명, n)
tail(df, 3)
tail(df)

# console에서 데이터프레임 확인하는것이 아니라 표의 형태로 표시 
# View(데이터프레임명)
View(df)
# 데이터프레임의 크기를 출력
dim(df)
# 데이터프레임의 정보를 출력
str(df)
# 데이터프레임의 통계요약 정보 출력
summary(df)

# 새로운 컬럼 하나 생성(파생변수 생성)
# 수학 + 영어 + 과학 -> total_score
# df에서 하나의 컬럼을 선택하면 해당하는 데이터의 타입은 백터
print(df$math)
print(df$science)
print(df$english)
# 백터끼리의 합은 각 원소들의 합과 같다. 
df$math + df$science + df$english -> total_score


# 데이터의 변화는 없다 (출력물이 존재)
data.frame(df, total_score)
cbind(df, total_score)

# 대입 연산자를 이용하여 변수에 데이터를 변경해준다.(출력물이 존재하지 않는다.)
df$total_score = total_score

# 평균 점수(mean_score) 컬럼을 추가 
# total_score / 3 -> mean_score
df$total_score / 3
# 반올림 round()
round(df$total_score / 3, 2) -> df$mean_score
df



