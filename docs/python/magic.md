# __all__
在看一个项目源码的时候，发现作者用了个这个，查了一下，了解如下：
```
这是一个字符串list,用于外部调用 from xx import * 时，设定哪些变量和函数对外开放。
```
例如存在以下文件`all.py`：
```
__all__ = ['x', 'y', 'z']

x = 2
y = 3
z = 4

def test():
    print('test')
```
新建文件`foo.py`：
```
from all import *
print('x: ', x)

print('y: ', y)
print('z: ', z)

test()
```
结果如下：
```
x:  2
y:  3
z:  4
Traceback (most recent call last):
  File "foo.py", line 7, in <module>
    test()
NameError: name 'test' is not defined
```

但是如果手动添加`from all import test`,依然可以解决问题。
实用`__all__`的好处就是，可以设定哪些对外暴露，从而避免导入不必要的包。