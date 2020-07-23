# **docker-compose-elasticsearch-kibana**

# **Overview**
Docker Compose for 3 Node Elasticsearch Cluster and Kibana Instance for development purposes.

- [x] 3 Node Elasticsearch version 
- [x] Kibana version 
- [x] Audit Beat version 
- [x] Metric Beat version 
- [x] Heart Beat version 
- [x] Packet Beat version 
- [x] File Beat version 
- [x] APM Server version 
- [x] APM Search 
- [x] NGINX

# **NOTES**
- If you need Open Source version then change Elasticsearch and Kibana Images to elasticsearch-oss and kibana-oss respectively.
- Kibana is being served behind Nginx Proxy so you can secure access of kibana for your purpose.


## **Requirements**
- [x] Docker 18.05
- [x] Docker-compose 1.21

### **Start Stack in Daemon Mode**
```
docker-compose up -d
```

### **Check status of docker-compose cluster**
```
docker-compose ps -a
```


### **Stop Compose Stack**
```
docker-compose down
```

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