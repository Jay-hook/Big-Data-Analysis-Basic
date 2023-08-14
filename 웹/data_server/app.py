# 라이브러리 로드 
from flask import Flask, request
import pandas as pd

# Flask 클래스 생성
app = Flask(__name__)

# api 생성
# localhost:5000/corona [get] 요청 시
@app.route('/corona')
def corona():

    # 특정 유저만이 사용하도록 api 구성
    # serviceKey 데이터를 유저에게서 받아서 
    # 등록되어있는 serviceKey인 경우에 데이터를 보내준다.
    _serviceKey = request.args['serviceKey']
    if _serviceKey == 'ubion':
        # 외부의 있는 csv 파일 로드 
        df = pd.read_csv("../../csv/corona.csv")
        # Unnamed: 0 라는 컬럼을 삭제
        df.drop('Unnamed: 0', axis=1, inplace=True)
        # 유저에게 데이터를 보낸다
        result = df.to_dict('records')
    else:
        result = 'serviceKey Error'
    
    return result

app.run(port=5000)