FROM postgres:13

# 필수 패키지 설치
RUN apt-get update && apt-get install -y \
    python3 \
    python3-venv \
    python3-dev \
    build-essential \
    libpq-dev \
    && apt-get clean

# 가상 환경 생성 및 라이브러리 설치
RUN python3 -m venv /opt/venv
COPY requirements.txt /tmp/requirements.txt
RUN /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install --no-cache-dir -r /tmp/requirements.txt

# 프로젝트 디렉토리 복사
COPY dags/ /app/dags/
COPY dbt/ /app/dbt/
COPY data/ /app/data/
COPY scripts/ /app/scripts/

# PATH 환경 변수 설정
ENV PATH="/opt/venv/bin:$PATH"

# 작업 디렉토리 설정
WORKDIR /app

# PostgreSQL 실행 (기본 동작)
CMD ["postgres"]
