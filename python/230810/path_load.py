import pandas as pd
import os

# 함수 생성하여 매개변수 2개
def path_load(path, end):
    # path 매개변수에 들어오는 인자 값이 마지막이 /가 아니라면
    # if not(path.endswith('/')):
    if path[-1] != "/":
        # path = path + "/"
        path += "/"
    # end의 첫글자가 .이 아니라면
    # if end[0] != ".":
    if not(end.startswith('.')):
        end = '.' + end

    # path를 가지고 경로에 있는 파일의 목록을 로드 
    file_list = os.listdir(path)

    # end 매개변수에 입력된 인자값과 같은 확장자를 가진 파일들을 리스트에 대입
    file_list2 = []
    # file_list에서 end에서 지정한 확장자인 파일들을 새로운 리스트에 대입
    for file_name in file_list:
        if file_name.endswith(end):
            file_list2.append(file_name)
    print(file_list2)

    result = pd.DataFrame()

    for i in file_list2:
        # end의 인자값에 따라서 read함수를 지정
        if end == '.csv':
            df = pd.read_csv(path+i)
        elif end == '.json':
            df = pd.read_json(path+i)
        # elif (end == '.xlsx') | (end == '.xls'):
        elif end in ['.xlsx', 'xls']:
            df = pd.read_excel(path+i)
        else:
            return "지원이 되지 않는 확장자입니다."
        # 비어있는 데이터프레임과 로드한 데이터프레임을 유니언 결합
        result = pd.concat([result, df], axis=0, ignore_index=True)
    

    return result
