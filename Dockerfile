FROM alpine:3.15

RUN mkdir -p /
WORKDIR /

RUN apk add --no-cache git make gcc libc-dev g++ linux-headers && \
    git clone https://github.com/ereb-thanatos/cossacks3-lan-server.git && \
    cd /cossacks3-lan-server && \
    git submodule update --init --recursive && \
    g++ src/*.cpp -DNDEBUG -I asio/asio/include -lpthread -o cossacks3-server && \
    chmod 755 /cossacks3-lan-server/cossacks3-server && \
    apk del git make gcc libc-dev linux-headers

EXPOSE 31523
WORKDIR /cossacks3-lan-server
ENTRYPOINT ./cossacks3-server
