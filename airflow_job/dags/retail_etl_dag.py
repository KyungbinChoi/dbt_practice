from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime,timedelta
import pandas as pd
from sqlalchemy import create_engine

default_args = {
    "owner": "airflow",
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
    "start_date": datetime(2025, 1, 1),
}

def transform_data():
    engine = create_engine("postgresql://airflow:airflow@postgres:5432/airflow")
    query = "SELECT * FROM online_retail_raw"
    df = pd.read_sql(query, engine)

    # 데이터 변환 로직
    df["TotalAmt"] = df["Quantity"] * df["UnitPrice"]
    df.to_sql("online_retail_transformed", engine, if_exists="replace", index=False)

with DAG(
    "retail_etl_dag",
    default_args=default_args,
    schedule_interval=None,
    catchup=False,
) as dag:
    etl_task = PythonOperator(
        task_id="transform_data",
        python_callable=transform_data,
    )
