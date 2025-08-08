FROM alpine:latest

RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --no-cache openfortivpn@testing dante-server

WORKDIR /

COPY entrypoint.sh .

CMD ["sh", "/entrypoint.sh"]
