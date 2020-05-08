# 抽象

## callable

```Py
>>> x =2
>>> y = len
>>> callable(x) # 判断x是否可调用
False
>>> callable(y)
True
```

## 函数文档

```Py
>>> def square(x):
...     '计算x的平方值' # 这种放在函数第一行的字符串称作文档字符串
...     return x*x
>>> square.__doc__ # 返回函数文档
'计算x的平方值'
>>> help(square) # 返回函数的详细信息，包括函数文档
Help on function square in module __main__:

square(x)
    计算x的平方值
```

## 参数

### 修改参数

```Py
>>> def change(x):
...     x = x+1
...
>>> x=0
>>> change(x)
>>> x # 并不会改变外部值
0
>>> def change(x):
...     x[0] = x[0]+1
...
>>> x=[0]
>>> change(x) # 对于数组进行局部修改是可行的
>>> x
[1]
>>> x = [0]
>>> change(x[:]) # 传入x的副本，此时内部只修改副本，不影响内部
>>> x
[0]
>>> def inc(x): return x + 1 # 如果必需要改变参数，可以直接返回改变后的值，或者直接传入数组
...
>>> inc(0)
1
```

### 位置参数和关键字参数

```Py
>>> def hello(greeting="hi",name='arnold'):
...     print('{}, {}!'.format(greeting,name))
...
>>> hello('hello','bob') # 通过位置来传递参数
hello, bob!
>>> hello('hello',name='alice') # 混合使用位置和关键字参数，位置参数必须在前面，否则函数无法确定参数
hello, alice!
>>> hello(name='alice') # 对于有默认值的参数，可以直接省略
hi, alice!
>>> hello()
hi, arnold!
```

### 收集参数

```Py
>>> def print_params(x,y,z=3,*r1,d,**r2): # *r1用于收集位置参数，在其后面的参数必须是关键字参数，因此d必须用关键字赋值，而**r2收集所有剩余关键字参数
...     print(x,y,z)
...     print(r1)
...     print(d)
...     print(r2)
...
>>> print_params(1,2,3,4,5,6,7,8,d=19,foo=1,bar=2,sth="hh") 
1 2 3
(4, 5, 6, 7, 8)
19
{'foo': 1, 'bar': 2, 'sth': 'hh'}
```

### 分配参数

当我们有多个参数需要传递值的时候，可以传入一个序列或者字典，然后用前面提到的*和**进行反向操作，将不同的值分配到不同的参数中。但是，如果函数本身使用了收集参数，那么就没必要使用分配参数了，这样可能比直接传入序列和字典更加麻烦。

```Py
>>> def with_stars(**kwd):
...     print(kwd['name'],'is',kwd['age'],'years old.')
...
>>> def without_stars(kwd):
...     print(kwd['name'],'is',kwd['age'],'years old.')
...
>>> args = {"name":"bob","age":12}
>>> with_stars(**args) # 将字典解包分配到两个参数中，然后再放入形参中
bob is 12 years old.
>>> without_stars(args) # 直接传字典进入函数
bob is 12 years old.
>>> def add(a,b):
...     return a+b
>>> args = (2,3)
>>> add(*args) # 解包并分配参数到a,b
5
```

## 作用域

```Py
>>> x = 1
>>> scope = vars() # 返回全局变量定义域字典
>>> scope['x']
1
>>> scope['x']+=1
>>> x # 最好不要直接操作作用域的值
2
>>> def foo(): x=42  # 创建了局部变量x，此时属于另一个作用域
...
>>> x = 1
>>> foo() # 并不会改变全局变量x
>>> x
1
>>> def combine(parameter): print(parameter + external) # 局部作用域可以访问到全局作用域
...
>>> external = 'berry'
>>> combine("hi ")
hi berry
>>> def combine(parameter): print(parameter + globals()['parameter']) # 如果局部变量名与全局变量名冲突，可以通过globals()获取全局作用域字典，然后取出对应的值。（相对应的局部作用域字典为locals()）
...
>>> parameter = "berry"
>>> combine("Straw")
Strawberry

>>> x = 1
>>> def inc():
...     global x # 如果想修改外部变量或者获取外部变量，可直接声明为global
...     x = x+1
...
>>> inc()
>>> x
2
```

### 闭包

```Py
>>> def multiplier(factor):
...     def multiplyByFactor(number): # 该函数携带着外部函数的作用域，称之为闭包
...             return number*factor
...     return multiplyByFactor
...
>>> double = multiplier(2)
>>> double(10)
20
>>> triple = multiplier(3)
>>> triple(4)
12
>>> def multiplier(factor):
...     print('1',locals())
...     def multiplyByFactor(number):
...             print('2',locals())
...             return number*factor
...     return multiplyByFactor
...
>>> double = multiplier(2)
1 {'factor': 2}
>>> double(2)
2 {'number': 2, 'factor': 2}
4
>>> double(10) # 可访问外层函数的作用域，从而获得更加动态的函数特性
2 {'number': 10, 'factor': 2}
20

>>> def multiplier(factor):
...     print('1',locals())
...     def multiplyByFactor(number):
...             nonlocal factor # 定义外部变量nonlocal
...             factor += 3
...             print('2',locals())
...             return number*factor
...     return multiplyByFactor
...
>>> test = multiplier(0)
1 {'factor': 0}
>>> test(2) # 这里外部变量被修改
2 {'number': 2, 'factor': 3}
6
```

## 递归

递归函数通常包括两个部分：

- 基线条件（针对最小的问题）：满足这种条件时函数将直接返回一个值。

- 递归条件：包含一个或多个调用，这些调用旨在解决问题的一部分。

### 阶乘和幂

#### 阶乘

> 定义：
> 1的阶乘为1
> 对于n>1, n的阶乘等于(n-1)的阶乘乘以n

```Py
>>> def factorial(n):
...     if(n==1): return 1
...     else: return n*factorial(n-1)
...
>>> factorial(4)
24
```

#### 幂

> 定义：
> x的0次幂为1
> n>0, pow(x,n)为pow(x,n-1)*x

```Py
>>> def pow(x,n):
...     if n==0 : return 1
...     else: return x*pow(x,n-1)
...
>>> pow(2,3)
8
```

递归强在易读性，但是性能比不上循环。每一次返回自身，都是定义不同版本（不同作用域）的同一个函数，就像是两个同类的动物在交流。

## 函数式编程：map,filter,reduce

```Py
>>> data = [1,2,3,4,5]
>>> list(map(str,data)) # Python3中map,filter返回的是可迭代的对象。map用于将函数作用于序列
['1', '2', '3', '4', '5']
>>> list(filter(lambda x:x>3,data)) # filter用于筛出符合条件的数据
[4, 5]
>>> from functools import reduce # 由于reduce用处不大且不易理解，龟叔把它从python3的内建函数中移除了，想用的话需要从functools里引用
>>> reduce(lambda x,y:x+y, data) # reduce用于累计作用函数于整个序列
15
>>> from operator import add
>>> reduce(add,data)
15
```

