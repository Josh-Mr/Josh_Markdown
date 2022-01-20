**--------------------------------权证项目--------------------------------**

#### 一、安装elasticsearch

1. 拉取 elasticsearch镜像
    `docker pull elasticsearch:7.5.1`

2. 启动elasticsearch
    ```dockerfile
    docker run -d --name=elasticsearch 
    -p 9200:9200 -p 9300:9300 
    -e "discovery.type=single-node" elasticsearch:7.5.1
    ```

3. 创建持久化目录，并重启elasticsearch
    ```dockerfile
    docker cp elasticsearch:/usr/share/elasticsearch/data /app/docker_home/elasticsearch_home/
    docker cp elasticsearch:/usr/share/elasticsearch/config /app/docker_home/elasticsearch_home/
    ```

```dockerfile
docker rm -f elasticsearch

docker run -d \
--name=elasticsearch \
--restart=always \
-p 9200:9200 \
-p 9300:9300 \
-e "discovery.type=single-node" \
-v /app/docker_home/elasticsearch_home/data:/usr/share/elasticsearch/data \
-v /app/docker_home/elasticsearch_home/config:/usr/share/elasticsearch/config \
elasticsearch:7.5.1
```

#### 二、安装skywalking-oap

1. 拉取skywalking-ui镜像

`docker pull apache/skywalking-ui:8.3.0`

2. 启动skywalking-ui
    ```dockerfile
    docker run -d \
    --name skywalking-ui \
    --restart=always \
    -e TZ=Asia/Shanghai \
    -p 10004:8080 \
    --link skywalking-oap-server:skywalking-oap-server \
    -e SW_OAP_ADDRESS=skywalking-oap-server:12800 \
    apache/skywalking-ui:8.3.0
     
    skywalking-ui访问地址：http://192.168.234.114:10004/
    ```
