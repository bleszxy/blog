**现况**

目前DS作为客户端采用微消息队列MQTT版，TM作为服务端使用消息队列RocketMQ版。

微消息队列 MQTT 版在设计上是一个面向移动互联网和 IoT 领域的无状态网关，只关心海量客户端设备的接入、管理和消息传输，消息数据的存储则都会路由给RocketMQ。如下图：

![image-20200701181329583](/Users/yanghao/docs/all_images/image-20200701181329583.png)



**本地DS通知系统接入背景**

同时支持ali的收费通知组件，又支持本地测试或小规模使用场景的自搭建的通知系统。新架构如下：

![image-20200706141948271](/Users/yanghao/docs/all_images/image-20200706141948271.png)





**mqtt broker选型**

首先查阅了mqtt协议支持的broker，详见https://github.com/mqtt/mqtt.github.io/wiki/servers，大概分为两类mq plugin支持mqtt协议，轻量级的mqtt broker（客户端连接与消息路由）。

1、mq通过plugin支持mqtt协议（笨重，例如activeMq并不是mq的首选，如果仅为了mqtt协议支持不是太美好）

2、轻量级的mqtt broker大多对cluster支持不是太友好或者不支持（例如常用的：c++:mosquitto java:moquette)，并且对认证、tls等必备功能的支持需要自行编码plugin（不同语言难度很大），并且很多broker github star不高。

3、收费产品

总而言之，mqtt broker开源市场非常混乱，大多不能满足开箱即用，也未提供docker镜像，只有徐老师推荐的emqx最为亮眼。



**emqx**

emqx其分为开源版、企业版(license方式)、cloud saas，开源版已可以满足现有的使用场景，并且github 6.2k stars、文档丰富。概要功能支持如下：

1、完整的 MQTT V3.1/V3.1.1 及 V5.0 协议规范支持

- QoS0, QoS1, QoS2 消息支持
- 持久会话与离线消息支持
- 等等

2、TCP/SSL 连接支持

3、多种连接认证方式支持

4、多服务器节点集群 (Cluster)支持

5、依赖包、docker、k8s等多种部署方式的支持

其他详见：https://docs.emqx.io/broker/latest/cn/introduction/checklist.html



**emqx架构设计**

https://docs.emqx.io/broker/latest/cn/design/design.html



**部署方式**

emqx提供了多种部署方式，源码、docker、k8s等，基本开箱即用，仅需针对自己的特性拉取自己的分支做对应的配置|镜像等修改即可使用。

对于tsingj，作为平台级公共组件接入，类似elasticsearch log，独立的namespace notification，集群内所有其他应用层namespace共用emqx cluster，并可以根据部署配置自行选择使用ali mqtt & rocketmq | emqx cluster。



**测试**

1、QoS1（代表至少达到一次）消息，已可以正常收发消息。

2、离线消息clearSession=false已测试，可以收到离线消息。

3、topic测试，可自动生成topic,按照自定义topic的方式解决订阅的问题。

4、多节点集群部署（可以指定任务节点启动），已测试通过。



**性能测试**

待补充



**改造事项**

1、DS几乎无需太多变更，mqtt是标准协议，sdk使用eclipse pho(多语言支持)，连接地址等动态切换(ali mqtt & rocketmq | local mqtt)即可。

2、tm需要编写mqtt客户端，并根据配置策略选择不同的message producer发送消息通知。

3、auto_config支持选择ali 通知系统 | local 通知系统

4、基础组件部署脚本提供

