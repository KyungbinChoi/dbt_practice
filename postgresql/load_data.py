import pandas as pd
from sqlalchemy import create_engine

# 데이터 로드
file_path = "/app/data/online_retail.csv"
try:
    data = pd.read_csv(file_path, encoding="ISO-8859-1")
    print("Data loaded successfully!")
except FileNotFoundError:
    print(f"File not found: {file_path}")
    exit(1)

# PostgreSQL 연결
engine = create_engine("postgresql://airflow:airflow@postgres:5432/airflow")

# 데이터베이스에 데이터 삽입
try:
    data.to_sql("online_retail_raw", engine, if_exists="replace", index=False)
    print("Data loaded to PostgreSQL successfully!")
except Exception as e:
    print(f"Failed to load data to PostgreSQL: {e}")
