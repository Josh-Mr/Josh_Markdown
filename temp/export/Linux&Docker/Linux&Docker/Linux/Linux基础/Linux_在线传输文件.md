1. Linux之前传输文件
    ```bash
    scp /data/jdk-8u241-linux-x64.tar.gz root@192.168.234.28:/root
    ```

许多人使用简易的SSH连接工具，有时候需要在SSH下复制文件到本地查看比较方便，我给大家介绍一个简单的命令SCP。[@more@]scp是有Security的文件copy，基于ssh登录。操作起来比较方便，比如要把当前一个文件copy到远程另外一台主机上，可以如下命令。

![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)` scp  / home / daisy / full . tar . gz root@ 172.19 . 2.75 : / home / root`

然后会提示你输入另外那台172.19.2.75主机的root用户的登录密码，接着就开始copy了。

如果想反过来操作，把文件从远程主机copy到当前系统，也很简单。

![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)` scp root@ 172.19 . 2.75 : / home / root  / home / daisy /* . tar . gz`
