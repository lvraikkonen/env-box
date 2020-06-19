FROM lvraikkonen/hadoop:2.7.7

MAINTAINER lvraikkonen <claus.lv@hotmail.com>

USER root

ENV HIVE_HOME=/root/hive

ENV PATH=$PATH:$HIVE_HOME/bin:.

RUN yum install -y wget && \
    yum clean all

COPY apache-hive-2.3.7-bin.tar.gz /root/apache-hive-2.3.7-bin.tar.gz

# 安装 Hive
RUN tar -xzvf apache-hive-2.3.7-bin.tar.gz -C /root/ && \
    mv /root/apache-hive-2.3.7-bin $HIVE_HOME && \
    rm -rf apache-hive-2.3.7-bin.tar.gz && \
    wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.40.tar.gz && \
    tar -xzvf mysql-connector-java-5.1.40.tar.gz -C /root/ && \
    mv /root/mysql-connector-java-5.1.40/mysql-connector-java-5.1.40-bin.jar $HIVE_HOME/lib/ && \
    rm -rf /root/mysql-connector-java-5.1.40 && \
    rm -rf /root/mysql-connector-java-5.1.40.tar.gz
    
# 拷贝Hive配置文件
COPY config/* $HIVE_HOME/conf/

CMD ["/bin/bash"]