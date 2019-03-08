# 服务器搭建ftp平台

## 服务器端安装

### 安装ftp并配置

```shell
sudo apt-get install vsftpd
```

```shell
sudo vim /etc/vsftpd.conf

执行之后就可以进行以下修改（不想修改可跳过）

#禁止匿名访问
anonymous_enable=NO
#接受本地用户
local_enable=YES
#允许上传
write_enable=YES
#用户只能访问限制的目录
chroot_local_user=YES
#设置固定目录，在结尾添加。如果不添加这一行，各用户对应自己的目录，当然这个文件夹自己建
local_root=/home/ftp
```

### 添加ftp用户

```shell
sudo useradd -d /home/ftp -M ftpuser
sudo passwd ftpuser
```

### 调整文件夹权限

```shell
# 这里为了防止外部用户直接对ftp主文件夹进行修改
sudo chmod a-w /home/ftp
sudo mkdir /home/ftp/data
```

### 改pam.d/vsftpd

```shell
sudo vim /etc/pam.d/vsftpd
将以下一行用#号注释掉，否则会出现login incorrect：
auth required pam_shells.so
```

### 重启服务

```shell
sudo service vsftpd restart
```

## 客户端使用

有三种途径：命令行，ftp客户端，资源管理器。分别介绍一下：

- 命令行

```shell
:~$ ftp your_ip

Connected to your_ip.
220 (vsFTPd 3.0.3)
Name (): ftpuser
331 Please specify the password.
Password:
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.

ftp> passive # 开启passive模式，否则无法进行操作
ftp> ls # 查看
ftp> cd data # 切换
ftp> put xxx # 上传
ftp> get xxx # 下载

```

- ftp客户端
比如xftp,使用方法直接百度就行。

- 资源管理器

在资源管理器（也就是你平常看磁盘文件的地方）上方的搜索栏输入以下三种格式中的任意一种：

```shell
1)完全格式：         ftp://username:password@hostname:port
2)快捷格式：         ftp://username@hostname:port
3)便捷格式：         ftp://hostname:port
```

然后就可以看到相应的文件了。