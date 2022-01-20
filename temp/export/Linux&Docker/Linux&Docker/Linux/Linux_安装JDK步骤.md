## 1、检查一下系统中的jdk版本

```powershell
[root@localhost software]# java -version
显示：
openjdk version "1.8.0_102"`
OpenJDK Runtime Environment (build 1.8.0_102-b14)
OpenJDK 64-Bit Server VM (build 25.102-b14, mixed mode)
```

## 2、检测jdk安装包

```powershell
[root@localhost software]# rpm -qa | grep java
显示：
java-1.7.0-openjdk-1.7.0.111-2.6.7.8.el7.x86_64
python-javapackages-3.4.1-11.el7.noarch
tzdata-java-2016g-2.el7.noarch
javapackages-tools-3.4.1-11.el7.noarch
java-1.8.0-openjdk-1.8.0.102-4.b14.el7.x86_64
java-1.8.0-openjdk-headless-1.8.0.102-4.b14.el7.x86_64
java-1.7.0-openjdk-headless-1.7.0.111-2.6.7.8.el7.x86_64
```

## 3、卸载openjdk

```powershell
[root@localhost software]# rpm -e --nodeps tzdata-java-2016g-2.el7.noarch
[root@localhost software]# rpm -e --nodeps java-1.7.0-openjdk-1.7.0.111-2.6.7.8.el7.x86_64
[root@localhost software]# rpm -e --nodeps java-1.7.0-openjdk-headless-1.7.0.111-2.6.7.8.el7.x86_64
[root@localhost software]# rpm -e --nodeps java-1.8.0-openjdk-1.8.0.102-4.b14.el7.x86_64
[root@localhost software]# rpm -e --nodeps java-1.8.0-openjdk-headless-1.8.0.102-4.b14.el7.x86_64
或者使用
[root@localhost jvm]# yum remove *openjdk*
之后再次输入rpm -qa | grep java 查看卸载情况：
[root@localhost software]# rpm -qa | grep java
python-javapackages-3.4.1-11.el7.noarch
javapackages-tools-3.4.1-11.el7.noarch
```

## 4、安装新的jdk

```powershell
[root@localhost software]# ll
total 181192
-rw-r--r-- 1 root root 185540433 May 20 2017 jdk-8u131-linux-x64.tar.gz
解压 jdk-8u131-linux-x64.tar.gz安装包
[root@localhost software]# mkdir -p /opt/soft
[root@localhost software]# mv jdk-8u131-linux-x64.tar.gz /opt/soft
[root@localhost software]# tar -zxvf jdk-8u131-linux-x64.tar.gz
[root@localhost software]# ln -s jdk1.8.0_131 jdk（可以不要）
```

## 5、设置环境变量

```powershell
[root@localhost software]# vim /etc/profile
在最前面添加：
export JAVA_HOME=/opt/soft/jdk(版本)
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH
```

## 6、执行profile文件

`[root@localhost software]# source /etc/profile`

## 7、检查新安装的jdk

```powershell
[root@localhost software]# java -version
显示：
java version "1.8.0_131"
Java(TM) SE Runtime Environment (build 1.8.0_131-b11)
Java HotSpot(TM) 64-Bit Server VM (build 25.131-b11, mixed mode)
```
