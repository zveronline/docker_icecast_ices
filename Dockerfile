FROM ubuntu:20.04

MAINTAINER Mikhail Mokhrachev "mihail.ite@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:unit193/test
RUN apt-get update && apt-get install -y wget sudo icecast2 libmp3lame-dev libxml2-dev libshout-dev libvorbis-dev supervisor build-essential && \
	rm -rf /var/lib/apt/lists/*

RUN wget https://ftp.osuosl.org/pub/xiph/releases/ices/ices-0.4.tar.gz && tar -zxf ices-0.4.tar.gz && \
	cd ices-0.4/ && ./configure --prefix=/usr --with-pic --with-lame &&  make && make install

#COPY audio /stream
RUN find /stream/tracks -type f -name \*.mp3 > /stream/tracks/playlist.txt
ADD cfg /app
COPY cfg/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
#RUN mkdir -p /var/log/ices/  &&  chmod 777 /var/log/ices/  && chown -R icecast2.icecast /app && chown -R icecast2.icecast /stream/*
#RUN find /stream/tracks -type f -name \*.mp3 > /stream/playlist.txt
RUN chown -R icecast2.icecast /app
#&& chown -R icecast2.icecast /stream && chmod 777 /stream

WORKDIR /app

CMD ["/usr/bin/supervisord"]
