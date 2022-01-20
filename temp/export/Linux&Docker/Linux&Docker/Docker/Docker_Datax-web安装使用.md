#### 一、【Centos7下】docker-compose 安装datax-web[【参考博客】](https://www.e-learn.cn/topic/4044651)

* 创建文件compose.yml
  ```dockerfile
  version: "3.7"
  services:
    datax-web:
      expose:
        - "9504"
        - "9527"
        - "9999"
      restart: always
      image: eurekas/datax-web:standalone-1.1
      container_name: datax-web
      ports:
        - 9504:9504
        - 9527:9527
        - 9999:9999
      volumes:
        - /app/docker_home/datax-web_home/datax-web/datax:/usr/local/datax
      depends_on:
        - mysql
      links:
        - "mysql:mysql"
      environment:
        - JAVA_OPTS=-XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=256m -Xms1024m -Xmx2048m -Xmn256m -Xss256k
    mysql:
      image: eurekas/datax-web-mysql:1.0
      expose:
        - "3306"
      restart: always
      container_name: mysql
      ports:
        - 3306:3306
      environment:
        - "MYSQL_ROOT_PASSWORD=1q2w3e4r5"
      volumes:
        - /app/docker_home/datax-web_home/datax-mysql:/var/lib/mysql
  ```

* 执行docker-compose -f compose.yml up -d --build
* 注意：如果出现docker挂载提示：找不到文件或者文件夹-->1、先不挂载找到容器的路径、2、把容器的路径copy到宿主机3、重新执行挂载启动

#### 二、【本地】datax-web-ui 搭建

```dockerfile
1、运行
    npm install [ 慢的话用  npm install --registry https://registry.npm.taobao.org]
2、修改配置
找到 vue.config.js 修改 proxy 里的属性即可
[process.env.VUE_APP_API]: {    
    target: `http://localhost:${apiPort}/api`,    
    changeOrigin: true,    
    pathRewrite: {      
        ['^' + process.env.VUE_APP_API]: ''    
}
3、启动
    npm run dev
4、打包
    npm run build:prod
```

#### 三、DataX 【本地IDEA】Debug

![](assets/Image(148)-20220117173217-v6ukjgx.png)![]()
