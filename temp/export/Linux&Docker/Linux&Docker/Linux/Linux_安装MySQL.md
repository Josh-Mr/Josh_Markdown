[![](assets/YX04f2d69b-20220118002454-a2ufcav.png)](assets/Linux_yum安装MySQL-20220118002454-iteq8iw.docx)

安装mysql

tar -xvzf mysql-5.6.38-linux-glibc2.12-i686.tar.gz

mv mysql-5.6.38-linux-glibc2.12-i686/ mysql

* 添加系统mysql组和mysql用户：  
  执行命令：groupadd mysql和useradd -r -g mysql mysql
* 创建mysql数据目录，新目录不存在则创建

　　数据库数据默认目录datadir=/var/lib/mysql，可通过vim /etc/my.cnf 查看

　　![](assets/Image(168)-20220118002454-qqmk8f8.png)![]()

　　修改后的目录是 mkdir -p data，没有创建文件夹，有不创建

![](assets/Image(169)-20220118002454-i0soeri.png)![]()

* 修改目录权限

　　chown -R mysql:mysql  ./

![](assets/Image(170)-20220118002454-xumoxvl.png)![]()

* 初始化数据库

 　./scripts/mysql_install_db --user=mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data

* 修改权限为root

　　[root@localhost mysql]# chown -R root:root .

　　[root@localhost mysql]# chown -R mysql:mysql data

* 添加启动服务
* [root@localhost mysql]# cp support-files/mysql.server /etc/init.d/mysql
* [root@localhost mysql]# service mysql start

 ![](assets/Image(171)-20220118002454-woy7q4f.png)![]()

* 设置root用户密码
* ./bin/mysqladmin -u root password '123456'
* 遇到的问题

　　[root@localhost bin]# ./mysql

　　ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: NO)

* 解决方法
* [root@localhost bin]# ./mysqld_safe --user=mysql --skip-grant-tables --skip-networking &
* [root@localhost bin]# ./mysql -u root mysql
* mysql> UPDATE user SET Password=PASSWORD('123456') where USER='root';
* mysql> FLUSH PRIVILEGES;
* mysql> quit

![](assets/Image(172)-20220118002454-55jqzdq.png)![]()
