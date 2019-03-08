# 开启Windows命令行代理

方法为：
```Py
set http_proxy=http://127.0.0.1:1080
set https_proxy=http://127.0.0.1:1080
```
这个只是在当前shell起作用的，不是系统变量，所以不用考虑。如果希望所有shell都配置可以直接配置进系统变量。