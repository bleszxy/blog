**安装**

brew tap denji/nginx
brew install nginx-full --with-echo-module

**启动**

nginx路径/usr/local/Cellar/nginx-full/1.17.10

nginx

**重启**

nginx -s reload

**检查配置**

nginx -t

**配置详情**

nginx -V 

```
yanghaodeMacBook-Pro:nginx yanghao$ nginx -V
nginx version: nginx/1.17.10
built by clang 10.0.1 (clang-1001.0.46.4)
built with OpenSSL 1.1.1g  21 Apr 2020
TLS SNI support enabled
configure arguments: --prefix=/usr/local/Cellar/nginx-full/1.17.10 --with-http_ssl_module --with-pcre --with-ipv6 --sbin-path=/usr/local/Cellar/nginx-full/1.17.10/bin/nginx --with-cc-opt='-I/usr/local/include -I/usr/local/opt/pcre/include -I/usr/local/opt/openssl@1.1/include' --with-ld-opt='-L/usr/local/lib -L/usr/local/opt/pcre/lib -L/usr/local/opt/openssl@1.1/lib' --conf-path=/usr/local/etc/nginx/nginx.conf --pid-path=/usr/local/var/run/nginx.pid --lock-path=/usr/local/var/run/nginx.lock --http-client-body-temp-path=/usr/local/var/run/nginx/client_body_temp --http-proxy-temp-path=/usr/local/var/run/nginx/proxy_temp --http-fastcgi-temp-path=/usr/local/var/run/nginx/fastcgi_temp --http-uwsgi-temp-path=/usr/local/var/run/nginx/uwsgi_temp --http-scgi-temp-path=/usr/local/var/run/nginx/scgi_temp --http-log-path=/usr/local/var/log/nginx/access.log --error-log-path=/usr/local/var/log/nginx/error.log --add-module=/usr/local/share/echo-nginx-module
```

PS: nginx默认日志路径通过-V可以查看



**多配置文件模式**

配置路径/usr/local/etc/nginx

```
cd /usr/local/etc/nginx

主配置文件，最后的include加载了所有的其他配置

cat nginx.conf
#user  nobody;
worker_processes  1;
#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;
#pid        logs/nginx.pid;
events {
    worker_connections  1024;
}
http {
	log_format main '$remote_addr - $remote_user [$time_local]'
                     'fwf[$http_x_forwarded_for] tip[$http_true_client_ip]'
                     '$upstream_addr $upstream_response_time $request_time'
                     '$http_host $request'
                     '$status $body_bytes_sent $http_referer'
                     '$http_accept_language $http_user_agent $query_string';
    include servers/*.conf;
}

其他配置文件
yanghaodeMacBook-Pro:nginx yanghao$ cd servers
yanghaodeMacBook-Pro:servers yanghao$ ls
log_ws.conf	nginx_grpc.conf
yanghaodeMacBook-Pro:servers yanghao$ cat log_ws.conf
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
    location = /console-log.html {
        root   /usr/local/etc/nginx/html/;
    }
}
```





