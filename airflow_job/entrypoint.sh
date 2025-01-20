#!/bin/bash
set -e

# PostgreSQL 서버 대기
until pg_isready -h postgres -p 5432 -U airflow; do
    echo "Waiting for PostgreSQL to be ready..."
    sleep 2
done

# Airflow 데이터베이스 초기화 및 웹 서버 시작
airflow db init
exec airflow webserver
