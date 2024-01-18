问题

 Cause: java.lang.IndexOutOfBoundsException: Index: 0, Size: 0

解决

```java
@AllArgsConstructor
@NoArgsConstructor
```



----

问题

java 8 date/time type `java.time.LocalDateTime` not supported by default: add Module "com.fasterxml.jackson.datatype:jackson-datatype-jsr310" to enable handling (through reference chain: com.ld.poetry.entity.User["createTime"])

解决

```java
@JsonDeserialize(using = LocalDateTimeDeserializer.class)
@JsonSerialize(using = LocalDateTimeSerializer.class)
@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
```



---

问题

 org.apache.ibatis.cache.CacheKey cannot be cast to java.lang.String、

解决

```java
自定义key 加密
```



问题

RPC远程调用，@RequestParam接收参数，请求参数多大，调用会报错400

原因

```
GET请求，HTTP规范对URL长度是没有限制的

浏览器有不同得限制。

简单可以理解为：Get请求，URL长度不要超过 2KB



Post请求，也是没有长度限制的。限制它的是服务器的处理能力，与存储大小。

还有就是Web容器的限制，比如Tomcat 默认是2MB。
```

 
