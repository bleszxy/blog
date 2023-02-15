#### Xms和Xmx设置一致的原因

转自：https://www.zhihu.com/question/57417626

把xmx和xms设置一致可以让JVM在启动时就直接向OS申请xmx的commited内存，好处是：

1. 避免JVM在运行过程中向OS申请内存

2. 延后启动后首次GC的发生时机

3. 减少启动初期的GC次数

   4. 尽可能避免使用swap space

![image-20200416112837237](all_images/image-20200416112837237.png)



Java启动options

https://docs.oracle.com/javase/8/docs/technotes/tools/windows/java.html

gc介绍

https://docs.oracle.com/javase/8/docs/technotes/guides/vm/gc-ergonomics.html

