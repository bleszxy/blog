**1、查看慢查询日志是否打开(默认不开启)**

```shell
 show variables like 'slow_query%';

+---------------------+------------------------------------------+

| Variable_name       | Value                                    |

+---------------------+------------------------------------------+

| slow_query_log      | OFF                                      |

| slow_query_log_file | /var/lib/mysql/common-mysql-0-0-slow.log |

+---------------------+------------------------------------------+

2 rows in set (0.01 sec)
```



**2、开启慢查询日志**

```shell
mysql> set global slow_query_log=1;
Query OK, 0 rows affected (0.00 sec)
```

//设置后重新连接才能生效



**3、查看定义的慢查询时间** 

```shell
show variables like 'long_query_time';

+-----------------+----------+

| Variable_name   | Value    |

+-----------------+----------+

| long_query_time | 1.000000 | .    代表1S

+-----------------+----------+

1 row in set (0.01 sec)
```



**4、设置慢查询时间**

```shell
set global long_query_time=0.2;
//设置后重新连接才能生效。
```



**5、explain查看执行计划**

```shell
 explain select                 id, task_id, request_id, `role`, `status`, info, debug, code_seq, create_time, update_time         from task_request_role_item                    WHERE (  request_id = 'ODI2MDQwOTE1NTQ5MjM3MjQ4'                                                                and debug = 0 );

+----+-------------+------------------------+------------+------+---------------+------+---------+------+--------+----------+-------------+

| id | select_type | table                  | partitions | type | possible_keys | key  | key_len | ref  | rows   | filtered | Extra       |

+----+-------------+------------------------+------------+------+---------------+------+---------+------+--------+----------+-------------+

|  1 | SIMPLE      | task_request_role_item | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 963855 |     1.00 | Using where |

+----+-------------+------------------------+------------+------+---------------+------+---------+------+--------+----------+-------------+

1 row in set, 1 warning (0.01 sec)
```

