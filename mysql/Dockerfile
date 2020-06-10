FROM mysql:5.7.30

MAINTAINER lvraikkonen <claus.lv@hotmail.com>

WORKDIR /root

RUN mkdir -p /home/mysql

ADD mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
 
RUN service mysql restart
EXPOSE 3306