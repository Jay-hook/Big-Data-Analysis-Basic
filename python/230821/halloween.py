import pandas as pd
from datetime import datetime
from dateutil.relativedelta import relativedelta

def six_month(df, start = 2000, end = 2019, month = 11):
    if 'Date' in df.columns:
        df.set_index('Date', inplace=True)
    # 인덱스를 시계열로 변경
    df.index = pd.to_datetime(df.index, format='%Y-%m-%d')

    # 누적수익율
    acc_rtn = 1

    for i in range(start, end):
        _start = datetime(year = i, month = month, day = 1)
        _end = _start + relativedelta(months=5)

        # 구매하는 달
        buy_mon = _start.strftime('%Y-%m')
        # 판매하는 달
        sell_mon = _end.strftime('%Y-%m')

        # 구매한 가격 
        buy = df.loc[buy_mon].iloc[0]['Open']
        # 판매한 가격
        sell = df.loc[sell_mon].iloc[-1]['Close']

        # rtn = (sell - buy) / buy + 1
        rtn = sell / buy

        # 누적수익율 계산
        acc_rtn *= rtn
        
    return acc_rtn