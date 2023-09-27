# MybatisPlus 遇到的问题

## dynamic-datasource-spring-boot-starter问题

**报错**

Failed to configure a DataSource: ‘url’ attribute is not specified and no embedded datasource could be configured.

SpringBoot 默认是单一数据源自动配置加载，所以禁止 SpringBoot 自动注入数据源配置即可解决

**解决**

```java
@SpringBootApplication(exclude = DruidDataSourceAutoConfigure.class)
```