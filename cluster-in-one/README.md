## build镜像



创建了用于build镜像的docker-compose文件

``` shell
docker-compose build
```

验证镜像创建成功





## 启动含有Hive的Hadoop集群



在images文件夹中创建了docker-compose文件用于启动集群

``` shell
docker-compose up -d
docker-compose ps
```



配置hive metadata为MySQL

``` xml
<configuration>
    <property>
        <name>javax.jdo.option.ConnectionURL</name>
        <value>jdbc:mysql://localhost:3306/hive?createDatabaseIfNotExist=true</value>
        <description>JDBC connect string for a JDBC metastore.sql.jdbc.Driver To use SSL to encrypt/authenticate the connection, provide database-specific SSL flag in the connection URL. For example, jdbc:postgresql://myhost/db?ssl=true for postgres database.
        </description>
    </property>

    <property>
        <name>javax.jdo.option.ConnectionDriverName</name>
        <value>com.mysql.jdbc.Driver</value>
        <description>Driver class name for a JDBC metastore</description>
    </property>

    <property>
        <name>javax.jdo.option.ConnectionUserName</name>
        <value>root</value>
        <description>Username to use against metastore database</description>
    </property>

    <property>
        <name>javax.jdo.option.ConnectionPassword</name>
        <value>123456</value>
        <description>password to use against metastore database</description>
    </property>

</configuration>
```

根据启动的MySQL地址修改配置文件



## 验证Hadoop集群



首先启动hadoop集群

``` shell
./start-hadoop.sh
```

[Overview](localhost:5070)

[Application](localhost:8088)



### 运行wordcount程序

``` shell
./run-wordcount.sh
```





## 验证Hive

先创建一个数据文件放到`/usr/local`下,

```
cd /usr/local
vim test.txt
```

```
1,jack
2,hel
3,nack
```

之后通过`hive`命令进入hive交互界面，然后执行相关操作

```shell
# 建表
create table test(
    id      int
   ,name    string
)
row format delimited
fields terminated by ',';

# 导入数据
load data local inpath '/usr/local/test.txt' into table test;

# 查询刚才导入的数据  
select * from test;

# 查询结果:
OK
1       jack
2       hel
3       nack
```

