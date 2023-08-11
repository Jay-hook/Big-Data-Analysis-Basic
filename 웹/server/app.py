# 프레임워크(라이브러리 모음) 로드 
from flask import Flask

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
    return "Hello World"

# 다른 api를 생성
# localhost:3000/second
@app.route("/second")
def second():
    return "Second Page"

# Flask라는 클래스에서 run()함수를 호출
# run()함수는 서버를 실행
# host -> 특정한 주소들만 접속이 가능하도록 설정
# port -> 내 컴퓨터에서 특정한 포트를 지정해서 해당하는 서버를 연결 번호
app.run(port=3000)