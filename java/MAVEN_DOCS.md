[TOC]

### dependency:go-offline

http://maven.apache.org/plugins/maven-dependency-plugin/go-offline-mojo.html#excludeArtifactIds

`mvn dependency:go-offline`预下载所有依赖项至`{user.home}/.m2/repository`，可以确保在开始脱机工作之前在本地repository有所有依赖项。



### docker maven

优点

1.统一的构建环境

2.不再需要使用者编译打包时本机安装jdk(maven images中包含jdk)

缺点

如果jenkins中使用，并且jenkins已经是docker方式启动并且mount了磁盘，使用maven docker时进行mount操作可能存在mount时无法找到对应的宿主机目录的问题。



Dockerfile

```
FROM maven:3.6.3-jdk-8
MAINTAINER xuw@tsingj.com
ENV TZ "Asia/Shanghai"
ENV TERM xterm
ENV LANG C.UTF-8

#copy 本地的settings.xml复制docker maven默认的配置
COPY settings.xml /root/.m2/

CMD /bin/bash
```

构建

```
docker build . -t console-mvn-builder
docker tag console-mvn-builder registry.tsingj.local/console-mvn-builder
docker push registry.tsingj.local/console-mvn-builder
```

服务器运行

```
1.远程docker方式
docker run --name console-mvn-builder -itd registry.tsingj.local/console-mvn-builder
PS:一般需要开启docker tcp端口 才可以通过本机适用docker -H tcp://10.88.200.191:2375 cp xxx console-mv-builder:/xxx 命令将本机代码copy至远端docker进行maven构建。

2.docker run时mount本地磁盘方式
##使用mvn-builder进行构建,挂载$(dirname "$PWD")[当前目录的上级目录，即：项目根目录]->/root/console、$HOME/.m2/repository[当前用户默认的maven repository目录]->/root/.m2/repository,将本地的项目和maven repository共享至mvn-builder docker中.
#docker run --mount src=${CONSOLE_DIR},target=/root/console,type=bind --mount src=${MAVEN_REPO_DIR},target=/root/.m2/repository,type=bind  -w "/root/console/buildtools" console-mvn-builder $@
```

