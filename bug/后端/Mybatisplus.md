# MybatisPlus 遇到的问题

## dynamic-datasource-spring-boot-starter问题

**报错**

Failed to configure a DataSource: ‘url’ attribute is not specified and no embedded datasource could be configured.

SpringBoot 默认是单一数据源自动配置加载，所以禁止 SpringBoot 自动注入数据源配置即可解决

**解决**

```java
@SpringBootApplication(exclude = DruidDataSourceAutoConfigure.class)
```



## 问题：Oracle数据库

> Mybatis & Oracle数据库批量插入SQL问题



**注意：传递得 list 集合不能为空，否则会报错**



<img src="https://v0710.top/images/img/企业微信截图_17047184081357.png" alt="img" style="zoom: 50%;" />

```sql
1，表建立了序列
-- SEQ_ACC_ACCOUNTING_DATA.NEXTVAL 获取 SEQ_ACC_ACCOUNTING_DATA序列值，
<insert>
INSERT INTO 表名 (id,fldS1,fldS2)
    select SEQ_ACC_ACCOUNTING_DATA.NEXTVAL,A.* from(
        <foreach collection="list" item="item" index="index" separator="UNION ALL">
            SELECT
             #{item.fldS1, jdbcType=VARCHAR} as fldS1,
             #{item.fldS2, jdbcType=VARCHAR} as fldS2
            from dual 
        </foreach>
     ) A
</insert>



2，表没创建序列

<insert>
 INSERT INTO 表名 (id,fldS1,fldS2)
     select A.* from(
        <foreach collection="list" item="item" index="index" separator="UNION ALL">
            SELECT
             #{item.id, jdbcType=VARCHAR},
             #{item.fldS1, jdbcType=VARCHAR},
             #{item.fldS2, jdbcType=VARCHAR}
            from dual 
        </foreach>
     ) A
</insert>
```

