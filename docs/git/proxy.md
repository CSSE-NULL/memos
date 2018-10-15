##git 设置shaodwsocks代理
今天体验了一把git下载国外仓库的缓慢速度（以前用github都没觉得这么慢），实在是不想等了，于是
了解了一下如何用shadowsocks开代理加速，设置方法很简单：
```
git config --global http.proxy 'socks5://127.0.0.1:1080'
```
这样就可以从原来十几k提升到几百k了（亲测）。需要注意，git不存在https.proxy设置的，这里是`http`,不带s,
否则设置无效。
这个可能比较麻烦的就是需要后台必须挂着sahdowsocks客户端，而且如果访问国内的仓库，加速估计会起反效果，
因此这里也放一下关闭的方式：
```
git config --global --unset http.proxy
```
查看`config --global`的所有选项：
```
git config --global -l #列出来
git config --global -e #编辑
```
