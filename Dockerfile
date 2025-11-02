FROM python:3.13-slim-trixie AS base
WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    libffi-dev \
    libssl-dev \
    python3-dev \
    linux-headers-arm64 \
    && rm -rf /var/lib/apt/lists/*

FROM base AS test
COPY . .
RUN pip install --no-cache-dir poetry \
    && poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi
CMD ["pytest"]