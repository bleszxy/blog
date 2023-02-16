[TOC]



#### 创建用户并赋予权限

```shell
//创建用户 密码为123456
create user 'yanghao'@'%' identified by '123456';

//赋予所有权限
grant all privileges on *.* to 'yanghao';

//刷新
flush privileges;
```



#### 用户连接数查看

```shell
//查看全部用户连接
show processlist;

//查看指定用户连接
select * from information_schema.PROCESSLIST where USER = 'yanghao';
```

