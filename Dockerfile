FROM python:3.13-slim-trixie AS base
WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    libffi-dev \
    libssl-dev \
    python3-dev \
    linux-headers-arm64 \
    wget \
    automake \
    autoconf \
    libtool \
    pkg-config \
    libpcre2-dev \
    libbison-dev \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Swig is required by lgpio, but is not packaged for trixie yet
RUN wget https://github.com/swig/swig/archive/master.tar.gz \
    && tar -xzf master.tar.gz \
    && cd swig-master \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && rm -rf swig-master master.tar.gz

# lgpio is not packaged for trixie yet
RUN wget https://github.com/joan2937/lg/archive/master.zip \
    && unzip master.zip \
    && cd lg-master \
    && make \
    && make install \
    && cd .. \
    && rm -rf lg-master master.zip

FROM base AS test
COPY . .
RUN pip install --no-cache-dir poetry \
    && poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi
CMD ["pytest", "--cov=gfxhat", "--cov-report=term-missing", "tests/"]