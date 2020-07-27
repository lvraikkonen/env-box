# **Overview**
Docker Compose for 3 Node Elasticsearch Cluster and Kibana Instance for development purposes.

- [x] 3 Node Elasticsearch version 
- [x] Kibana version 
- [ ] Audit Beat version 
- [ ] Metric Beat version 
- [ ] Heart Beat version 
- [ ] Packet Beat version 
- [ ] File Beat version 
- [ ] APM Server version 
- [ ] APM Search 
- [ ] NGINX

# **NOTES**
- If you need Open Source version then change Elasticsearch and Kibana Images to elasticsearch-oss and kibana-oss respectively.
- Kibana is being served behind Nginx Proxy so you can secure access of kibana for your purpose.


## **Requirements**
- [x] Docker 18.05
- [x] Docker-compose 1.21

### 启动集群
```
docker-compose up -d
```

### 检查集群状态
```
docker-compose ps -a
```


### 关停集群
```
docker-compose down
```

### 设置用户认证

集群默认使用如下内置的用户 **privileged** bootstrap user:

* user: *elastic*
* password: *changeme*

在启动集群后，为了安全性，启用内置的用户并重置密码

#### 1. 初始化内置用户的密码

```console
$ docker-compose exec -T elasticsearch bin/elasticsearch-setup-passwords auto --batch
```

6个内置账户将会启用，记录下他们的密码

#### 2. Unset the bootstrap password (_optional_)

删除`docker-compose`文件中的  `ELASTIC_PASSWORD`环境变量。 It is only used to initialize the keystore during the initial startup of Elasticsearch.

#### 3. 在kibana和logstash的配置文件中替换用户名和密码

- Use the `kibana_system` user (`kibana` for releases <7.8.0) inside the Kibana configuration file(`kibana/config/kibana.yml`)  
- Use the `logstash_system` user inside the Logstash configuration file (`logstash/config/logstash.yml`) in place of the existing `elastic` user.
- Replace the password for the `elastic` user inside the Logstash pipeline file (`logstash/pipeline/logstash.conf`).

> Do NOT USE the `logstash_system` user inside the Logstash *pipeline* file, it does not have
> sufficient permissions to create indices. Follow the instructions at [Configuring Security in Logstash][ls-security]
> to create a user with suitable roles.

See also the [Configuration](#configuration) section below.

#### 4. 重启Kibana和Logstash

```console
$ docker-compose restart kibana logstash
```

参考： [使用Docker-Compose 启动多结点集群](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)

### **Cluster Node Info**
```
curl http://localhost:9200/_nodes?pretty=true
```

### **Access Kibana**
```
http://localhost:5601
```

## **Validate Kibana is running**
![](images/kibana.png)

### **Accessing Kibana through Nginx**
```
http://localhost:8080
```

### **Access Elasticsearch**
```
http://localhost:9200
```
## **Validate Elasticsearch is running**
![](images/elasticsearch.png)