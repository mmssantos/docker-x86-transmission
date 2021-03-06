FROM alpine:3.5

RUN apk update && apk add --update transmission-daemon && rm -rf /var/cache/apk/*

RUN mkdir -p /etc/transmission-daemon && mkdir -p /transmission/downloaded && mkdir -p /transmission/downloading

VOLUME ["/etc/transmission-daemon"]
VOLUME ["/transmission/downloaded"]
VOLUME ["/transmission/downloading"]

EXPOSE 9091 36019/tcp 36019/udp

ENTRYPOINT ["/usr/bin/transmission-daemon"]

CMD ["--foreground","--config-dir","/etc/transmission-daemon"]
