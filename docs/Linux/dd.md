# dd命令制作启动盘

## 具体方法

Linux下制作启动盘的方式很简单，可以直接通过dd命令，命令如下：

```shell
sudo dd if=xxx.iso of=/dev/sdbx
```

这里表示将if指向的镜像文件写入of指向的盘中。其中，of指向的盘位置可通过`sudo fdisk -l`查看。