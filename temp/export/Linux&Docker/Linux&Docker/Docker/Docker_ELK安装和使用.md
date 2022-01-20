一、关于ELK介绍

* Elasticsearch：开源分布式搜索引擎，它的特点有：分布式，零配置，自动发现，索引自动分片，索引副本机制，restful 风格接口，多数据源，自动搜索负载等。
* Logstash： 一个完全开源的工具，他可以对你的日志进行收集、过滤，并将其存储供以后使用（如，搜索）。
* Kibana： 一个开源和免费的工具，它可以为 Logstash 和 ElasticSearch 提供的日志分析友好的 Web 界面，可以帮助您汇总、分析和搜索重要数据日志。

![](assets/Image(149)-20220117174603-ifjfa4b.png)![]()

二、ELK在Docker下安装**[【参考博客】](https://bingozb.github.io/views/default/68.html#elk-%E4%BB%8B%E7%BB%8D)**

* 先安装docker 和docker compose

1、拉取镜像

```bash
$ docker pull docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.4
$ docker pull docker.elastic.co/logstash/logstash-oss:6.2.4
$ docker pull docker.elastic.co/kibana/kibana-oss:6.2.4
```

2、安装Elasticsearch

* 先创建一个配置文件 elasticsearch.yml，添加以下内容
  ```bash
  ---
  network.host: 0.0.0.0
  
  # minimum_master_nodes need to be explicitly set when bound on a public IP
  # set to 1 to allow single node clusters
  # Details: https://github.com/elastic/elasticsearch/pull/17288
  discovery.zen.minimum_master_nodes: 1
  
  ## Use single node discovery in order to disable production mode and avoid bootstrap checks
  ## see https://www.elastic.co/guide/en/elasticsearch/reference/current/bootstrap-checks.html
  #
  discovery.type: single-node
  
  # add elasticsearch-head cors support.
  http.cors.enabled: true
  http.cors.allow-origin: "*"
  ```

---

* Dockerfile：在 elasticsearch.yml 同个文件夹目录下，创建一个 Dockerfile 文件，添加以下内容
  ```bash
  FROM docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.4
  COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
  ```

* 构建
  ```bash
  $ docker build -t elasticsearch .
  ```

3、安装Logstash

* logstash.yml:创建一个配置文件 logstash.yml，添加以下内容

```bash
http.host: "0.0.0.0"
path.config: /usr/share/logstash/pipeline
```

* logstash.conf:再创建一个配置文件 logstash.conf，添加以下内容

```bash
input {
    tcp {
        port => 5000
        codec => json
    }
    udp {
        port => 5000
        codec => json
    }
}
output {
    elasticsearch {
        hosts => "192.168.0.115:9200"
        index => "springboot-logstash-%{+YYYY.MM.dd}"
    }
}
```

* DockerFile

```bash
FROM docker.elastic.co/logstash/logstash-oss:6.2.4
COPY logstash.yml /usr/share/logstash/config/logstash.yml
COPY logstash.conf /usr/share/logstash/pipeline/logstash.conf
EXPOSE 5000
```

* 构建

```bash
$ docker build -t logstash .
```

4、安装Kibana

* 创建kibana.yml文件

```bash
server.name: kibana
server.host: "0"
elasticsearch.url: http://elasticsearch:9200
```

* DockerFile

```bash
FROM docker.elastic.co/kibana/kibana-oss:6.2.4
COPY kibana.yml /usr/share/kibana/config/kibana.yml
```

* 构建

```bash
$ docker build -t kibana .
```

5、查看安装的elk

```bash
$ docker images
REPOSITORY        TAG         IMAGE ID         CREATED             SIZE
elasticsearch     latest      be6f4f0f0b5c     48 minutes ago      424MB
logstash          latest      8708312ccbfc     50 minutes ago      657MB
kibana            latest      b08d2aa33797     About an hour ago   527MB
```

6、Docker compose 运行ELK容器

* 创建一个 docker-compose.yml 文件，添加以下内容：

```dockerfile
version: "2"
services:
  elasticsearch:
    restart: always
    image: elasticsearch
    container_name: elasticsearch
    volumes:
      - ./data/elasticsearch:/usr/share/elasticsearch/data
    ports:
      - "9200:9200"


  logstash:
    restart: always
    image: logstash
    container_name: logstash
    ports:
      - "5000:5000"
    depends_on:
      - elasticsearch
    links:
      - elasticsearch:elasticsearch


  kibana:
    restart: always
    image: kibana
    container_name: kibana
    ports:
      - "5601:5601"
    depends_on:
      - elasticsearch
    links:
      - elasticsearch:elasticsearch
```

* 然后用docker-compse up -d 启动服务：
* 查看运行容器

```dockerfile
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                                        NAMES
7b4a9825a061        kibana              "/bin/bash /usr/loca…"   About an hour ago   Up About an hour    0.0.0.0:5601->5601/tcp                       kibana
82e6de4822d4        logstash            "/usr/local/bin/dock…"   About an hour ago   Up About an hour    5044/tcp, 0.0.0.0:5000->5000/tcp, 9600/tcp   logstash
0aba77e5d6f5        elasticsearch       "/usr/local/bin/dock…"   About an hour ago   Up About an hour    0.0.0.0:9200->9200/tcp, 9300/tcp             elasticsearch
```

```dockerfile
docker-compose 命令：
1、docker-compose up -d：后台启用
2、docker-compose up : 前台启用
3、docker-compose stop 停用
```

查看是否正常：

```dockerfile
1、kibana：http://192.168.0.115:5601/
2、Elasticsearch：http://192.168.0.115:9200/
```

三、Springboot 集成elk[【ELK代码案例.rar】](assets/elk-20220117175023-7byew09.rar)

* 配置日志文件logback-spring.xml

```dockerfile
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <include resource="org/springframework/boot/logging/logback/base.xml" />
    <appender name="logstash" class="net.logstash.logback.appender.LogstashTcpSocketAppender">
        <destination>192.168.0.115:5000</destination>
        <!-- 日志输出编码 -->
        <encoder charset="UTF-8"
                 class="net.logstash.logback.encoder.LoggingEventCompositeJsonEncoder">
            <providers>
                <timestamp>
                    <timeZone>UTC</timeZone>
                </timestamp>
                <pattern>
                    <pattern>
                        {
                        "logLevel": "%level",
                        "serviceName": "${springAppName:-}",
                        "pid": "${PID:-}",
                        "thread": "%thread",
                        "class": "%logger{40}",
                        "rest": "%message"
                        }
                    </pattern>
                </pattern>
            </providers>
        </encoder>
    </appender>
    <root level="info">
        <appender-ref ref="logstash" />
        <appender-ref ref="CONSOLE" />
    </root>
</configuration>
```

* pom.xml文件

```dockerfile
<dependency>
    <groupId>net.logstash.logback</groupId>
    <artifactId>logstash-logback-encoder</artifactId>
    <version>5.3</version>
</dependency>
```

* springboot启动类添加日志

```dockerfile
@SpringBootApplication
@RestController
public class SpringbootElkNewApplication {
    Logger logger = LoggerFactory.getLogger(SpringbootElkNewApplication.class);
    @GetMapping("test")
    public String test(){
        logger.error("测试初始一些日志吧！");
        logger.error("josh");
        return "test";
    }
    public static void main(String[] args) {
        SpringApplication.run(SpringbootElkNewApplication.class, args);
    }
}
```

![](assets/Image(150)-20220117175156-niq9fpu.png)![]()

* 配置management页面显示日志信息
