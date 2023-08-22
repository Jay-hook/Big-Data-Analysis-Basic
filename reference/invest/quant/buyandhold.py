import pandas as pd
import numpy as np
from datetime import datetime

def buyandhold(df, col = 'Close' , start = '20100101', end = "20230818"):
    # 인덱스가 Date인가?
    # 인덱스가 Date가 아니면 Date를 인덱스로 변경
    if 'Date' in df.columns:
        # 컬럼에 Date가 포함되어있으면 Date를 인덱스로 변경
        df = df.set_index('Date')
    # 인덱스를 시계열 데이터 변경
    df.index = pd.to_datetime(df.index, format='%Y-%m-%d')
    # 수정 종가만으로 이루어진 데이터프레임으로 변경
    df = df[[col]]
    # start, end로 인덱스 필터링
    start = datetime.strptime(start, '%Y%m%d').isoformat()
    end = datetime.strptime(end, '%Y%m%d').isoformat()
    df = df.loc[start:end]
    # 결측치, 무한대의 값을 제거 
    # 인덱스의 조건식
    flag = ~df.isin([np.nan, np.inf, -np.inf]).any(axis=1)
    df = df.loc[flag]
    # 일별 수익율 파생변수 생성
    df['daily_rtn'] = df[col].pct_change()
    # 누적 수익율 파생변수 생성
    df['st_rtn'] = (1 + df['daily_rtn']).cumprod()
    # 데이터프레임을 리턴
    return df