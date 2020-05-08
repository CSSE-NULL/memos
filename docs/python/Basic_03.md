
# 字符串

## 设置字符串格式

### %方法

这种方法比较经典,与C里面的差不多,通过格式化字符串来进行操作:

```Python
>>> format = "test %s format in %s "
>>> values = ("hello",'the world')
>>> format % values
'test hello format in the world '
```

### Template

这是一种类UNIX Shell的形式.表示如下:

```Python
>>> from string import Template
>>> tmp = Template("hello,$who! $what is good?")
>>> tmp.substitute(who="Guo",what="the weather")
'hello,Guo! the weather is good?'
```

### format

这种方式是集成了以上两种,且十分易操作:

```Python
>>> "{} is {}".format('Tom','good')
'Tom is good'
>>> '{1} {0} {3} {2} {1} {0}'.format('be','to','not','or') # 参数默认下表从0开始递增,因此括号里的索引代表的就是对应的单词
'to be or not to be'
>>> from math import pi
>>> "{name} is approximately {value:.2f}.".format(value=pi,name='π') # 设置名称,以及格式
'π is approximately 3.14.'
>>> "{name} is approximately {value}.".format(value=pi,name='π') # 不设置格式的情况下
'π is approximately 3.141592653589793.'
```

## 高级操作

### 替换字段名

你可以用上文中的占位符来指代变量,也可以通过索引处理,

```Python
>>> "{foo} {} {bar} {}".format(foo=1,bar=2,'is','false') # 关键字参数应该在后面
SyntaxError: positional argument follows keyword argument
>>> "{foo} {} {bar} {}".format('is','false',foo=1,bar=2)
'1 is 2 false'
>>> "{foo} {1} {bar} {0}".format('is','false',foo=1,bar=2) # 用索引指定顺序
'1 false 2 is'
>>> fn = ['guo','hu']
>>> 'Mr {name[1]}'.format(name=fn)
'Mr hu'
>>> import math
>>> tmp = "the {mod.__name__} module defines the value {mod.pi} for π" # 通过模块的属性,点运算符指定
>>> tmp.format(mod=math)
'the math module defines the value 3.141592653589793 for π'
```

### 格式设置

这一部分和其他语言一样,主要包括:对齐,宽度,精度,千位分隔符

```Python
>>> "the name is {num:n}".format(num=0.2222)
'the name is 0.2222'
>>> "the name is {num:%}".format(num=0.2222)
'the name is 22.220000%'
>>> "the name is {num:.2%}".format(num=0.2222) # 百分比表示,小数点保留两位
'the name is 22.22%'
>>> "the name is {num:,}".format(num=222200000000) # 使用千位分隔符
'the name is 222,200,000,000'
>>> "the name is {num:10,.2g}".format(num=2222299999999999.2222) # 顺序为宽度,千位分隔符,小数位数,格式
'the name is    2.2e+15'
>>> "the name is {num:10,.2f}".format(num=2222299999999999.2222)
'the name is 2,222,299,999,999,999.25'
>>> "the name is {num:010,.2f}".format(num=3.14)
'the name is 000,003.14'
>>> "{0:<10.2f}\n{0:^10.2f}\n{0:>10.2f}".format(pi)
'3.14      \n   3.14   \n      3.14'
>>> print("{0:<10.2f}\n{0:^10.2f}\n{0:>10.2f}".format(pi)) #三种对齐方式
3.14
   3.14
      3.14
>>> "{:$^15}".format("WIN BIG") # 设置填充符号
'$$$$WIN BIG$$$$'
>>> '{:010.2f}'.format(pi)
'0000003.14'
>>> print('{0:10.2f}\n{1:=10.2f}'.format(pi, -pi)) # =设置空格放在符号和数字之间
      3.14
-     3.14
>>> print('{0:+10.2f}\n{1:+10.2f}'.format(pi, -pi)) # 默认为-,设置+表示正数前加正号
     +3.14
     -3.14
>>> "{:b}".format(42)
'101010'
>>> "{:#b}".format(42) # 井号用于进制转换
'0b101010'
>>> "{:g}".format(42)
'42'
>>> "{:#g}".format(42) #井号用于强制正数带小数
'42.0000'
```

## 字符串方法

### string模块

虽说Python已经将很多string模块的功能直接集成到字符串上了，但是仍然有一些比较有用的方法：

```Py
>>> import string
>>> string.digits # 包含数字0-9的字符串
'0123456789'
>>> string.ascii_letters # 所有ascii码字母，大小写都有
'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
>>> string.ascii_lowercase # 小写字母
'abcdefghijklmnopqrstuvwxyz'
>>> string.ascii_uppercase # 大写字母
'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
>>> string.printable # 可打印的所有ascii字符
'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~ \t\n\r\x0b\x0c'
>>> string.punctuation # 所有ascii符号
'!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~'
```

### center

```Py
>>> "to be or not to be".center(40) # 用于在字符串左右填充字符（默认空格），使字符串居中
'           to be or not to be           '
>>> "to be or not to be".center(40,'*')
'***********to be or not to be***********'
>>> a = "to be or not to be".center(40,'*')
>>> len(a)
40
```

### find

```Py
>>> quote = "to be or not to be"
>>> quote.find('be') # 找子串是否在字符串中，在则返回子串的第一个索引
3
>>> quote.find('not') 
9
>>> quote.find('no')
9
>>> quote.find('nooo') # 不存在则返回-1
-1
>>> quote.find('be',5) # find可以指定查找范围，这里指定索引下限
16
>>> len(quote)
18
>>> quote.find('to',3,17) # 同时指定上限和下限（不包含）
13
```

### join

```Py
>>> seq = [2,3,4,5,6]
>>> sep = '+'
>>> sep.join(seq) # 用于合并序列元素，仅限于字符串元素
TypeError: sequence item 0: expected str instance, int found
>>> seq = ['1','2','3','4']
>>> sep.join(seq)
'1+2+3+4'
>>> dirs = '', 'usr', 'bin', 'env'
>>> '/'.join(dirs)
'/usr/bin/env'
```

### lower,title,capwords

```Py
>>> "Harry Potter".lower() # 全部改为小写字母
'harry potter'
>>> "haRry potter".title() # 首字母大写，其他小写
'Harry Potter'
>>> from string import capwords
>>> capwords("that's good") # 首字母大写
"That's Good"
>>> "that's good".title() # 首字母大写，但是可能边界单词会出错（比如这里的that's）
"That'S Good"
```

### replace,translate

```Py
>>> "harry potter".replace("harry",'james') # 用第二个字符串代替第一个
'james potter'
>>> table = str.maketrans('ar','bq') # 构建转换表，a->b,b->q
>>> table
{97: 98, 114: 113}
>>> "harry potter".translate(table) # translate用于执行对应的转换
'hbqqy potteq'
>>> table = str.maketrans('ar','bq','t') # 第三个参数可省略，表示去除某些字母
>>> "harry potter".translate(table)
'hbqqy poeq'
>>> table = str.maketrans('ar','bq','tq') # 这里q是转换后才有的，所以不能去除
>>> "harry potter".translate(table)
'hbqqy poeq'
>>> table = str.maketrans('ar','bq','th') # h是转换前就有的，所以转换时会去除
>>> "harry potter".translate(table)
'bqqy poeq'
```

### strip

```Py
>>> '  harry potter   '.strip() # 去除首尾部分的空格
'harry potter'
>>> ' !*# harry * potter ##!  '.strip(' !*#') # 去除首尾部分的指定字符（不包含中间部分）
'harry * potter'
```

### is***

```Py
>>> '23'.isalnum()
True
>>> '23a'.isalnum()
True
>>> '23a#'.isalnum()
False
>>> 'a'.isalpha()
True
>>> '3'.isdecimal()
True
>>> '0100'.isdecimal()
True
>>> '0.222'.isdecimal()
False
>>> 'else'.isidentifier()
True
>>> 'else if'.isidentifier()
False
>>> 'else if'.islower()
True
>>> 'else if'.isnumeric()
False
>>> 'else if'.isprintable()
True
>>> ' '.isspace()
True
>>> 'A Dog'.istitle()
True
>>> 'A Dog'.isupper()
False
```

注: 区分isdigit,isdecimal,isnumeric

```py
num = "1"  #unicode
num.isdigit()   # True
num.isdecimal() # True
num.isnumeric() # True

num = "1" # 全角
num.isdigit()   # True
num.isdecimal() # True
num.isnumeric() # True

num = b"1" # byte
num.isdigit()   # True
num.isdecimal() # AttributeError 'bytes' object has no attribute 'isdecimal'
num.isnumeric() # AttributeError 'bytes' object has no attribute 'isnumeric'

num = "IV" # 罗马数字
num.isdigit()   # True
num.isdecimal() # False
num.isnumeric() # True

num = "四" # 汉字
num.isdigit()   # False
num.isdecimal() # False
num.isnumeric() # True

isdigit()
True: Unicode数字，byte数字（单字节），全角数字（双字节），罗马数字
False: 汉字数字
Error: 无

isdecimal()
True: Unicode数字，，全角数字（双字节）
False: 罗马数字，汉字数字
Error: byte数字（单字节）

isnumeric()
True: Unicode数字，全角数字（双字节），罗马数字，汉字数字
False: 无
Error: byte数字（单字节）
```

