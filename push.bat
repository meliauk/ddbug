
cmd /k "cd /d %~dp0&&gitbook build&&git add .&&git commit -m 'update'&&git push -f origin master &&start https://gitee.com/MEliauk/ddbug/pages"
