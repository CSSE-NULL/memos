# 魔法方法

## \_\_init\_\_

```Py
>>> class FooBar:
        def __init__(self): # 会在实例化的时候自动执行
            self.svar = 42
>>> f = FooBar()
>>> f.svar
42

class Bird:
    def __init__(self):
        self.hungry = True
    def eat(self):
        if self.hungry:
            print('Aaaah ...')
            self.hungry = False
        else:
            print('No, thanks!')

class SongBird(Bird):
    def __init__(self):
        super().__init__() #或者用Bird.__init__(self)
        self.sound = 'Squawk!'
    def sing(self):
        print(self.sound)

```


## \_\_all\_\_

这是一个字符串list,用于外部调用 from xx import * 时，设定哪些变量和函数对外开放。

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

## 迭代器

```Py
class Fibs:
    def __init__(self):
        self.a = 0
        self.b = 1
    # 实现了方法__next__的对象是迭代器
    def __next__(self):
        self.a, self.b = self.b, self.a + self.b
        return self.a
    #实现了__iter__方法的对象才是可迭代的
    def __iter__(self):
        return self

>>> class T:
        value = 0
        def __next__(self):
            self.value += 1
            if self.value>10:raise StopIteration
            return self.value
        def __iter__(self):
            return self
>>> t = T()
>>> list(t) # T是一个返回10个数字序列的迭代器
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

>>> class A:
        astr = "a"
        def __next__(self):
            self.astr = random.choice(string.ascii_letters)
            if len(self.astr)>10: raise StopIteration
            return self.astr
        def __iter__(self):
            return T()
>>> a  = A()
>>> list(a) # __iter__可以返回其他迭代器对象，此时调用的是T类型对象的迭代器
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

>>> class A:
...     astr = "a"
...     def __next__(self):
...             self.astr += random.choice(string.ascii_letters)
...             if len(self.astr)>10: raise StopIteration
...             return self.astr
...     def __iter__(self):
...             return self
...
>>> a = A()
>>> list(a) # 此时调用的才是A的迭代器
['az', 'azT', 'azTJ', 'azTJU', 'azTJUO', 'azTJUOR', 'azTJUORd', 'azTJUORdU', 'azTJUORdUt']
```

## 生成器

```Py
def flatten(nested):
    try:
        for sublist in nested:
            for element in flatten(sublist): # 对于序列，遍历子序列
                yield element
    except TypeError: # 如果当前处理的是一个数字而不是数组，直接返回该值
        yield nested
>>> n
[0, 1, [3, [4], [[5, 6], [7, 8]]], 3, 4]
>>> flatten(n)
<generator object flatten at 0x000001B667C33BA0>
>>> list(flatten(n))
[0, 1, 3, 4, 5, 6, 7, 8, 3, 4]
>>> a=flatten('aaa') # 该函数无法处理字符串，因为单个字符也是字符串，不会出现TypeError,同时字符串应该视为整体而不是字符组成的序列
>>> list(a)
Traceback (most recent call last):
RecursionError: maximum recursion depth exceeded

```
