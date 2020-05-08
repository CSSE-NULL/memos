# 模块与包

## 模块

```Py
>>> import sys
>>> sys.path.append('e:/') # 在e盘根目录有文件hello.py
>>> import hello # 导入模块时执行代码
Hello, world!
>>> import hello # 模块只执行一次
>>> import importlib # 可通过该模块对模块重新加载
>>> hello = importlib.reload(hello)
Hello, world!
>>> import hello # 此处将原打印功能放入函数hello,并执行hello()进行测试
Hello, world!
>>> hello.hello()
Hello, world!

# 可见函数在导入和执行时效果一致，但是我们希望的是导入的时候不执行，调用的时候才执行，所以我们有一种区分作为模块和测试的方法：
>>> __name__ # 当前运行程序为__main__
'__main__'
>>> hello.__name__ # hello模块在被导入时名称为hello
'hello'
# 可以修改为以下代码
def hello():
    print("Hello, world!")
def test():
    hello()
if __name__ == '__main__': test()

>>> import hello # 此时不会执行任何代码
>>> hello.test()
Hello, world!
```

### 添加自定义模块

要让程序找到你的模块，有两种方法：

1. 将程序添加到指定的搜索路径文件夹中。这种可以通过打印sys.path查看

2. 将程序所在路径添加到搜索路径中。前面的直接append可以动态添加，也可以永久添加到环境变量PYTHONPATH中。

## 包

包就是包含模块的模块。系统根据文件夹是否包含`__init__.py`进行判定。如果想让包也和模块一样使用，可以把相应的逻辑代码写在`__init__.py`，例如：

```shell
# 建立一个包
E:\>tree /f mytest
E:\MYTEST
│  hello.py
│  __init__.py
│
└─__pycache__
        __init__.cpython-36.pyc

```

其中，`__init__.py`中有一个变量PI=3.14,我们导入试试：

```Py
>>> import mytest
>>> mytest.PI
3.14
# 以下是各种导入方式
>>> import mytest.hello
>>> from mytest import hello
>>> from mytest import hello as hl
```

## 探索模块

### dir 和 \_\_all\_\_

```Py
>>> import copy
>>> [n for n in dir(copy) if not n.startswith('_')] # 返回模块的所有属性和变量
['Error', 'copy', 'deepcopy', 'dispatch_table', 'error']
>>> [n for n in dir(mytest) if not n.startswith('_')]
['PI', 'hello']
>>> copy.__all__ # 返回的是对外开放接口，这个是模块定义的，在import *时起作用
['Error', 'copy', 'deepcopy']
```

### \_\_file\_\_

```Py
>>> copy.__file__ # 可以查到源码地址
'D:\\Anaconda3\\lib\\copy.py'
```