1. 复杂sql场景and xxx=xxx and (a=xxx or (b=xxx and a= xxx))

   ```
   使用中碰到如下复杂sql场景：
   // t.is_delete = 0 and t.data_server in (xxx,xxx,xx) and 
   // (  t.`user_id` = #{userId} or (t.`is_public` = 1 and t.`user_id` is not null) )
   
   解决方式
   DataInfoCriteria dataInfoCriteria = new DataInfoCriteria();
   dataInfoCriteria.or().andIsDeleteEqualTo(false).andDataServerIdIn(activeDataServerNotCacheIdList)
           .andUserIdEqualTo(currentUserId);
   dataInfoCriteria.or().andIsDeleteEqualTo(false).andDataServerIdIn(activeDataServerNotCacheIdList)
           .andIsPublicEqualTo(true).andUserIdIsNotNull();
           
   通过example生成sql:
   select xxx from data_info WHERE ( is_delete = ? and data_server_id in ( ? , ? , ? ) and user_id = ? ) or( is_delete = ? and data_server_id in ( ? , ? , ? ) and is_public = ? and user_id is not null ) 
   ```

   通过文章例如：https://www.cnblogs.com/gengaixue/p/6655171.html?utm_source=itdadao&utm_medium=referral 等等，看到都是通过这种方式解决的，虽然个人感觉解决方式不是太友好! 建议手写自定义的mapper，如下2。

2. 如何在自定义的xml文件中使用generator-gui生成的sql片段？

   接着1碰到的问题，生成了自定义的mapper，resultMap和columnList是一致的，在custormXml中使用如下方式跨xml引用sql片段

   ```java
   //对于自定义的业务，不需要再自定义gui生成的criteria，只需按照业务需要给定入参.
   //custom mapper
   @Data
   @Builder
   @NoArgsConstructor
   @AllArgsConstructor
   @FieldDefaults(level = AccessLevel.PRIVATE)
   public class DataInfoCustomCriteria {
       Long userId;
       List<Long> activeDataServerIds;
   }
   
   @Mapper
   public interface DataInfoCustomMapper {
   
       /**
        * 数据市场-查询全部数据集信息
        * @param dataInfoCustomCriteria
        * @return
        */
       List<DataInfo> dataMarketQueryAll(DataInfoCustomCriteria dataInfoCustomCriteria);
   
   }
   
   //custom xml
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
   <mapper namespace="com.tsingj.tm.microservice.dao.DataInfoCustomMapper">
   
   //这里resultMap指定DataInfoMapper下的BaseResultMap
       <select id="dataMarketQueryAll" resultMap="com.tsingj.tm.microservice.dao.DataInfoMapper.BaseResultMap" parameterType="com.tsingj.tm.microservice.model.DataInfoCustomCriteria">
           select
           //这里columnList指定DataInfoMapper下的Base_Column_List
           <include refid="com.tsingj.tm.microservice.dao.DataInfoMapper.Base_Column_List"/>
           from data_info
           <include refid="DATA_MARKET_QUERY"/>
       </select>
   
       <sql id="DATA_MARKET_QUERY">
           WHERE is_delete = 0
           <if test="activeDataServerIds != null">
               <![CDATA[ AND data_server_id in ]]>
               <foreach collection="activeDataServerIds" item="id" index="index" open="(" close=")" separator=",">
                   #{id}
               </foreach>
           </if>
           and (user_id = ${userId} or (is_public = 1 and user_id is not null))
       </sql>
   
   </mapper>
   ```

3. PageHelper分页查询无效的问题

   ```
   //通过PageHelper进行分页查询，代码如下：
   //1.开启分页查询
   PageHelper.startPage(pageNo, pageSize);
   //2.执行基本的sql查询
   dataInfos = dataInfoCustomMapper.dataMarketQuery(dataInfoCustomCriteriaBuilder.build());
   //3.生成pageInfo
   PageInfo<DataInfo> pageInfo = new PageInfo<>(dataInfos);
   //只可以在pageInfo的处理后进行vo转换
   GenericPage<DataInfoVOV1> page = new GenericPage<>(pageSize, pageInfo.getTotal(), this.convertDataInfosToVOV1s(dataInfos));
   
   步骤2.执行基本的sql查询会被PageHelper拦截，对其加上count sql & limit sql，并封装为Page<DataInfo>的类型，不要对这个变量进行vo转换，因为new PageInfo<>(dataInfos)这里会判断对象是否为page，源码如下：
    public PageSerializable(List<T> list) {
           this.list = list;
           if(list instanceof Page){
               this.total = ((Page)list).getTotal();
           } else {
               this.total = list.size();
           }
       }
   
   ```

   

