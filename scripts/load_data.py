import pandas as pd
from sqlalchemy import create_engine

# 파일 경로 수정
file_path = "/app/data/online_retail.csv"

# 데이터 로드
try:
    data = pd.read_csv(file_path, encoding="ISO-8859-1")
    print("Data loaded successfully!")
except FileNotFoundError:
    print(f"File not found: {file_path}")

# PostgreSQL 연결
engine = create_engine("postgresql://airflow:airflow@localhost:5432/airflow")

# 데이터베이스에 데이터 삽입
data.to_sql("online_retail_raw", engine, if_exists="replace", index=False)
print("Data loaded successfully!")