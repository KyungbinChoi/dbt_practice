from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.dummy import DummyOperator
from datetime import datetime, timedelta
import pendulum

default_args = {
    "owner": "airflow",
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
    'start_date': datetime(2024, 1, 1, tzinfo=pendulum.timezone("Asia/Seoul")),
}
4
with DAG(
    "retail_mart_etl_dag",
    default_args=default_args,
    schedule_interval=None,
    catchup=False,
) as dag:
    dbt_dir = "/opt/airflow/dbt"

    # DBT Run Task
    dbt_run = BashOperator(
        task_id="dbt_run",
        bash_command=f"cd {dbt_dir} && dbt run",
    )

    # DBT Test Task
    dbt_test = BashOperator(
        task_id="dbt_test",
        bash_command=f"cd {dbt_dir} && dbt test",
    )

    # Task 실행 순서
    dbt_run >> dbt_test

