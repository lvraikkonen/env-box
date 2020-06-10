FROM mysql:5.7.30

ENV MYSQL_ROOT_PASSWORD 123456

WORKDIR /root
RUN mkdir -p /home/mysql

COPY start.sh /mysql/start.sh
COPY my.cnf /etc/mysql/my.cnf  
COPY init.sql /mysql/init.sql

EXPOSE 3306
CMD ["sh", "/mysql/start.sh"]