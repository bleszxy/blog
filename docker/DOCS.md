**docker cp**

```
docker cp 目录/ tm-service:目录

目录以/结尾会将目录下的所有文件&目录cp至容器指定目录下，如果目录不存在会创建。

docker cp 目录 tm-service:目录

目录不以/结尾目录cp至容器指定文件夹下。
```



**添加代理**

```
1. 修改配置文件
vi /etc/docker/daemon.json
{
"registry-mirrors": ["https://uidzfqn8.mirror.aliyuncs.com"],
"insecure-registries": [
      "registry.tsingj.local",
      "10.18.0.19:5000"
  ]
}

2. 重启docker相关服务
sudo systemctl daemon-reload
sudo systemctl restart docker
```



**ubuntu开启docker tcp端口**

1. 修改docker文件

   sudo vi /lib/systemd/system/docker.service 

   如下图：

   ![image-20200415182003759](/Users/yanghao/docs/docker/images/image-20200415182003759.png)

2. 重启docker服务

   重载守护进程 sudo systemctl daemon-reload

   重启Docker sudo systemctl restart docker

3. 测试

   docker -H tcp://10.88.200.191 images