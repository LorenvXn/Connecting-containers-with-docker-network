FROM ubuntu:14.04
RUN apt-get update
RUN  apt-get upgrade -y
RUN  apt-get -y install gcc mono-mcs
RUN  apt-get -y install libpcap0.8-dev
RUN apt-get install -y libmysqlclient-dev
COPY . /home
WORKDIR /home
RUN  gcc create.c -o create  `mysql_config --cflags --libs`

EXPOSE 8091
