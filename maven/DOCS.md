### dependency:go-offline

http://maven.apache.org/plugins/maven-dependency-plugin/go-offline-mojo.html#excludeArtifactIds

`mvn dependency:go-offline`预下载所有依赖项至`{user.home}/.m2/repository`，可以确保在开始脱机工作之前在本地repository有所有依赖项。



### docker maven

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
docker run --name console-mvn-builder -itd registry.tsingj.local/console-mvn-builder

PS:一般需要开启docker tcp端口 才可以通过本机适用docker -H tcp://10.88.200.191:2375 cp xxx console-mv-builder:/xxx 命令将本机代码copy至远端docker进行maven构建。
```

