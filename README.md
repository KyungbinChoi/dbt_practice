# dbt_practice
* dbt airflow 기반의 mart 구축 실습
* Process
    * Docker 를 활용한 PostgreSQL , Airflow 설치
    * PostgreSQL DB 준비
    * Airflow DAG 생성
    * dbt 프로젝트 구성
    * 실행 및 테스트

## repository
```
project/
├── postgresql/
│   ├── Dockerfile
│   ├── requirements.txt
│   ├── load_data.py
│   ├── data/
│   │   └── online_retail.csv
│   ├── entrypoint.sh
│
├── airflow_job/
│   ├── Dockerfile
│   ├── requirements.txt
│   ├── dags/
│   │   └── my_dag.py
│   ├── dbt/
│   │   ├── dbt_project.yml
│   │   └── profiles.yml
│   ├── entrypoint.sh
│
├── docker-compose.yml
└── README.md

```
