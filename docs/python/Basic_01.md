# Basic 01

## 数学计算

### 整除和取余

Python3中的整除用的是`//`符号，采用的是向下取整，如：

```Py
>>> -10//3
-4
>>> 10//-3
-4
>>> 10//3
3
>>> -10//-3
3
```

这里可以看出，整除可以作用于负数，而`a//b=c`取的是:
b*c1<=a,b*c2>=a里，c1与c2中较小的一个(带符号),这就是所谓的向下取整。
依据`a mod b = a- (a//b *b)`的公式可以推出取余的结果：

```Py
>>> 10%3
1
>>> 10%-3
-2
>>> -10%3
2
>>> -10%-3
-1
```

### 乘方

乘方的优先级比负号(单目求负)的优先级高，因此`-3**2`会出现：

```Py
>>> -3**2
-9
>>> (-3)**2
9
```

### 优先级

运算符 | 描述
----|---
** | 指数 (最高优先级)
~ + - | 按位翻转, 一元加号和减号 (最后两个的方法名为 +@ 和 -@)
* / % // | 乘，除，取模和取整除
+ - | 加法减法
>> << | 右移，左移运算符
& | 位 'AND'
^ \| | 位运算符
<= < > >= | 比较运算符
<> == != | 等于运算符
= %= /= //= -= += = *= | 赋值运算符
is is not | 身份运算符
in not in | 成员运算符
not or and | 逻辑运算符

#### is和==

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;一个对象拥有三个基本元素：id,类型和值。而is是对对象id的判断，==是对对象值的判断。

```py
>>> a=1
>>> b=1
>>> a is b
True
>>> a=1.23
>>> b=1.23
>>> a is b
False
>>> a='test'
>>> b='test'
>>> a is b
True
>>> a=(1,2,3)
>>> b=(1,2,3) 
>>> a is b
False
>>> a=[1,2,3] 
>>> b=[1,2,3] 
>>> a is b
False
>>> a={'a':1,'b':2}
>>> b={'a':1,'b':2}
>>> a is b
False
>>> id(a)
2343361272424
>>> id(b)
2343368258904
```

可以看出,对于整数,字符串类型,is为True,对于浮点数,元组,列表,字典为False.

但是对于整数和字符串是存在特例的，python为了优化速度,使用了一个小整数对象池,只要在[-5,256]之间的整数都是提前建立好的,不会被垃圾回收,因此相应对象的id也相同.

对于字符串,python也有着类似的策略,一些较短的字符串(不包含空格)也是同一个对象.

```py
>>> a=-6
>>> b=-6
>>> a is b
False
>>> a=-5
>>> b=-5
>>> a is b
True
>>> a=256
>>> b=256 
>>> a is b
True
>>> a=257
>>> b=257
>>> a is b
False
>>> a='ab'*10
>>> b='ab'*10
>>> a is b
True
>>> a='a'*1000
>>> b='a'*1000
>>> a is b
True
>>> a='a'*100000
>>> b='a'*100000
>>> a is b
False
>>> a='a b'
>>> b='a b'
>>> a is b
False
```



### 二进制，八进制，十六进制

```Py
>>> 0b10
2
>>> 0o10
8
>>> 0x10
16
```

`0b`,`0o`,`0x`分别代表以上三种进制。

## 变量

名称（ 标识符） 只能由字母、数字和下划线（_）构成，且不能以数字打头。

```Py
>>> $a = 1
SyntaxError: invalid syntax
>>> _a = 1
>>> 9a = 1
SyntaxError: invalid syntax
>>> a9 = 1
```

## 语句

语句和表达式：表达式表示一种东西，而语句表示做一件事。例如：

```Py
>>> 2*2 #表达式
4
>>> x = 2*2 #y赋值语句，执行赋值操作
```

注意：Python3中print为函数，而Python2中为语句，因此前者需要括号传参，后者不用。

## 函数

### 内置函数
Python提供一些标准函数，如`abs,round,pow`等，这种函数称作`内置函数`。

```Py
>>> pow(2,2) #等价于2**2
4
>>> 2//3
0
>>> round(2//3) #该函数就近取整，如果两端一样近（如0.5），那么就取偶数
0
>>> round(7/2)
4
>>> round(5/2)
2
>>> round(5/-2)
-2
>>> abs(-3) #取绝对值
3
```

其中的`round`函数需要注意。如果我们需要强制向下取整，可以使用`floor`，不过这个函数在模块中，无法直接调用。

```Py
>>> floor(3.5)
NameError: name 'floor' is not defined
```

更多内置函数参考:[Python3 Built-in Functions](https://docs.python.org/3/library/functions.html)

### 模块

模块是Python的扩展，也就是说通过导入模块可以增加扩展功能。比如前面的`floor`存在于`math`中，可以通过`import`导入，并通过`module.func`来执行：

```Py
>>> import math
>>> math.floor(-3.5) #向下取整
-4
>>> math.floor(3.5)
3
>>> math.ceil(3.2) #向上取整
4
>>> math.ceil(-3.2)
-3
>>> int(3.5) #这里与上面效果相同，int强制丢掉小数
3
```

注意：还有一些函数如str,float可以进行类似转换，但是它们属于类，不是函数。

如果不考虑重名问题，可以通过直接引用函数来避免每次调用函数都带上模块名。同时，也可以将函数名赋值给变量，从而使变量代替该函数。

```Py
>>> from math import sqrt
>>> sqrt(4)
2.0
>>> ceil(4.3)
NameError: name 'ceil' is not defined
>>> foo = math.ceil
>>> foo(4.3)
5
```

### cmath和复数

当需要使用复数时，可引入`cmath`：

```Py
>>> sqrt(-1)
ValueError: math domain error
>>> import cmath
>>> cmath.sqrt(-1)
1j
>>> (1+2j)*(1-2j)
(5+0j)
```

其中，可发现这里不适合再次使用`from import`语句，因为出现了重名函数`sqrt`。同时，虚数不是单独类型，而是实部为0的复数。

### \_\_future\_\_

这个模块用于导入未来的功能（比如在python2中调用python3的print）

## 字符串

Python字符串用单引号和双引号都一样，只是为了方便内容存在其中一种符号时，可用另一种符号进行限定，但是如果两种符号同时出现，还是需要转义。

### 拼接字符串

Python支持多个字符串并列自动拼接（只限字符串，赋值之后变量无法自动拼接）

```Py
>>> "a" "b"
'ab'
>>> "a" "b" "c"
'abc'
>>> x="a"
>>> y='b'
>>> x y
SyntaxError: invalid syntax
```

更常见的方式是使用`+`号：

```Py
>>> 'hello'+'boy'
'helloboy'
```

### str与repr

字符串包括代码形式(repr)和显示形式（str），可通过两种函数强制转换：

```Py
>>> print(repr('hello\nboy'))
'hello\nboy'
>>> print(str('hello\nboy'))
hello
boy
```

### 原始字符串和长字符串

Python支持长字符串多行输入，可以通过三引号或在末尾加`\`来实现：

```Py
>>> print('''test
... fiz buz
... foo bar
... '''
... )
test
fiz buz
foo bar
>>> 1+2 \
... +3+4 \
... +5+6 \
... +7+8
36
```

当我们不需要转义时，可在字符串前加`r`来处理：

```Py
>>> print(r'c:\test\num')
c:\test\num
>>> print(r'let\'s go') #内容中有与括起来的引号一样的引号时，需要转义，此时斜杠也会在打印内容中出现。
let\'s go
>>> print(r'c:\test\num\') #根据上面内容可知，末尾不能有转义符
SyntaxError: EOL while scanning string literal
```

要解决末尾转义问题，可以通过字符串拼接方式：

```Py
>>> print(r'c:\test\num' '\\')
c:\test\num\
```

### 字符串编码

Python3默认字符串编码为Unicode,实际上是一个`code points`序列，每一个字符都对应一个十六进制数（0-0x10FFFF）。但是如果我们想要把这些内容存储为以bytes为单位（0-255）的值，我们需要进行`encoding`。我们可以通过32位整数来进行表示，但是其实大多数字符（比如字母）都是在ASCII码范围内的，所以这种粗暴的方式会导致内存占用加大，而且受限于机器的架构。更加通用的代替方式是`UTF-8`,代表以8bits为单位的`Unicode Tranformation Format`。这样做的好处是：对于常用的字符（标准ASCII，小于128），可以直接用原数值进行存储。大于128时，通过多个bytes进行变长编码，从而保证了高效性。具体执行如下：

```Py
>>> 'foo bar'.encode('ascii')
b'foo bar'
>>> 'foo bar'.encode('utf-8')
b'foo bar'
>>> 'foo bar'.encode('utf-32')
b'\xff\xfe\x00\x00f\x00\x00\x00o\x00\x00\x00o\x00\x00\x00 \x00\x00\x00b\x00\x00\x00a\x00\x00\x00r\x00\x00\x00'
```

上文可见，编码后其实都转换为了bytes这种不可变的二进制形式。当某些情况必须转换成二进制时，可进行一些设置：

```Py
>>> "Hællå, wørld!".encode("ASCII") #默认参数为strict
UnicodeEncodeError: 'ascii' codec can't encode character '\xe6' in position 1: ordinal not in range(128)
>>> "Hællå, wørld!".encode("ASCII","ignore")
b'Hll, wrld!'
>>> "Hællå, wørld!".encode("ASCII","replace")
b'H?ll?, w?rld!'
>>> "Hællå, wørld!".encode("ASCII","backslashreplace")
b'H\\xe6ll\\xe5, w\\xf8rld!'
>>> "Hællå, wørld!".encode("ASCII","xmlcharrefreplace")
b'H&#230;ll&#229;, w&#248;rld!'
```

从而强制进行相应转换，默认编码是utf-8:

```Py
>>> "Hællå, wørld!".encode("utf-8")
b'H\xc3\xa6ll\xc3\xa5, w\xc3\xb8rld!'
>>> b'H\xc3\xa6ll\xc3\xa5, w\xc3\xb8rld!'.decode()
'Hællå, wørld!'
```

也可以直接创建str和bytes(一定要指定encoding):

```Py
>>> bytes("Hællå, wørld!", encoding="utf-8")
b'H\xc3\xa6ll\xc3\xa5, w\xc3\xb8rld!'
>>> str(b'H\xc3\xa6ll\xc3\xa5, w\xc3\xb8rld!', encoding="utf-8")
'Hællå, wørld!
```

同时，Python还提供了一种可修改字符串`bytearray`（bytes不能改），但是改的时候需要设置对应位置的值在0-255之间，如下：

```Py
>>> x = bytearray(b'heheda') #不要忘记前面的b
>>> x[1]=ord(b'u')
>>> x
bytearray(b'huheda')
```

### 指定代码编码格式

开头写上:

```Py
# -*- coding: encoding name -*-
```

就好。
