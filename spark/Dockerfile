# 基础镜像，包括jdk
FROM openjdk:8u212-jdk-alpine3.9

#作者
LABEL maintainer "claus.lv@hotmail.com"

#用户
USER root

#编码
ENV LANG=C.UTF-8 \
    TZ=Asia/Shanghai

#下载到时候安装spark需要的工具
RUN apk add --no-cache --update-cache bash curl tzdata wget tar \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

#设置工作目录

WORKDIR /usr/local

#拷贝 当下载过慢时先下载到本地在拷贝
COPY spark-2.4.5-bin-hadoop2.7.tgz /usr/local 

#下载spark
RUN tar -zxvf spark-* \
    && mv spark-2.4.5-bin-hadoop2.7 spark \
    && rm -rf spark-2.4.5-bin-hadoop2.7.tgz


#设定spark的home
ENV SPARK_HOME=/usr/local/spark \
    JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk \
    PATH=${PATH}:${JAVA_HOME}/bin:${SPARK_HOME}/bin

#暴露端口，8080 6066 7077 4044 18080

EXPOSE 6066 8080 7077 4044 18080

#工作目录

WORKDIR $SPARK_HOME

CMD ["/bin/bash"]