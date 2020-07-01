FROM lvraikkonen/hadoop:2.7.7

MAINTAINER lvraikkonen <claus.lv@hotmail.com>

USER root

#设置环境变量
ENV SPARK_HOME=/root/spark
ENV SCALA_HOME=/usr/local/scala/scala-2.12.11

ADD scala-2.12.11.tgz /usr/local/scala/

ENV JRE_HOME=${JAVA_HOME}/jre
ENV CLASSPATH .:${JAVA_HOME}/lib:${JRE_HOME}/lib
ENV PATH=$PATH:${JAVA_HOME}/bin:$SCALA_HOME/bin:$SPARK_HOME/bin:$SPARK_HOME/sbin

ENV SPARK_VERSION 2.4.6
ENV HADOOP_VERSION 2.7
ENV PYTHON_VERSION 3.7.6
ENV SPARK_MASTER_LOG $SPARK_HOME/logs


# #下载spark,解压，删除压缩包，移动到/opt/spark
# RUN cd /root && \ 
#     wget https://mirrors.aliyun.com/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
#     tar -zxvf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /root/ && \
#     mv /root/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} $SPARK_HOME && \
#     rm -f spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
# 	mkdir -p ${SPARK_MASTER_LOG} 

COPY spark-2.4.6-bin-hadoop2.7.tgz /root/spark-2.4.6-bin-hadoop2.7.tgz

RUN cd /root && \ 
    tar -zxvf spark-2.4.6-bin-hadoop2.7.tgz -C /root/ && \
    mv /root/spark-2.4.6-bin-hadoop2.7 $SPARK_HOME && \
    rm -f spark-2.4.6-bin-hadoop2.7.tgz && \
	mkdir -p ${SPARK_MASTER_LOG} 

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080

ENV SPARK_WORKER_WEBUI_PORT 8081
ENV SPARK_WORKER_LOG $SPARK_HOME/logs
ENV SPARK_MASTER "spark://spark-master:7077"

# #修改python -> python3
# #RUN rm -f /usr/bin/python
# #RUN ln -s /usr/local/lib/python-${PYTHON_VERSION}/bin/python3 /usr/bin/python

# ENV PYSPARK_PYTHON /usr/bin/python3
# ENV PYSPARK_DRIVER_PYTHON /usr/bin/python3

# # Configure container
# COPY start-master.sh /
# COPY start-worker.sh /
COPY config/spark/* $SPARK_HOME/conf/

CMD [ "sh", "-c", "service sshd start; bash"]