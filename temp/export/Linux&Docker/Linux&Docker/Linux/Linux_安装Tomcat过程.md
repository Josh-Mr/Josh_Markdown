1. ==下载tomcat*.tar.gz解压后==

2. ==看当前iptables(防火墙)规则==

`#iptables -L -n（查看防火墙关闭的端口）`

![](assets/Image(173)-20220118003359-4ox8v7d.png)![]()

添加指定端口到防火墙中

`iptables -I INPUT -p 协议 --dport 端口号 -j ACCEPT`

```powershell
例如
#iptables -I INPUT -p udp --dport 161 -j ACCEPT
#iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
```

3. ==vim /etc/sysconfig/iptables 添加端口也可以==

4. ==查看、停止、重启防火墙 ( /etc/sysconfig/iptables )==

* # service iptables status #查看iptables状态
* # service iptables restart #iptables服务重启
* # service iptables stop #iptables服务禁用
