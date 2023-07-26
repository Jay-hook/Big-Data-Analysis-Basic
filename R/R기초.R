# 변수를 설정
a <- 10
b = "test"
5 -> c
print(a)
print(b)
print(c)

# 백터 데이터를 생성
d = c(1, 2, 3, 4, 5)
print(d)
e <- 1:5
print(e)

# 행렬 생성
f = array(1:20, dim=c(4, 5))
print(f)
g = matrix(1:20, nrow = 2)
print(g)

# 리스트 데이터 생성 list(key = value, key2 = value2, ...)
a = list(name = 'test', age = 20, phone = "01012345678")
print(a)
# 리스트에서 name의 값만 출력하려면?
print(a["name"])
# 백터 데이터에서 특정 위치를 출력
print(d[1])

# 데이터프레임 생성
df = data.frame(name = c('test', 'test2'), 
                age = c(20, 30), 
                phone = c("01012345678", "01098765432"))
print(df)

# 연산자
x = 10
y = 3
print(x+y)
print(x-y)
print(x*y)
print(x/y)
print(x%%y)
print(x%/%y)

# 비교연산자
z = 10
print(x == y)
print(x == z)
print( x > y)
print(x < y)
print(x != y)

# 제어문 (조건문)
if (y > 5){
  print('y는 5보다 크다')
}else{
  print('y는 5보다 작거나 같다')
}

# 조건식이 여러개인 경우
score = 85
if (score > 90){
  print('A')
}else if(score > 80){
  print('B')
}else if(score > 70){
  print('C')
}else {
  print('D')
}

# 논리연산자를 이용한 if문
id = 'test'
pass = '12340'
if (id == 'test'|pass == '1234'){
  print('성공')
}else{
  print('실패')
}

# which문 (벡터데이터에서 특정한 값의 위치를 출력하는 구문)
name = c('test', 'test2', 'test3')
which(name == 'test2')
which(name != 'test')
which(name == 'test5')

# 반복문 
l = 1:10
for (i in l){
  print(i)
}
test_list = c(5, 3, 10, 1)
for (i in test_list){
  print(i)
}
test_list2 = c('test', 'test2', 'test3')
for (i in test_list2){
  print(i)
}

# while문

#  초기값을 지정 
a = 1

while(a <= 10){
  print(a)
  a = a + 1
}

# 1부터 10까지의 합계를 구하라

# 합계라는 변수를 하나 생성
result = 0

list_data = 1:10

for (i in list_data){
  result = result + i
}

result = 0
a = 1

while(a <= 10){
  a = a + 1
  result = result + a
}

# 1부터 100까지의 숫자 중 짝수의 합계는?
# 1부터 100까지의 합계를 출력
# 짝수의 조건을 생각(2로 나눈 나머지의 값이 0인 경우 -> i %% 2 == 0)
# 반복문에 짝수인 경우에만 합계에 더해주는 형태로 코드를 작성

# for문 
list_data = 1:100
result = 0
result2 = 0
for (i in list_data){
  if (i %% 2 == 0){
    result = result + i
  }else{
    result2 = result2 + i
  }
}
print(result)
print(result2)

# while문 
i = 1
result = 0

while(i <= 100){
  if(i %% 2 == 0){
    result = result + i
  }
  i = i + 1
}
print(result)

i = 2
result = 0
while (i <= 100){
  result = result +i
  i = i + 2
}
print(result)

# break구문 -> 반복문을 강제 종료
list_data = 1:100
for (i in list_data){
  print(i)
  if(i > 5){
    break
  }
}

a = 1
while(a <= 100){
  if(a > 5){
    break
  }
  a = a + 1
  print(a)
}

# next 구문 -> 반복문의 처음으로 돌아간다. 
list_data = 1:10
for (i in list_data){
  if(i < 3 ){
    next
  }
  print(i)
}

a = 1
while(a <= 10){
  if(a < 3){
    a = a + 1
    next
  }
  print(a)
  a = a + 1
}

# 1부터 100까지의 합계를 계산 중 합계가 500이 넘어가갈때의 값이 무엇인가?
# 1. 1부터 100까지의 합계를 구하는 반복문을 생성 
# 2. 합계가 500이 넘어갈 때 반복문을 종료
# 3. 합계와 i가 몇인지 출력

# for
list_data = 1:100
result = 0
for(i in list_data){  
  result = result + i 
  if(result > 500){
    break
  }
}
print(result)
print(i)

i = 0
result = 0
while (i <= 100){
  result = result + i
  if(result > 500){
    break
  }
  i = i + 1
}
print(result)
print(i)

# 함수 생성
# 함수명 = function(){}

# 매개변수가 존재하지 않는 함수를 생성&호출
func_1 = function(){
  print('Hello R')
}
func_1()

# 매개변수가 존재하는 함수 생성&호출
func_2 = function(x, y){
  result = x + y
  return (result)
}
func_2(5, 2)
# 매개변수와 인자의 개수를 다르게 호출하는 경우
func_2(5)

# 매개변수에 기본값을 지정하여 함수를 생성&호출
func_3 = function(x, y=3){
  result = x - y
  return (result)
}
func_3(5)
func_3(5, 1)
func_3(y = 5, x = 1)


func_4 = function(x, y=2, z=3, a=1, b=5){
  result = c(x, y, z, a, b)
  return (result)
}
func_4(10)
func_4(10, a = 20)


# 함수 생성
# 해당하는 함수는 매개변수 2개(start, end)
# start에서 end까지의 합계를 return 
func_5 = function(start, end){
  # start부터 end까지의 합계를 구한다. 
  
  # 합계라는 변수를 생성 0을 대입
  res = 0
  
  #for 
  # d_list = start:end
  # for (i in d_list){
  #   res = res + i
  # }
  
  # while 
  # start가 end보다 작은 경우(조건)
  # if(start < end){
  #   i = start
  #   while (i <= end){
  #     res = res+i
  #     i = i + 1
  #   }
  # }else{
  #   i = end
  #   while (i <= start){
  #     res = res+i
  #     i = i +1
  #   }
  # }
  
  i = min(start, end)  # start와 end중에 작은 값
  while(i <= max(start, end)){ #start와 end중에 큰 값
    res = res + i
    i = i + 1
  }

  return (res)
}
func_5(1, 10)
func_5(10, 1)

func_6 = function(start, end){
    result = sum(start:end)
    return (result)
}
func_6(1, 10)
func_6(10, 1)

# 인자의 개수가 가변인 경우 함수를 생성&호출
func_7 = function(a){
  print(a)
}
func_7(c(1,2,3,4,5))

# max() 함수를 생성
# 백터데이터를 인자값으로 받아와서 해당하는 원소들은 비교하여
# 가장 큰 값을 return을 해주는 함수 

data = c(5, 3, 10, 12)

func_8 = function(...){
  data = c(...)
  
  # 초기의 값 생성(백터의 첫번째 데이터)
  res = data[1]
  for (i in data){
    # res와 data에 있는 항목들은 하나씩 비교
    # data에 있는 항목이 더 크다면 
    # res를 해당하는 값으로 변경
    if(res < i){
      res = i
    }
  }
  return (res)
}
func_8(3, 1, 5, 2, 7, 4)
func_8(-3, -10, -2, -4)

mean(1:10)

data = c(5, 3, 2, 1)
length(data)


# 가변의 인자값들의 평균을 구하는 함수를 생성
# 평균 -> 합계 / 갯수
func_9 = function(...){
  data = c(...)
  
  # 백터데이터들의 합계
  data_sum = 0
  for (i in data){
    data_sum = data_sum + i
  }
  # data_sum = sum(data)
  
  result = data_sum / length(data)
  return (result)
}
func_9(1,2,3,4,5,6,7,8,9,10)
func_9(3, 5, 7)


# 커스텀 연산자
"%s%" = function(x, y){
  result = (x + y)^y
  return (result)
}
2%s%3





