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

