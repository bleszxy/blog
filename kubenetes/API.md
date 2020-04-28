#### Kubernetes API总览

REST API 是 Kubernetes 的基础架构。组件之间的所有操作和通信，以及外部用户命令都是 API Server 处理的 REST API 调用。因此，Kubernetes 平台中的所有资源被视为 API 对象，并且在 [API](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/) 中都有对应的定义项。

大多数操作可以通过 [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) 命令行界面或其他命令行工具执行，例如 [kubeadm](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm/)，它们本身也使用 API。但是，您也可以使用 REST 调用直接访问 API。

如果您正在使用 Kubernetes API 编写应用程序，请考虑使用 [客户端库](https://kubernetes.io/docs/reference/using-api/client-libraries/)。

以上来自官网:https://kubernetes.io/zh/docs/reference/using-api/



#### 客户端java技术选型

##### 官方 java client

https://github.com/kubernetes-client/java

##### fabric8io java client

https://github.com/fabric8io/kubernetes-client.git

[spring-cloud-kubernetes](https://github.com/spring-cloud/spring-cloud-kubernetes) 底层使用的java client为fabric8io java client,fabric8io java client底层封装了kubernetes client java,更提供了额外的openshift支持。

##### 如何选择？

如果您是使用java进行研发，并且防止后期使用spring-cloud-kubernetes套件，建议使用fabric8io java client。



#### 示例

查询指定namespace所有pod

```java
   @Test
    public void getPodList() {
        Config config = new ConfigBuilder().withMasterUrl(MASTER_URL).withTrustCerts(true).build();
        KubernetesClient client = new DefaultKubernetesClient(config);
        PodList list = client.pods().inNamespace(NAMESPACE).list();
        List<Pod> items = list.getItems();
        for (int i = 0; i < items.size(); i++) {
            Pod pod = items.get(i);
            ObjectMeta metadata = pod.getMetadata();
            if (metadata != null) {
                String podName = metadata.getName();
                System.out.println((i + 1) + ":" + podName);
            }
        }
        client.close();
    }

执行输出:
1:common-redis-96dc8cb5f-vhp44
2:console-adgw-service-56f95c6f8d-s5h5p
3:console-kafka-674449c77b-z99dr
4:console-mysql-0
5:console-nacos-bbbc89b87-b5mpn
6:console-nginx-5476c7dc57-m2dz8
7:console-redis-cbb4f8f9b-grqps
8:console-register-5bf55885df-vdbkq
9:console-scheduler-service-5b8dd7f595-c864g
10:console-sso-service-69b6d85c69-xdf5v
11:console-track-service-0
12:console-user-service-7d5d7bf4cc-t6w42
13:console-zookeeper-54cbdfc56-dqj9q
```

详见:https://github.com/fabric8io/kubernetes-client/tree/master/kubernetes-examples