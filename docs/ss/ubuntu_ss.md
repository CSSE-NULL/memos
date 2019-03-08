# ubuntu配置shadowsocks-qt5

## 添加ppa并下载

```bash
sudo add-apt-repository ppa:hzwhuang/ss-qt5
sudo apt-get update
sudo apt-get install shadowsocks-qt5
```

## Ubuntu18.04

添加上面的ppa时出现：

```bash
忽略: http://ppa.launchpad.net/hzwhuang/ss-qt5/ubuntu bionic InRelease
错误: http://ppa.launchpad.net/hzwhuang/ss-qt5/ubuntu bionic Release
    404  Not Found [IP:91.189.95.83 80]
```

这是作者还没测试18.04,可以直接将源里面的18.04的代号(bionic)改成16.04(xenial):

```Bash
sudo vim /etc/apt/sources.list.d/hzwhuang-ubuntu-ss-qt5-bionic.list
#将下面的bionic改成xenial
  deb http://ppa.launchpad.net/hzwhuang/ss-qt5/ubuntu xenial main

```
这样就可以了。