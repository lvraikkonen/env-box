FROM lvraikkonen/hive:2.3.7

MAINTAINER lvraikkonen <claus.lv@hotmail.com>

USER root

#设置环境变量
ENV SPARK_HOME=/root/spark
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin:.


COPY spark-2.4.5-bin-hadoop2.7.tgz /root/spark-2.4.5-bin-hadoop2.7.tgz

#安装spark 2.1.0
RUN tar -xzvf spark-2.4.5-bin-hadoop2.7.tgz -C /root/ && \
    mv /root/spark-2.4.5-bin-hadoop2.7 $SPARK_HOME && \
    rm -rf spark-2.4.5-bin-hadoop2.7.tgz

#拷贝Spark配置文件
COPY config/spark/* $SPARK_HOME/conf/

CMD [ "sh", "-c", "service sshd start; bash"]