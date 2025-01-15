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
 project-root/ 
 ├── dags/
 │   ├── retail_etl_dag.py          # Airflow DAG 스크립트 (데이터 로드 및 ETL 수행)
 │   ├── retail_mart_etl_dag.py     # Airflow DAG 스크립트 (dbt 모델 실행)
 ├── dbt/
 │   ├── dbt_project.yml            # dbt 프로젝트 설정 파일
 │   ├── profiles.yml               # dbt 프로파일 설정 (PostgreSQL 연결 정보)
 │   ├── models/
 │   │   ├── marts/
 │   │   │   ├── daily_sales.sql    # 일별 집계 모델
 │   │   │   ├── weekly_sales.sql   # 주별 집계 모델
 │   │   │   ├── monthly_sales.sql  # 월별 집계 모델
 │   │   │   ├── customer_stats.sql # 고객 통계량 모델
 │   │   └── staging/
 │   │       ├── online_retail_transformed.sql  # 변환된 데이터의 스테이징 모델
 ├── data/
 │   ├── online_retail_data.csv     # 원본 데이터 파일
 ├── scripts/
 │   ├── load_data.py               # 데이터베이스에 데이터를 로드하는 스크립트
 ├── docker-compose.yml             # PostgreSQL 및 Airflow 컨테이너 설정
 ├── requirements.txt               # Python 패키지 의존성 리스트
 ├── README.md                      # 프로젝트 설명 및 실행 방법
```
