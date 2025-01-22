from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.operators.dummy import DummyOperator
from datetime import datetime,timedelta
import pandas as pd
from sqlalchemy import create_engine
import pendulum

default_args = {
    "owner": "airflow",
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
    'start_date': datetime(2024, 1, 1, tzinfo=pendulum.timezone("Asia/Seoul")),
}

def transform_data():
    engine = create_engine("postgresql://airflow:airflow@postgres:5432/airflow")
    with engine.connect() as connection:
        query = "SELECT * FROM online_retail_raw"
        df = pd.read_sql(query, connection)

        # 데이터 변환 로직
        df["total_amt"] = df["Quantity"] * df["Price"]
        # lower case
        df.columns = [
            "invoice",
            "stockcode",
            "description",
            "quantity",
            "invoice_date",
            "price",
            "customer_id",
            "country",
            "total_amt"
        ]
        df.to_sql("online_retail_transformed", con=connection, if_exists="replace", index=False)

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
    start_task = DummyOperator(task_id='start_task', dag=dag)

    start_task >> etl_task
