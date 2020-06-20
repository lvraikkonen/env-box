FROM lvraikkonen/os-jvm:centos7-openjdk8

MAINTAINER lvraikkonen <claus.lv@hotmail.com>

USER root
WORKDIR /root

ENV HADOOP_HOME=/root/hadoop
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HADOOP_HOME/lib/native/:/root/protobuf/lib
ENV PATH=$PATH:/root/protobuf/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:.

# 1. 安装 OpenSSH, OpenSSL, bzip2-devel
# 2. 同时配置SSH免密钥登陆
RUN yum install -y openssh openssh-server openssh-clients openssl openssl-devel bzip2-devel && \
    yum clean all && \
    ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
    
ADD config/other/ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config && \
    chown root:root /root/.ssh/config

COPY hadoop-2.7.7.tar.gz /root/hadoop-2.7.7.tar.gz

#安装Protocol Buffer, Hadoop
RUN tar -xzvf hadoop-2.7.7.tar.gz -C /root/ && \
    mv /root/hadoop-2.7.7 $HADOOP_HOME && \
    rm -rf hadoop-2.7.7.tar.gz

#拷贝环境变量配置文件
ADD config/other/bashrc /root/.bashrc

#拷贝Hadoop配置文件
ADD config/hadoop/* $HADOOP_HOME/etc/hadoop/


ADD config/scripts/start-hadoop.sh /root/start-hadoop.sh
ADD config/scripts/run-wordcount.sh /root/run-wordcount.sh

RUN chmod +x /root/start-hadoop.sh && \
    chmod +x /root/run-wordcount.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh 

RUN dos2unix /root/start-hadoop.sh && \
    dos2unix /root/run-wordcount.sh

# format namenode
RUN ${HADOOP_HOME}/bin/hdfs namenode -format

CMD [ "sh", "-c", "service sshd start; bash"]