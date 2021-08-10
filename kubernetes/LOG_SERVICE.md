#### 通讯协议

websocket



#### 框架选择

使用websocketd cgi框架模式，接收STDIN作为参数，输出STDOUT作为响应。

支持几乎全语言，log-service多为文件处理，选择bash。暂时支持tail & cat模式,后期支持自定义操作。

详见：https://github.com/joewalnes/websocketd



#### 部署

Kubernetes DaemonSet模式

##### docker

引入ubuntu、websocketd。如下:

```
FROM ubuntu:18.04
MAINTAINER yanghao7 <yanghao7@tsingj.com>
ENV LANG C.UTF-8

RUN mkdir -p log-service/bin

COPY websocketd ./log-service
COPY /bin/wsmanager.sh ./log-service/bin
COPY /bin/start.sh ./log-service/bin

RUN chmod 755 /log-service/*

#expose ws ports
EXPOSE 8080

WORKDIR /log-service

CMD ["/log-service/bin/start.sh"]

```

构建和启动如下：

------

```shell
构建
docker build . -t log-service
启动
docker run --name log-service -p 8080:8080 --mount src=[日志目录],target=[日志目录，与src一致],type=bind -itd registry.tsingj.local/log-service
示例
docker run --name log-service -p 8080:8080 --mount src=/Users/yanghao/Downloads/NjgyMTk0MDU3Njc3NTA0NTEz,target=/Users/yanghao/Downloads/NjgyMTk0MDU3Njc3NTA0NTEz,type=bind -itd registry.tsingj.local/log-service
```

**nginx**

通过ws地址中的参数解析进行跳转，解决daemonset service无法访问指定pod的问题。配置文件如下：

```
map $http_upgrade $connection_upgrade {
    default upgrade;
    '' close;
}

server {
    listen 18080;
    server_name  localhost;
    location / {
       if ($query_string ~*  ^(.*)ip=(.*)$){
               set $r_ip $2;
       }
       proxy_pass http://$r_ip:8080/;
       proxy_set_header X-Real-IP $remote_addr;
       proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
       proxy_http_version 1.1;
       proxy_set_header Upgrade $http_upgrade;
       proxy_set_header Connection $connection_upgrade;
    }
}
```



#### client获取stdout方式

1. 根据taskId|requestId查询出stdout文件路径以及节点podIp。

2. 输入过滤条件(可空)

3. 选择模式 cat|tail (默认tail)

   3.1. cat stdout文件路径 或者 cat stdout文件路径 | grep 过滤条件

   3.2. tail -f stdout文件路径 或者 tail -f stdout文件路径 | grep 过滤条件

4. 建立ws连接(ws://[nginxIp]:[nginxPort]?ip=[podIp])，发送依据上述3部生成的消息。

PS:单命令执行模式，如果使用tail后想使用cat模式需要刷新页面重新选择，因为tail是无法断开的，只能断开ws。

**待做：**

1. 自定义命令（server已支持）

2. 日志下载 (server已支持，需要按照文档进行修改log-service)

#### client输入stdin方式

1. 根据taskId|requestId查询出stdin路径以及节点podIp。
2. 输入本次写入内容
3. 建立ws连接(ws://[nginxIp]:[nginxPort]?ip=[podIp])，发送消息（echo [写入内容] >> stdin文件路径）。