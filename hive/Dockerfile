FROM hadoop-docker:v1
#FROM lvraikkonen/hadoop:2.7.7

MAINTAINER lvraikkonen <claus.lv@hotmail.com>

USER root
WORKDIR /root

ENV HIVE_HOME=/usr/local/hive
ENV PATH=$PATH:$HIVE_HOME/bin:.

# 安装 Hive
COPY apache-hive-2.3.7-bin.tar.gz /root/apache-hive-2.3.7-bin.tar.gz

RUN tar -xzvf apache-hive-2.3.7-bin.tar.gz && \
    mv apache-hive-2.3.7-bin $HIVE_HOME && \
    rm -rf apache-hive-2.3.7-bin.tar.gz && \
    rm -rf $HIVE_HOME/examples && \
    wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.40.tar.gz && \
    tar -xzvf mysql-connector-java-5.1.40.tar.gz -C /root/ && \
    mv /root/mysql-connector-java-5.1.40/mysql-connector-java-5.1.40-bin.jar $HIVE_HOME/lib/ && \
    rm -rf /root/mysql-connector-java-5.1.40 && \
    rm -rf /root/mysql-connector-java-5.1.40.tar.gz
    
# 拷贝Hive配置文件
COPY config/* $HIVE_HOME/conf/

CMD ["/bin/bash"]