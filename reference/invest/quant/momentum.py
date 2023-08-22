import pandas as pd
import numpy as np
from datetime import datetime


# 첫 번째 함수 
def add_col(df, col = 'Close', start = '20000101', end='20231231'):
    # Date 라는 컬럼이 존재하는가?
    if 'Date' in df.columns:
        df.set_index('Date', inplace=True)
    # 시작시간은 1년 전으로 돌린다
    start = int(start)-10000
    start = datetime.strptime(str(start), '%Y%m%d').isoformat()
    end = datetime.strptime(end, '%Y%m%d').isoformat()
    
    # 수정종가를 제외한 나머지 컬럼은 제거 
    df = df[[col]]

    # 결측치와 무한대가 아닌 경우 조건식 생성
    flag = ~(df.isin([np.nan, np.inf, -np.inf]).any(axis=1))
    df = df.loc[flag]

    # 인덱스를 시계열 데이터로 변경 
    df.index = pd.to_datetime(df.index, format='%Y-%m-%d')

    # 시간시간과 종료시간으로 필터
    df = df.loc[start:end]

    # 인덱스의 시계열중 '년-월' 추출하여 STD-YM에 대입
    df['STD-YM'] = (df.index.strftime('%Y-%m')).to_list()

    return df

def add_df(df):
    # 기준이 되는 컬럼
    col = df.columns[0]
    # case1
    # 새로운 컬럼을 생성
    # df2 = pd.DataFrame()

    # # STD-YM데이터의 중복된 데이터를 제거하고 리스트 형태로 변수에 대입
    # _list = df['STD-YM'].unique()

    # # _list를 기준으로 반복문을 사용
    # for i in _list:
    #     last_data = df.loc[df['STD-YM'] == i].tail(1)
    #     df2 = pd.concat([df2, last_data], axis=0)

    # case2 인덱스의 조건식으로 말일의 데이터를 출력(현재행의 STD-YM과 다음 행의 STD-YM이 다른 경우)
    flag = df['STD-YM'] != df.shift(-1)['STD-YM']
    df2 = df.loc[flag]

    # 전월의 종가를 BF_1M에 대입
    df2['BF_1M'] = df2.shift(1)[col].fillna(0)
    # 전 년도의 종가를 BF_12M에 대입
    df2['BF_12M'] = df2.shift(12)[col].fillna(0)

    return df2

# 세 번째 함수
def add_rtn(df1, df2):
    # df1에 trade와 return 추가 
    df1['trade'] = ""
    df1['return'] = 1


    # 모멘텀 지수를 이용하여 거래내역을 추가 
    for i in df2.index:
        signal = ""
        # 모멘텀 인덱스를 변수에 대입
        momentum_index = df2.loc[i, 'BF_1M'] / df2.loc[i, 'BF_12M'] - 1
        # 모멘텀 인덱스가 0보다 크고 무한대가 아니라면 구매
        flag = True if((momentum_index > 0) and 
                        (momentum_index != np.inf) and 
                        (momentum_index != -np.inf)) else False
        if flag:
            signal = 'buy'
        # 모멘텀 인덱스를 기준으로 구매 내역을 추가
        df1.loc[i, 'trade'] = signal

    # 수익율을 계산 
    rtn = 1 
    buy = 0 
    sell = 0
    # 기준이 되는 컬럼의 이름
    col = df1.columns[0]
    for i in df1.index:
        # 구매 한 날이라면? -> 전날의 trade가 ""이고 오늘의 trade가 'buy'인 경우
        if (df1.loc[i, 'trade'] == 'buy') and (df1.shift(1).loc[i, 'trade'] == ''):
            buy = df1.loc[i, col]
            print('매수일 : ', i, "매수가 : ", buy)
        # 판매한 날이라면? -> 전날의 trade가 "buy"이고 오늘의 trade가 ''인 경우
        elif (df1.loc[i, 'trade'] == '') and (df1.shift(1).loc[i, 'trade'] == 'buy'):
            sell = df1.loc[i, col]
            # 수익율 계산
            rtn = sell / buy
            print('매도일 : ', i, "매도가 :", sell, '수익율 :', rtn)
            df1.loc[i, 'return'] = rtn
    
    # 누적 수익율을 계산
    acc_rtn = 1

    for i in df1.index:
        acc_rtn *= df1.loc[i, 'return']
        df1.loc[i, 'acc_rtn'] = acc_rtn
    print(acc_rtn)
    
    return df1