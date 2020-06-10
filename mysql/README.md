## 准备文件



![](https://img2018.cnblogs.com/blog/1850167/201911/1850167-20191102065740626-50129277.png)

- data 目录用来保存数据文件的目录
- Dockerfile 保存Dockerfile内容
- init.sql 初始化数据库的SQL
- my.cnf 数据库配置文件，配置方式上面已提到
- start.sh Dockerfile构建MySQL时的脚本



## 构建`master`和`slave`镜像并运行容器

构建`master`镜像

```bash
docker build -t master/mysql .
```

构建`slave`镜像

```bash
docker build -t slave/mysql .
```

使用刚构建的镜像来运行容器

```bash
# master 容器
docker run --name master -p 3306:3306 -v d:/master-data:/var/lib/mysql -d master/mysql

# slave 容器
docker run --name slave -p 3307:3306 -v d:/slave-data:/var/lib/mysql -d slave/mysql
```

指定`master`端口为`3306`,`slave`端口为`3307`，挂载data目录为保存数据的目录。

## 验证

查看 `log-bin` 是否开启
![log-bin是否开启](https://img2018.cnblogs.com/blog/1850167/201911/1850167-20191102065741343-1119325374.png)



## 创建复制账号

在`master`数据库创建数据同步用户，授予用户 slave REPLICATION SLAVE权限和REPLICATION CLIENT权限，用于在主从库之间同步数据。

```sql
CREATE USER 'slave'@'%' IDENTIFIED BY '123456';
GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'slave'@'%';
flush privileges;
```



## 链接Master(主)和Slave(从)

在`master`进入mysql，执行`show master status;`



File和Position字段的值后面将会用到，在后面的操作完成之前，需要保证Master库不能做任何操作，否则将会引起状态变化，File和Position字段的值变化。

在`slave`中进入 mysql，执行

``` sql
change master to master_host='172.17.0.2', master_user='slave', master_password='123456', master_port=3306, master_log_file='mysql-bin.000003', master_log_pos=4050, master_connect_retry=30;
```



在`slave`中的mysql终端执行`show slave status \G;`用于查看主从同步状态。

正常情况下，SlaveIORunning 和 SlaveSQLRunning 都是No，因为我们还没有开启主从复制过程。使用`start slave`开启主从复制过程，然后再次查询主从同步状态`show slave status \G;`。



## 测试主从复制

测试主从复制方式就十分多了，最简单的是在Master创建一个数据库，然后检查Slave是否存在此数据库。

**Master:**

``` sql
CREATE database test;
```

**Slave**

``` sql
show databases;
```

