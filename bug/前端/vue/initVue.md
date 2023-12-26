问题

vue打包

解决

```
如果是路径问题
vue.config.js 中  publicPath: './' 

如果打包后访问不报错空白问题
 new VueRouter 中 mode:"history"  改为 mode: "hash"
 
 若要使用它，且项目部署部署在根节点需要加
 base: '/justMe/',
```



---



# 数据更新，DOM未刷新

dom元素加if判断
```javascript
<Table v-if="tableObject.tableList.length > 0":loading="tableObject.loading" >
```