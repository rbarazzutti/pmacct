FROM ubuntu:bionic

RUN apt-get update && \
    apt-get -y install pkg-config libtool autoconf automake cmake bash wget git gcc g++ libssl-dev libpcap-dev libpq-dev libsqlite3-dev libmysqlclient-dev libnetfilter-log-dev mysql-client libtool autoconf automake libcurl4-openssl-dev && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/akheron/jansson && \
    cd jansson && \
    git checkout v2.12 && \
    autoreconf -i && \
    ./configure --prefix=/usr && \
    make && \
    make install && \
    cd / && \
    rm -rf jansson

RUN git clone https://github.com/edenhill/librdkafka && \
    cd librdkafka && \
    git checkout v1.2.1 && \
    ./configure --prefix=/usr && \
    make && \
    make install && \
    cd / && \
    rm -rf librdkafka

RUN git clone https://github.com/alanxz/rabbitmq-c && \
    cd rabbitmq-c && \
    git checkout v0.9.0 && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr .. && \
    cmake --build . --target install && \
    cd / && \
    rm -rf rabbitmq-c

RUN git clone --recursive https://github.com/maxmind/libmaxminddb && \
    cd libmaxminddb && \
    git checkout 1.4.2 && \
    ./bootstrap && \
    ./configure --prefix=/usr && \
    make && \
    make install && \
    cd / && \
    rm -rf libmaxminddb

RUN git clone https://github.com/ntop/nDPI && \
    cd nDPI && \
    git checkout 2.8-stable && \
    ./autogen.sh && \
    ./configure --prefix=/usr && \
    make && \
    make install && \
    ldconfig && \
    cd / && \
    rm -rf nDPI

RUN wget https://github.com/zeromq/libzmq/releases/download/v4.3.1/zeromq-4.3.1.tar.gz && \
    tar xfz zeromq-4.3.1.tar.gz && \
    cd zeromq-4.3.1 && \
    ./configure --prefix=/usr && \
    make && \
    make install && \
    cd / && \
    rm -rf zeromq*

RUN wget http://www-us.apache.org/dist/avro/avro-1.9.1/c/avro-c-1.9.1.tar.gz && \
    tar xfz avro-c-1.9.1.tar.gz && \
    cd avro-c-1.9.1 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    cd / && \
    rm -rf avro-c*

RUN git clone https://github.com/confluentinc/libserdes && \
    cd libserdes && \
    git checkout v5.3.1 && \
    ./configure --prefix=/usr && \
    make && \
    make install && \
    cd / && \
    rm -rf libserdes

COPY . /pmacct

RUN cd /pmacct && \
    ./autogen.sh && \
    ./configure --prefix=/usr --enable-mysql --enable-pgsql --enable-sqlite3 --enable-kafka --enable-geoipv2 --enable-jansson --enable-rabbitmq --enable-nflog --enable-ndpi --enable-zmq --enable-avro --enable-serdes && \
    make clean && \
    make && \
    make install && \
    cd / && \
    rm -rf pmacct

