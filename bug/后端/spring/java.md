# 这是你的天堂  - Java

## 快捷对账

### 1，新增对账处理器

```java
实现 cn.swiftpass.core.server.acc.service.billdownloader.impl.AbstractCheckBillProcessor
    
@Service
@ApiProvider(apiProviderValue = AccConstants.自己约定的值)
public class WlmqFastPayCheckBillProcessor extends AbstractCheckBillProcessor {
    重写
        beforeProcess，下载文件前做些什么
        getTargetDownFileName，获取下载文件名称
        downloadCheckBillInner，下载第三方账单
        parsePayOrderDtoByLine，按照行解析文件，
        	这里把第三方订单信息存放thirdMap，
        	需关注存入的是否为威富通订单号
        	1，key 威富通订单号
        	2，key 不是威富通订单号
        
        
}

```

### 2，对账前置校验

```java
cn.swiftpass.core.server.acc.account.worker.CheckBillWorker#validate
需改动
如果第三方返回的有下载路径，这不需要验证，配置下载文件路径
// 需要对账方式-任务没有配置下载文件路径
if (payCenterDto.getApiProvider()!=API_PROVIDER_FAST_CARD ......) {
    logger.error("第三方下载地址为空，请检查。任务id={}", task.getTaskId());
    return false;
}
    
如果第三方没用返回下载路径
cn.swiftpass.core.server.acc.service.impl.CheckBillTaskServiceImpl#buildCheckBillTask
修改 设置对账下载路径
    
/** 下载任务属性初始化 */
// 设置对账下载路径
if (AccConstants.API_PROVIDER_FAST == payCenterDto.getApiProvider()) {
    String downloadMessage = payCenterDto.getDownLoadMessage();
    Map downMsgMap = JSON.parseObject(downloadMessage, Map.class);
    if (downMsgMap.containsKey("path")) {
        checkBillTaskDto.setBillPath(downMsgMap.get("path").toString());
    }else {
        logger.error("快捷支付-对账信息 path 未配置");
    }
}   

```



### 3，逐笔对账

```java
cn.swiftpass.core.server.acc.account.worker.CheckBillWorker#work

jdbc逐笔对账
cn.swiftpass.core.server.acc.account.job.CheckBillPayOrderJob#execute     支付订单处理
cn.swiftpass.core.server.acc.account.job.CheckBillRefundOrderJob#execute  退款订单处理
    thirdMap key不是威富通订单号
    	thirdPayOrder = thirdMap.get(wftPayOrder.getOrderNo())需改动
    	checkedThirdOrderNoSet.add(wftPayOrder.getOrderNo()) 需改动
    
    checkedThirdOrderNoSet是已对的第三方账单Set
    checkBillUpDownDtos挂销账List
    
销账处理，过滤thirdMap中已对账的订单，剩下之前挂账的订单
cn.swiftpass.core.server.acc.account.worker.CheckBillWorker#dealRemainingBill
    
根据thirdMap中订单号获取本地订单信息
    thirdMap key不是威富通订单号，需改动，获取威富通订单号
cn.swiftpass.core.server.acc.account.utils.ThirdMoreOrderHandler#thirdMoreOrderHandle
    
```

### 4，模拟造订单数据

```sql
运行bill-generator服务
修改数据库连接信息

1，下载最新导入模板
2，select * from TRA_PAY_TYPE; --- 支付类型
     获取 支付类型简称，pay_type_id，pay_center_id通道id，api_code
   SELECT * FROM CMS_MERCHANT; --- 商户表
     获取 商户号	商户编号
3，修改excel，新增订单
```

### 5，修改订单商户手续费

```sql
支付订单
SELECT * FROM PAY_ORDER ORDER BY OUT_TRADE_NO DESC;
修改 calc_state为1（计算完成），mch_theory_procedure_fee, mch_real_procedure_fee, mch_discount_fee 为0 

退款订单
SELECT * FROM pay_refund ORDER BY REFUND_NO  DESC;
修改 calc_state为1（计算完成）...手续费为0 
```

### 5，构造第三方订单文件

```
按照第三方订单格式修改数据

修改订单号或者流水号为 我们造的数据 的订单号或第三方订单号等

上传到ftp
```

### 6，页面测试

```
1，支付通道管理配置
2，对账任务设置--选择对账时间--1，删除第三方账单 2，重新对账 3，单任务触发对账


```

