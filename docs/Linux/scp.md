# scp命令记录

## 本地上传

```shell
#文件
$scp local_file remote_username@remote_ip:remote_folder
$scp local_file remote_username@remote_ip:remote_file
# 文件夹
$scp -r local_folder remote_username@remote_ip:remote_folder
$scp -r local_folder remote_ip:remote_folder
```

## 从远端下载

```shell
#文件
$scp remote_username@remote_ip:remote_folder local_file
$scp remote_username@remote_ip:remote_file local_file
#文件夹
$scp -r remote_username@remote_ip:remote_folder local_folder
$scp -r remote_ip:remote_folder local_folder
```