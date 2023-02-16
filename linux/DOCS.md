[TOC]



#### 各种基础命令含义

```
$0, $#, $*, $@, $?, $$的含义
$# 是传给脚本的参数个数
$0 是脚本本身的名字
$1 第一个参数
$2 第二个参数
$@ 所有参数的列表
$* 以一个单字符串显示所有向脚本传递的参数
$$ 脚本运行的当前进程ID号
$? 显示最后命令的退出状态，0表示没有错误，其他表示有错误
```



#### 参数接收

**方式1 xxx.sh 参数1 参数2**

```
示例：
test.sh
#!/bin/bash
echo "参数总数:$#"
echo "shell name:$0"
echo "第一个参数:$1"
echo "第二个参数:$2"
echo "params as arr:$@"
echo "params as str:$*"
echo "current process id:$$"
echo "last cmd precomm stat: $?"

```



**方式2 xxx.sh -p 参数1 -x 参数2**

```
#!/bin/bash

while getopts "p:" opt; do
  case $opt in
    p)
      echo "-p arg is: $OPTARG"
      ;;
    \?)
      exit 0;
      ;;
  esac
done

正确输出：
./indocker.sh  -p 123
-p arg is: 123

异常输出：
./indocker.sh  -a 123
./indocker.sh: illegal option -- a

```



**实际运用场景**

```
#!/bin/bash

#定义example输出,中间有换行符，echo输出时需要带-e
example="格式: ./indocker.sh [local-console-dir] [local-maven-m2-repo-dir] [shell]\n构建中台: ./indocker.sh /Users/yanghao/IdeaProjects/debug /Users/yanghao/.m2/repository ./build.sh\n执行其他命令: ./indocker.sh /Users/yanghao/IdeaProjects/debug /Users/yanghao/.m2/repository 'mvn -f ../pom.xml clean'";

//判断是否为help命令
if [[ ${#@} -ne 0 ]] && [[ "${@#"--help"}" = "" ]]; then
  echo -e ${example};
  exit 0;
fi;

//判断参数总数是否为3个
if [[ $# -ne 3 ]] ;then
    echo -e ${example}
    exit 0;
fi;

echo "console-dir: $1"
echo "m2-repo-dir: $2"
echo "prepare exec: $3"

#使用mvn-builder进行构建,挂载$1->/root/console、$2->/root/.m2/repository,将本地的项目和maven repository共享至mvn-builder docker中.
docker run --mount src=$1,target=/root/console,type=bind --mount src=$2,target=/root/.m2/repository,type=bind  -w "/root/console/buildtools" mvn-builder $3

echo "maven build success."
```



#### 最后执行命令的退出状态判断

```shell
#!/bin/bash
echo "prepare init console-mvn-builder."
docker -H ${REMOTE_DOCKER} exec console-mvn-builder rm -rf /root/console
if [[ $? -ne 0 ]]; then
    echo "init console-mvn-builder fail!"
    exit 1;
fi
echo "init console-mvn-builder done."
```



#### exit 0 exit1的区别

​	exit 0正常运行程序并退出程序

​	exit 1非正常运行导致退出程序



#### 获取当前文件夹目录、文件夹名、上级目录

```
当前文件夹目录：$PWD

当前文件夹名：${PWD##*/}

上级文件夹目录：$(dirname "$PWD")
```

  

#### 如何添加--help提示

```
example="格式: ./indocker.sh [shell] (default ./build.sh)";
if [[ ${#@} -ne 0 ]] && [[ "${@#"--help"}" = "" ]]; then
  echo -e ${example};
  exit 0;
fi;
```



#### 文件内容提换

```
//替换SERVER_IO_MODEL.md文件内，所有的all_images字符串为all_images
sed -i 's#all_images#all_images#g' SERVER_IO_MODEL.md
```

  

