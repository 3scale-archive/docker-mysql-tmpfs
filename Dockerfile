FROM ubuntu:trusty

MAINTAINER Michal Cichra <michal@3scale.net> # 2014-06-12

ENV MYSQL_DB="/var/lib/mysql/" MYSQL_HOME="/mysql"

RUN apt-get update -q \
 && apt-get install -q -y mysql-server-5.6 \
 && apt-get -q -y clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* \
 && rm -rf $MYSQL_DB

WORKDIR $MYSQL_HOME
VOLUME ["$MYSQL_DB"]

ADD my.cnf $MYSQL_HOME/
ADD run $MYSQL_HOME/run
RUN rm -rf /etc/mysql && ln -sf $MYSQL_HOME /etc/mysql

EXPOSE 3306
CMD ["/mysql/run"]
