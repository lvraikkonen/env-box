FROM centos:centos7
#RUN yum install java-1.8.0-openjdk -y

# install jdk8
RUN mkdir -p /usr/local/java
ADD jdk-8u251-linux-x64.tar.gz /usr/local/java/
# make a symbol link
RUN ln -s /usr/local/java/jdk1.8.0_251 /usr/local/java/jdk
# set environment variables
ENV JAVA_HOME /usr/local/java/jdk
ENV JRE_HOME ${JAVA_HOME}/jre
ENV CLASSPATH .:${JAVA_HOME}/lib:${JRE_HOME}/lib
ENV PATH ${JAVA_HOME}/bin:$PATH

# ADD jre-8u231-linux-x64.tar.gz /usr/java/jdk
# ENV JAVA_HOME /usr/java/jdk/jre1.8.0_231
# ENV PATH ${PATH}:${JAVA_HOME}/bin
ARG FLINK_VERSION=1.10.1
ARG SCALA_VERSION=2.12
ARG FLINK_TAR_NAME=flink-${FLINK_VERSION}-bin-scala_${SCALA_VERSION}.tgz
ENV FLINK_HOME=/flink-${FLINK_VERSION}
ADD ${FLINK_TAR_NAME} /
#RUN mkdir /home
COPY flink_run.sh /home
EXPOSE 8088
VOLUME $FLINK_HOME/conf
RUN chmod u+x /home/flink_run.sh
#ENTRYPOINT cd /home && sh /home/flink_run.sh
 
ENTRYPOINT ["/home/flink_run.sh"]