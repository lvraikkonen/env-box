# Image Source
FROM ubuntu

MAINTAINER lvraikkonen <claus.lv@hotmail.com>

WORKDIR /root


# install openssh-server, vim and wget
RUN apt-get update && apt-get install -y openssh-server vim wget

# install jdk8
RUN mkdir -p /usr/local/java
# COPY jdk-8u251-linux-x64.tar.gz /root/jdk-8u251-linux-x64.tar.gz
# RUN tar -zxvf jdk-8u251-linux-x64.tar.gz -C /usr/local/java/ && \
#     rm jdk-8u251-linux-x64.tar.gz 
ADD jdk-8u251-linux-x64.tar.gz /usr/local/java/
# make a symbol link
RUN ln -s /usr/local/java/jdk1.8.0_251 /usr/local/java/jdk
# set environment variables
ENV JAVA_HOME /usr/local/java/jdk
ENV JRE_HOME ${JAVA_HOME}/jre
ENV CLASSPATH .:${JAVA_HOME}/lib:${JRE_HOME}/lib
ENV PATH ${JAVA_HOME}/bin:$PATH

# install hadoop 2.7.7
ENV HADOOP_VERSION=2.7.7
COPY hadoop-$HADOOP_VERSION.tar.gz /root/hadoop-$HADOOP_VERSION.tar.gz
# install hadoop
RUN tar -xzvf hadoop-$HADOOP_VERSION.tar.gz && \
    mv hadoop-$HADOOP_VERSION /usr/local/hadoop && \
    rm hadoop-$HADOOP_VERSION.tar.gz

# set environment variable
ENV HADOOP_HOME=/usr/local/hadoop 
ENV PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin 

RUN echo ${JAVA_HOME}

# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

RUN mkdir -p ~/hdfs/namenode && \ 
    mkdir -p ~/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs

COPY config/* /tmp/

RUN mv /tmp/ssh_config ~/.ssh/config && \
    mv /tmp/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \ 
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves && \
    mv /tmp/start-hadoop.sh ~/start-hadoop.sh && \
    mv /tmp/run-wordcount.sh ~/run-wordcount.sh

RUN chmod +x ~/start-hadoop.sh && \
    chmod +x ~/run-wordcount.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh 

# format namenode
RUN ${HADOOP_HOME}/bin/hdfs namenode -format

CMD [ "sh", "-c", "service ssh start; bash"]
