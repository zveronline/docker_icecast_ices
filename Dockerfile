FROM alpine:3.12

ENV LANG=ru_RU.UTF-8 \
LANGUAGE=ru_RU.UTF-8

RUN apk add --update icecast bash nano tzdata supervisor \
&& cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime \
&& echo "Europe/Moscow" > /etc/timezone \
&& apk del tzdata \
&& mkdir -p /etc/supervisor.d

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
