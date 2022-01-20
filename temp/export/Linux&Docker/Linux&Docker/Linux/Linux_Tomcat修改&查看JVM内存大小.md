#### 1、修改Tomcat bin目录下catalina.bat 或者catalina.sh文件，修改内容如下

* ==Windows== 下`catalina.bat`**在 remGuessCATALINA_HOME if not definedset CURRENT_DIR=%cd%后面添加**
  * 例子一：`set JAVA_OPTS=-Dfile.encoding=UTF-8 -server -Xms1024m -Xmx2048m -XX:NewSize=512m -XX:MaxNewSize=1024m -XX:PermSize=256m -XX:MaxPermSize=512m -XX:MaxTenuringThreshold=10 -XX:NewRatio=2 -XX:+DisableExplicitGC`
  * 例子二： `set JAVA_OPTS=-Xms256m -Xmx512m -XX:PermSize=128M -XX:MaxNewSize=256m -XX:MaxPermSize=256m -Djava.awt.headless=true`

* ==Linux== 下`catalina.sh`在位置**cygwin=false前**
  * 例子一：`JAVA_OPTS="-Dfile.encoding=UTF-8 -server -Xms1024m -Xmx2048m -XX:NewSize=512m -XX:MaxNewSize=1024m -XX:PermSize=256m -XX:MaxPermSize=512m -XX:MaxTenuringThreshold=10 -XX:NewRatio=2 -XX:+DisableExplicitGC"`
  * 例子二：`JAVA_OPTS="-Xms256m -Xmx512m -Xss1024K -XX:PermSize=128m -XX:MaxPermSize=256m"`

#### 2、springboot 内置Tomcat启动时配置JDK和JVM内存大小

* ==启动jar包时附上（前者是jdk路径+内存配置）==：`/wageservices/jdk1.8.0_211/bin/java -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=128m -Xms1024m -Xmx2048m -Xmn256m -Xss256k -Duser.timezone=GMT+08 -jar`

示例：[![](assets/YX04f9f925-20220118003241-fzpl37c.png)](assets/wageservice-20220118003241-5gin5y6.sh)

配置参数说明：

#-Dfile.encoding:默认文件编码

#-Xms512m  设置JVM的最小内存为512m，此值可以设置与-Xmx相同以此避免每次垃圾回收完成后JVM重新分配内存。

#-Xmx1024  设置JVM的最大可用内存

#-XX:NewSize  设置年轻代大小

#-XX:MaxNewSize 设置年轻代最大内存大小

#-XX:PermSize  设置永久代大小

#-XX:MaxPermSize 设置永久代最大内存

#-XX:NewRatio=2 设置年轻代与老年代的比值 2 ：表示年轻代与老年代的比值是1:2

#-XX:MaxTenuringThreshold  这种垃圾的最大年龄，默认是15 。 0：表示年轻代不经过Survivor区直接进入老年代，对于老年代较多的应用，设置为0可以提高效率。如果该值较大表示年轻代的对象会在Survivor区进行多次复制，以此增加对象在年轻代的存活时间，增加在年轻代被回收的概率。

#XX:+DisableExplicitGC 应用程序将忽略收到调用GC的代码。及System.GC()是一个空调用。


### 二、Tomcat 自定义JDK方式

1、==windows==

* 找到bin下的setclasspath.bat和catalina.bat文件
  * `set JAVA_HOME=D:\Program Files\Java\jdk7\jdk1.7.0_51`
  * `set JRE_HOME=D:\Program Files\Java\jdk7\jre7`

==2.linux==

* 找到bin下的setclasspath.sh和catalina.sh文件
  * `export JAVA_HOME=/home/jdk/Java/jdk7/jdk1.7.0_51`
  * `export JRE_HOME=/home/jdk/Java/jdk7/jre7`

示例：![](assets/Image(174)-20220118003620-n1fdsic.png)![]()
