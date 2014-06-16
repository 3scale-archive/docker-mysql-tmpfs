FROM ubuntu:trusty

MAINTAINER Michal Cichra <michal@3scale.net> # 2014-06-12

RUN apt-get update -q -q \
 && apt-get install -q -y mysql-server-5.5 \
 && apt-get -q -y clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

WORKDIR /mysql
ENV MYSQL_HOME /mysql
VOLUME ["/var/lib/mysql"]

ADD my.cnf /mysql/
RUN chmod 664 /mysql/my.cnf
ADD run /mysql/run
RUN chmod +x /mysql/run

EXPOSE 3306
CMD ["/mysql/run"]
