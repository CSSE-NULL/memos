# 条件、循环及其他语句

## print

这个语句在python3中已经变成了一个函数，使用如下：

```Py
>>> print('a','ha') # 以空格分隔，拼接多个字符串输出
a ha
>>> print('a','ha',32)
a ha 32
>>> a='hello,';b='mr.';c='bob'
>>> print(a,b,c)
hello, mr. bob
>>> print(a,b,c,sep="_") # sep设置间隔符
hello,_mr._bob
>>> print(a,end=" ");print(b) # end设置结尾符号
hello, mr.
>>> print(a,end="\n");print(b)
hello,
mr.
>>> print(a,end="\t");print(b)
hello,  mr.
>>> print(a,end="ttttt");print(b)
hello,tttttmr.
```

## 赋值魔法

### 序列解包

```Py
>>> x,y,z = 1,2,3 # 序列解包，分别赋值给x,y,z
>>> x,y = y,x # 执行交换，这里也是先将y,x打包成元组，然后解包到x,y
>>> print(x,y,z)
2 1 3
>>> x,y = 1,2,3 # 左右数目要一致
ValueError: too many values to unpack (expected 2)
>>> x,y,*rest = 1,2,3,4 # 可通过*号收集剩余的元素
>>> rest
[3, 4]
>>> first,*mid,last = "Albus Percival Wulfric Brian Dumbledore".split() # 只取前后两个
>>> mid
['Percival', 'Wulfric', 'Brian']
>>> a,*b,c = 1,2,3 # 即使数目一致，*号代表的都是列表
>>> b
[2]
```

## 条件语句

### 布尔表达式

布尔表达式中的假： False None 0 "" () [] {} ，也就是False,None,0和所有空序列和映射。其他值都视为真。事实上bool类型的True是数字1的别名，False是0的别名：

```Py
>>> True==1
True
>>> False==0
True
```

### if语句

```Py
>>> name = input('What is your name? ')
What is your name? test
>>> if name.endswith('Gumby'):
...     print("hello grumby")
...
```

### else语句

```Py
>>> if name.endswith('Gumby'):
...     print("hello grumby")
... else:
...     print('not you')
...
not you
```

### 条件表达式

```Py
>>> status = "friend" if name.endswith("Gumby") else "stranger" # if判断为真则返回if前面的值，否则返回else后面的值
>>> print(status)
stranger
```

### elif 语句

```Py
>>> if num > 0:
...     print('The number is positive')
... elif num < 0: # if为false时进行判断
...     print('The number is negative')
... else:
...     print('The number is zero')
```

### 其他判断

#### is 和 ==

is判断两个对象是否相同，==判断两个对象的值是否相等。

```Py
>>> x=y=[1,2]
>>> z=[1,2]
>>> x is y
True
>>> x is z
False
>>> x ==y
True
>>> y == z
True
```

### and,or,not

```Py
if number <= 10 and number >= 1: # and必须同时成立才为真，or只需要其中一个为真，not表示语句为假时值为真
print('Great!')
else:
print('Wrong!')
```

### assert

这是用于出现对应错误时提前结束程序的，这样有利于我们能准确定位到出错代码。

```Py
>>> age = -1
>>> assert 0<age<100, "not leagal age {}".format(age)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AssertionError: not leagal age -1
```

## 循环语句

### while

```Py
>>> name = ''
>>> while not name: # 条件为真时才能跳出循环（name有值）
...     name = input('Please enter your name: ')
...
Please enter your name:
Please enter your name:
```

### for

for用于对可迭代对象（如序列）进行循环操作

```Py
>>> words = ['this', 'is', 'an', 'ex', 'parrot']
>>> for word in words:
...     print(word)
...
this
is
an
ex
parrot
```

## 一些迭代工具

### 并行迭代

```Py
>>> names = ['anne', 'beth', 'george', 'damon']
>>> ages = [12, 45, 32, 102]
>>> zip(names,ages) # zip可以缝合两个序列
<zip object at 0x0000012E74C2D788>
>>> list(zip(names,ages))
[('anne', 12), ('beth', 45), ('george', 32), ('damon', 102)]
>>> for n,a in zip(names,ages):
...     print(n,a)
...
anne 12
beth 45
george 32
damon 102
>>> list(zip(range(5),range(1000000000))) # zip如果遇到两个长度不等的序列，则以长度较短的为主。
[(0, 0), (1, 1), (2, 2), (3, 3), (4, 4)]
```

### 迭代时获取索引

```Py
>>> for index,s in enumerate(name): #enumerate用于同时获取索引和值
...     print(index,s)
...
0 w
1 o
2 r
......
```

## 跳出循环

- break

- continue

## 循环中的else

当需要判断循环是正常终止还是break的时候，可以使用`else`:

```Py
>>> for n in range(10):
...     if n>10:
...             break
... else: # 在for循环正常执行完毕后执行
...     print('hah')
...
hah
```

## 简单推导

```Py
>>> girls = ['alice', 'bernice', 'clarice']
>>> boys = ['chris', 'arnold', 'bob']
>>> [b+'+'+g for b in boys for g in girls if b[0] == g[0]] # 使用语句来生成列表，进行列表推导
['chris+clarice', 'arnold+alice', 'bob+bernice']
>>> test = {i:i**2 for i in range(10)} # 字典推导
>>> test
{0: 0, 1: 1, 2: 4, 3: 9, 4: 16, 5: 25, 6: 36, 7: 49, 8: 64, 9: 81}
```

## 一些实用函数

### del

```Py
>>> x =1
>>> del x #删除名称x,此时1这个数值没有任何引用，python解释器会直接将其删除，这称为垃圾收集
>>> x
NameError: name 'x' is not defined
>>> x= ["hha"]
>>> y=x
>>> del x # 删除x,但是y仍然指向该列表，所以仍然可以通过y找到列表，事实上，Python根本没法删除任何值，只有在没有任何指向它的引用时，会被自动删除。
>>> y
['hha']
```

### exec

```Py
>>> from math import sqrt
>>> exec("sqrt=1") # 将字符串作为语句执行
>>> sqrt(2) # sqrt被覆盖了
TypeError: 'int' object is not callable
>>> sqrt
1
>>> scope = {}
>>> from math import sqrt
>>> sqrt
<built-in function sqrt>
>>> exec("sqrt=1",scope) # 可以指定命名空间，这样就不会被覆盖了
>>> sqrt(2)
1.4142135623730951
>>> scope['sqrt']
1
>>> scope.keys() # 语句会在scope中添加内容函数的字典
['sqrt', '__builtins__']
```

### eval

```Py
>>> eval(input("Enter an arithmetic expression: ")) # 用于计算字符串表达式的值
Enter an arithmetic expression: 2**3+4*(1+2)
20
>>> a=eval("2+2") # eval是函数，会返回值，而exec是语句，不返回值
>>> a
4
```
