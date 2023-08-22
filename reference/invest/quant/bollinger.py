import pandas as pd 
import numpy as np
from datetime import datetime

# 첫번째 함수 생성
def create_band(df, col = 'Close', start = '20100101', end = '20230818'):
    # 컬럼에 Date가 존재한다면
    if 'Date' in df.columns:
        # Date를 인덱스로 변경
        df = df.set_index('Date')
    # 인덱스를 시계열 변경
    df.index = pd.to_datetime(df.index, format='%Y-%m-%d')
    # 선택한 컬럼을 제외한 나머지 컬럼은 삭제 -> 선택한 컬럼만 출력
    df = df[[col]]
    # 결측치, 무한대가 아닌 인덱스의 조건식
    flag = ~df.isin([np.nan, np.inf, -np.inf]).any(axis=1)
    # 인덱스 조건식을 df에 넣어준다. 
    df = df.loc[flag]
    # 이동 평균선 생성
    df['center'] = df[col].rolling(20).mean()
    # 상단 밴드 생성
    df['ub'] = df['center'] + (2 * df[col].rolling(20).std())
    # 하단 밴드 생성
    df['lb'] = df['center'] - (2 * df[col].rolling(20).std())
    # 시작 시간과 종료시간으로 필터링
    start = datetime.strptime(start, '%Y%m%d').isoformat()
    end = datetime.strptime(end, '%Y%m%d').isoformat()
    df = df.loc[start:end]
    return df

# 두 번째 함수 생성
# 매개변수 2개(데이터프레임, 컬럼)
def add_trade(df):
    col = df.columns[0]
    # 거래 내역이라는 파생 변수를 생성
    df['trade'] = ""
    # 거래 내역을 추가
    for i in df.index:
        # 상단밴드보다 종가가 높은 경우
        if df.loc[i, col] > df.loc[i, 'ub']:
            df.loc[i, 'trade'] = ''
        # 종가가 하단밴드보다 낮은 경우
        elif df.loc[i, col] < df.loc[i, 'lb']:
            df.loc[i, 'trade'] = 'buy'
            # 구매 날짜에 출력
            if df.shift(1).loc[i, 'trade'] == '':
                print('구매일 :', i)
        # 종가가 밴드 사이에 있는 경우
        else:
            # 현재 구매상태라면?
            if df.shift(1).loc[i, 'trade'] == 'buy':
                df.loc[i, 'trade'] = 'buy'
            else:
                df.loc[i, 'trade'] = ''
    
    return df
        

# 세 번째 함수
def add_rtn(df):
    # 기준이 되는 종가
    col = df.columns[0]
    # 수익율 파생변수 생성(데이터 1)
    df['return'] = 1
    # 수익율, 구매가, 판매가 변수 생성
    rtn = 1.0
    buy = 0.0
    sell = 0.0

    # 수익율 대입 
    for i in df.index:
        # 매수가를 입력
        if (df.shift(1).loc[i, 'trade'] == '') and \
            (df.loc[i, 'trade'] == 'buy'):
            buy = df.loc[i, col]
            print('매수일 :', i, '매수가 :', buy)
        # 매도가, 수익율을 입력
        elif (df.shift(1).loc[i, 'trade'] == 'buy') and \
            (df.loc[i, 'trade'] == ''):
            sell = df.loc[i, col]
            # 수익율 계산
            # buy -> 100, sell -> 120  수익율 +20% / 120%
            # (120 - 100) / 100 + 1 -> 1.2
            rtn = (sell - buy) / buy + 1
            # 수익율을 데이터프레임에 대입
            df.loc[i, 'return'] = rtn
            print('매도일 :', i, '매도가 :', sell, '수익율 :', rtn)
        
    # 누적 수익율 계산

    # 누적 수익율 기본값 생성
    acc_rtn = 1.0

    for i in df.index:
        rtn = df.loc[i, 'return']
        acc_rtn *= rtn
        df.loc[i, 'acc_rtn'] = acc_rtn
    
    # 누적 수익율을 출력
    print("누적 수익율 :",acc_rtn)

    return df