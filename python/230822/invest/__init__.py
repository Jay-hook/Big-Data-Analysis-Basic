# invest  폴더 안에 quant폴더 안에 있는 모듈을 로드 
from invest.quant import buyandhold as bnh
from invest.quant import bollinger as boll
from invest.quant import momentum as mm

# Invest Class 하나 생성
class Invest:

    # 생성자 함수 
    def __init__(self, _df, _col='Close', 
                 _start='20100101', _end = '20231231'):
        # self변수들을 정의
        self.df = _df
        self.col = _col
        self.start = _start
        self.end = _end
    
    # buyandhold를 실행하는 함수를 생성 
    def buyandhold(self):
        result= bnh.buyandhold(
                    self.df, 
                    self.col, 
                    self.start, 
                    self.end
                )
        return result

    # bollinger를 실행하는 함수를 생성
    def bollinger(self):
        # 밴드를 생성하는 함수
        result = boll.create_band(
                    self.df, 
                    self.col, 
                    self.start, 
                    self.end
                )
        # 거래 내역을 추가하는 함수
        result = boll.add_trade(
                    result
                )
        # 수익율을 계산하는 함수
        result = boll.add_rtn(
                    result
                )
        
        return result
    
    # momentum 함수를 생성
    def momentum(self):
        # 년-월 컬럼을 생성하는 함수
        data1 = mm.add_col(
                    self.df, 
                    self.col, 
                    self.start, 
                    self.end
                )
        # 말일 데이터를 추출하여 전월 종가와 전년도 종가 컬럼을 생성
        data2 = mm.add_df(
                    data1
                )
        
        # 거래내역을 추가하고 수익율을 계산하는 함수 
        result = mm.add_rtn(
                    data1, 
                    data2
                )
        return result