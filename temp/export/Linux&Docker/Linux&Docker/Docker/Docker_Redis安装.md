1. 获取redis镜像
    ```dockerfile
    docker pull redis
    ```

2. 查看本地镜像
    ```dockerfile
    docker images
    ```

3. 先在服务器创建挂载的目录和配置文件
    ```bash
    mkdir -p /mydata/redis/conf
    [root@iZwz9hw4qywrrl4vj6o0j1Z ~]# cd /mydata/redis/conf/
    [root@iZwz9hw4qywrrl4vj6o0j1Z conf]# touch redis.conf
    ```

4. 启动redis
    ```bash
    docker run -p 6379:6379 --name redis -v /mydata/redis/redis.conf:/etc/redis/redis.conf -v /mydata/redis/data:/data -d redis redis-server /etc/redis/redis.conf --appendonly yes

    # 结果
    [root@iZwz9hw4qywrrl4vj6o0j1Z conf]# docker run -p 6379:6379 --name redis -v /mydata/redis/redis.conf:/etc/redis/redis.conf -v /mydata/redis/data:/data -d redis redis-server /etc/redis/redis.conf --appendonly yes
    004edb8a18e1f3f53702ef423834129cb060450046fc8452a833da244fa0a42b
    ```

* 命令解释
  * -p 6379:6379 端口映射：前表示主机部分，：后表示容器部分。
  * --name myredis 指定该容器名称，查看和进行操作都比较方便。
  * -v 挂载目录，规则与端口映射相同。
  * -d redis 表示后台启动redis
  * redis-server /etc/redis/redis.conf 以配置文件启动redis，加载容器内的conf文件，最终找到的是挂载的目录/usr/local/docker/redis.conf
  * appendonly yes 开启redis 持久化

5. 进入Redis
    ```bash
    [root@iZwz9hw4qywrrl4vj6o0j1Z conf]# docker exec -it redis redis-cli
    127.0.0.1:6379>
    ```
