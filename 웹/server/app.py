# 프레임워크(라이브러리 모음) 로드 
from flask import Flask, request,\
      render_template, redirect
# 외부의 라이브러리 호출
import sql_mod as sm
import pandas as pd

# sql class 생성
db = sm.Database(
    'localhost', 
    'root',
    '1234', 
    'ubion8', 
    3306
)

# Flask 클래스를 생성해서 웹 서버 구축
# 클래스를 생성 
# Flask(파일의 이름) -> __name__ : 현재 파일의 이름
app = Flask(__name__)

# api 생성하는 과정
# 네비게이터 함수
# 특정한 주소로 요청이 들어왔을때 바로 아래의 함수를 호출 
# @app.route('/') 네이게이터 함수의 의미
# -> localhost:3000/ 로 요청이 들어왔을때 아래의 함수를 호출
@app.route("/")
def index():
    return render_template('login.html')

# 다른 api를 생성
# localhost:3000/second
@app.route("/second")
def second():
    return "Second Page"

# localhost:3000/login [get]형태의 주소를 생성
@app.route("/login")
def login():
    # 유저가 보낸 데이터를 변수에 대입 
    # 유저의 요청 메시지 안에 유저가 입력한 데이터들이 존재
    _id = request.args['input_id']
    _pass = request.args['input_pass']
    print('/login get message :',_id, _pass)
    # 유저가 입력한 id가 'test'이고 password가 '1234'인 경우 로그인 성공 메시지 
    # 아니라면 로그인 실패 메시지
    if (_id == 'test') & (_pass == '1234'):
        # 새로운 페이지 render
        return render_template('main.html')
    else:
        # 로그인 화면으로 돌아간다.
        return redirect("/")
    
# localhost:3000/login2 [post] 주소 생성
@app.route("/login2", methods=['post'])
def login2():
    # post 형식으로 데이터가 들어오는 경우 
    _id = request.form['input_id']
    _pass = request.form['input_pass']
    print("/login2 post message :", _id, _pass)
    print("post message :", request.form)
    # _id, _pass의 값을 sql 쿼리문에 대입 
    sql = """
        select 
        * 
        from 
        user 
        where 
        id = %s 
        and 
        password = %s
    """
    value = [_id, _pass]
    result = db.query(sql, value)
    # result의 길이가 0이면 로그인이 실패
    # result의 길이가 1이면 로그인이 성공
    if len(result) == 0:
        return redirect("/")
    else:
        # 로그인 성공시 result 
        # [{'id':유저입력한id, 'password':유저가 입력한 password
        # , 'name': id값에 해당하는 name, 
        # 'phone':id값에 해당하는 phone}]
        user_name = result[0]['name']
        return render_template(
            'main.html',
            user = user_name 
        )
    
# 회원 가입 주소를 생성
# localhost:3000/signup [get] 방식으로 주소 생성
@app.route('/signup')
def signup():
    # 회원 정보를 입력하는 화면을 render
    return render_template('signup.html')

# 회원의 정보를 받아서 sql에 데이터를 삽입
@app.route('/signup2', methods=['post'])
def signup2():
    # 유저가 보낸 데이터들을 변수에 대입 & 확인
    _id = request.form['input_id']
    _pass = request.form['input_pass']
    _name = request.form['input_name']
    _phone = request.form['input_phone']
    print('/signup2 [post] message :', _id, _pass, _name, _phone)
    # sql에 데이터를 삽입
    sql = """
        insert 
        into 
        user 
        values 
        (%s, %s, %s, %s)
    """
    value = [_id, _pass, _name, _phone]
    db.query(sql, value)
    return redirect('/')

# Flask라는 클래스에서 run()함수를 호출
# run()함수는 서버를 실행
# host -> 특정한 주소들만 접속이 가능하도록 설정
# port -> 내 컴퓨터에서 특정한 포트를 지정해서 해당하는 서버를 연결 번호
app.run(port=3000)