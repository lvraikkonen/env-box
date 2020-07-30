## 编译安装Snappy

``` shell
yum -y install gcc gcc-c++ autoconf automake libtools
```



``` shell
tar -zxvf snappy-1.1.4.tar.gz -C /opt/modules
cd /opt/modules/snappy-1.1.4/
./configure
make & make install
```



```
# 查看snappy库文件

ls -lh /usr/local/lib |grep snappy
```



## 编译安装hadoop-lzo



``` shell
yum install -y svn ncurses-devel gcc gcc-c++ make cmake openssl openssl-devel svn ncurses-devel zlib-devel libtool lzo lzo-devel lzop autoconf automake cmake 
```

> hadoop-lzo的源码在GitHub上是开源的，源码地址：https://github.com/twitter/hadoop-lzo

mvn编译源码

```shell
tar -xzvf hadoop-lzo-release-0.4.20.tar.gz -C ../opt/modules/

#mvn编译，先把pom文件里边的hadoop版本修改一下，本地使用的是2.7.7
cd hadoop-lzo-release-0.4.20/
vim pom.xml
```
``` xml
<properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <hadoop.current.version>2.7.7</hadoop.current.version>
    <hadoop.old.version>1.0.4</hadoop.old.version>
</properties>
```

编译

``` shell
mvn clean package -Dmaven.test.skip=true
```

查看编译之后的jar包，hadoop-lzo-0.4.20.jar是我们需要使用的jar包

``` shell
cd target/
[hadoop@hadoop001 target]$ ll
total 428
drwxr-xr-x. 2 root root   4096 Jul 30 14:01 antrun
drwxr-xr-x. 4 root root   4096 Jul 30 14:01 apidocs
drwxr-xr-x. 5 root root     66 Jul 30 14:01 classes
drwxr-xr-x. 3 root root     25 Jul 30 14:01 generated-sources
-rw-r--r--. 1 root root 188733 Jul 30 14:01 hadoop-lzo-0.4.20.jar
-rw-r--r--. 1 root root 180240 Jul 30 14:01 hadoop-lzo-0.4.20-javadoc.jar
-rw-r--r--. 1 root root  51983 Jul 30 14:01 hadoop-lzo-0.4.20-sources.jar
drwxr-xr-x. 2 root root     71 Jul 30 14:01 javadoc-bundle-options
drwxr-xr-x. 2 root root     28 Jul 30 14:01 maven-archiver
drwxr-xr-x. 3 root root     28 Jul 30 14:01 native
drwxr-xr-x. 3 root root     18 Jul 30 14:01 test-classes
```

### 上传hadoop-lzo.jar

将hadoop-lzo-0.4.20-SNAPSHOT.jar 复制到hadoop的common目录，如果是集群，复制到每台机器上

```shell
[hadoop@hadoop001 target]$ cp hadoop-lzo-0.4.20.jar ~/app/hadoop/share/hadoop/common/
[hadoop@hadoop001 target]$ ll  ~/app/hadoop/share/hadoop/common/hadoop-lzo*
-rw-rw-r--. 1 hadoop hadoop 188645 Apr 16 11:11 /home/hadoop/app/hadoop/share/hadoop/common/hadoop-lzo-0.4.20.jar
```

### 配置core-site.xml

``` xml
<property>
    <name>io.compression.codecs</name>
    <value>org.apache.hadoop.io.compress.GzipCodec,
        org.apache.hadoop.io.compress.DefaultCodec,
        org.apache.hadoop.io.compress.BZip2Codec,
        org.apache.hadoop.io.compress.SnappyCodec,
        com.hadoop.compression.lzo.LzoCodec,
        com.hadoop.compression.lzo.LzopCodec
    </value>
</property>

<property>
    <name>io.compression.codec.lzo.class</name>
    <value>com.hadoop.compression.lzo.LzoCodec</value>
</property>
```

### 配置mapred-site.xml

``` xml
#中间阶段的压缩
<property>    
    <name>mapred.compress.map.output</name>    
    <value>true</value>    
</property>
<property>    
    <name>mapred.map.output.compression.codec</name>    
    <value>com.hadoop.compression.lzo.LzoCodec</value>    
</property>

#最终阶段的压缩
<property>
   <name>mapreduce.output.fileoutputformat.compress</name>
   <value>true</value>
</property>

<property>
   <name>mapreduce.output.fileoutputformat.compress.codec</name>
   <value>org.apache.hadoop.io.compress.BZip2Codec</value>
</property>	
```



## 编译安装protobuf



``` shell
yum -y install cmake zlib-devel ant libssl-dev openssl-devel lzo-devel
```



下载并解压protobuf：https://github.com/google/protobuf

``` shell
tar -zxvf protobuf-2.5.0.tar.gz -C /opt/modules
cd /opt/modules/protobuf-2.5.0/
./configure 
make & make install

# 查看protobuf版本以测试是否安装成功
protoc --version
```



## 编译Hadoop



1.修改maven的镜像设置(maven下的conf的`settings.xml`)，地址设置为阿里云镜像地址，这样编译项目下载依赖时会快很多

``` xml
<mirror>
    <id>nexus-aliyun</id>
    <mirrorOf>central</mirrorOf>
    <name>Nexus aliyun</name>
    <url>http://maven.aliyun.com/nexus/content/groups/public</url>
</mirror>
```



2.进入hadoop目录，

``` shell
mvn clean package -Pdist,native -DskipTests -Dtar -Dbundle.snappy -Dsnappy.lib=/usr/local/lib
```

 3.编译完成后，jar包在hadoop/hadoop-dist/target目录下，直接解压使用即可

 4.修改hadoop的`core-site.xml`

``` xml
<property>
    <name>io.compression.codecs</name>
    <value>org.apache.hadoop.io.compress.SnappyCodec</value>
</property>
```


 5.启动hadoop并验证，hadoop checknative -a