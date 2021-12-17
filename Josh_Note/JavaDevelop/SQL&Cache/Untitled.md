**1. mysql查询所有表:**

```mysql
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '数据库名' AND TABLE_TYPE ='BASE TABLE'
```

mysql查询建表语句: 

```mysql
show create table `表名`   
```

**2.mysql查询所有视图:**SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '数据库名' AND TABLE_TYPE ='VIEW'
mysql查询视图创建语句: show create view `视图名`   
**3.mysql查询所有函数:**SELECT name from mysql.proc where db= 'ifms' and type='function'
mysql查询函数定义语句: SHOW CREATE FUNCTION `函数名`  
**4.mysql查询所有存储过程:**SELECT name from mysql.proc where db= 'ifms' and type='procedure'
mysql查询procedure定义语句:SHOW CREATE procedure `存储过程名`**5.mysql查询所有触发器:**SELECT * FROM information_schema.`TRIGGERS`
mysql查询触发器定义语句: select * from information_schema.triggers where TRIGGER_NAME='触发器名';



:joy:

:phone:

:family:

```
去露营了！ :tent: 很快回来。

真好笑！ :joy:
```