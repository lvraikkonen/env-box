FROM lvraikkonen/spark:2.4.6

MAINTAINER lvraikkonen <claus.lv@hotmail.com>

USER root

ENV HBASE_HOME=/root/hbase
ENV PATH=$PATH:.:$HBASE_HOME/bin


COPY hbase-2.2.5-bin.tar.gz /root/hbase-2.2.5-bin.tar.gz


# 1. 安装 HBase 2.2.5
RUN cd /root && \ 
    tar -zxvf hbase-2.2.5-bin.tar.gz -C /root/ && \
    mv /root/hbase-2.2.5 $HBASE_HOME && \
    rm -f hbase-2.2.5-bin.tar.gz && \
	rm -rf $HBASE_HOME/bin/*.cmd && \
	rm -rf $HBASE_HOME/docs && \
	rm -rf $HBASE_HOME/conf/*.cmd

COPY config/hbase/* $HBASE_HOME/conf/

# softlink hadoop conf folder to hbase
RUN ln -s /root/hadoop/etc/hadoop/core-site.xml /root/hbase/conf/core-site.xml
RUN ln -s /root/hadoop/etc/hadoop/hdfs-site.xml /root/hbase/conf/hdfs-site.xml

CMD [ "sh", "-c", "service sshd start; bash"]