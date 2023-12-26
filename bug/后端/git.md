## Git问题

问题：

git代码提交、推送报错

You have not concluded your merge(MERGE HEAD exists).hint: Please,  [commit](https://so.csdn.net/so/search?q=commit&spm=1001.2101.3001.7020) your changes beforemerging.Exiting because of unfinished merge



解决：

 `git reset --merge` 

<img src="C:\Users\yufan.wang\AppData\Roaming\Typora\typora-user-images\image-20231226175318961.png" alt="image-20231226175318961" style="zoom:50%;" />

`git push`





问题 Git 403  

> Failed to connect to github.com port 443 : Timed out

解决

<img src="https://v0710.top/images/img/image-20230831142312458.png" alt="image-20230831142312458" style="zoom:50%;" />

```javascript
git config --global http.proxy http://127.0.0.1:7890 
git config --global https.proxy http://127.0.0.1:7890
```

```
 Failed to connect to github.com port 443 after 21085 ms: Timed out
 
 git config --global --unset http.proxy
 git config --global --unset https.proxy
```