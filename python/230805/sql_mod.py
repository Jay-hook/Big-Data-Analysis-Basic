import pandas as pd
import pymysql 

class Database:
    # 생성자 함수 
    def __init__(self, _host, _user, _pass, _db, _port):
        self.db = pymysql.connect(
            host = _host, 
            user = _user, 
            password = _pass, 
            db = _db, 
            port = _port
        )
        self.cursor = self.db.cursor(pymysql.cursors.DictCursor)

    def query(self, sql, value = []):
        # 커서를 이용해서 sql 쿼리문 실행
        self.cursor.execute(sql, value)

        # sql 쿼리문의 시작이 select 라면
        if sql.lstrip().lower().startswith('select'):
            result = self.cursor.fetchall()
            result = pd.DataFrame(result)
        else:
            self.db.commit()
            result = 'Query Ok'
        return result