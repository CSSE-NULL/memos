
# 序列

Python中的容器代表可以包含其他对象的对象。而容器中比较经典的，一种是序列（每个元素都有索引），一种是字典（每个元素都有名称/键值）。

## 两种重要的序列

- 列表 **可修改**

- 元组 **不可修改**

通过两种序列的特性可以看出，列表适用于中途需要修改的情况，而元组适用于限制修改的情况。(比如字典中元组作为键可以，而列表不行)

### 序列操作

#### 索引

序列的索引是从0开始，而且可以从后往前索引（也就是负索引）。同时，Python中字符串其实是以字符为元素的序列（没有字符对应的类型，单字符其实是只有一个元素的字符序列），所以也可以执行相应的序列操作：

```Py
>>> t = 'hello'
>>> t[1]
'e'
>>> 'hello'[-1]
'o'
>>> f  = input('Year: ')[3] #当函数返回值为序列时，可以直接索引
Year: 2018
>>> f
'8'
```

#### 切片

如果需要取一定范围的内容，就需要使用切片功能了。切片功能展示如下：

```Python
>>> numbers = [0,1,2,3,4,5,6,7,8,9]
>>> numbers[0:4] #左边索引包含在结果里，右边不包含
[0, 1, 2, 3]
>>> numbers[0:10]
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
>>> numbers[0:11] #超出范围仍能自动调整
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
>>> numbers[0:] #以上两条可以用这种方式代替
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
>>> numbers[4:]
[4, 5, 6, 7, 8, 9]
>>> numbers[:4] #左边省略默认从左边首位（索引为0）开始
[0, 1, 2, 3]
>>> numbers[:]
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
>>> numbers[0:10:2] #第三位参数为步长
[0, 2, 4, 6, 8]
>>> numbers[10:0:-2]
[9, 7, 5, 3, 1]
>>> numbers[::2]
[0, 2, 4, 6, 8]
>>> numbers[:5:-2]
[9, 7]
```

#### 序列相加

```Python
>>> [1,2,3]+[4,5,6]
[1, 2, 3, 4, 5, 6]
>>> 'hello'+'nerd'
'hellonerd'
>>> [1,2,3]+'nerd'
TypeError: can only concatenate list (not "str") to list
```

一般情况下，两个相同类型序列才能执行拼接。

#### 乘法

序列通过乘法可以多次重复一个序列来拼接成新序列：

```Python
>>> 'python' * 4
'pythonpythonpythonpython'
>>> s = [None]*10
>>> s
[None, None, None, None, None, None, None, None, None, None]
```

#### 成员资格

通过`in`运算符，可以判断一个元素是否在一个序列中，如：

```Python
>>> users = ['hh','hah','dada']
>>> input('input a name:  ') in users
input a name:  hh
True
>>> permissions = 'rw' #常用于权限检测
>>> 'w' in permissions
True
>>> s = 'https://www.ffo.com' #判断是否为网址
>>> 'https://' in s
True
```

其中，最后一个比较特殊，因为一个字符串的元素时其中的每一个字符，所以一开始的`in`只能检测字符是否在字符串中，但是现在也能检测子串是否在字符串中。

#### len, min, max,sum

这三个内置函数中，len返回序列元素个数，min返回最小元素，max返回最大元素,sum对序列求和

```Python
>>> a = [1,4,2,6]
>>> len(a)
4
>>> max(a)
6
>>> min(a)
1
>> sum(a,5) #第二个参数表示从5开始加(默认从0开始)
18
>>> max(1,3,9,2)
9
>>> min(1,3,9,2)
1
>>> len(1,3,9,2)
TypeError: len() takes exactly one argument (4 given)
>>> sum(1,3,9,2) 
TypeError: sum expected at most 2 arguments, got 4
```

其中，min和max可以直接用数字当参数进行操作，但是len,sum的参数必须为序列。

### 列表

#### 函数list

列表最大的特性就是可修改。比如当我们想修改字符串时，可以将其转化成list:

```Python
>>> test = 'hello nerd'
>>> test[1] = 'f'
TypeError: 'str' object does not support item assignment
>>> list(test)
['h', 'e', 'l', 'l', 'o', ' ', 'n', 'e', 'r', 'd']
>>> t = list(test)
>>> t[1] = 'f'
>>> new_str = ''.join(t)
>>> new_str
'hfllo nerd'
```

可见，通过list函数转换成列表后。字符串中的字符可以进行修改，改完之后拼接起来就是我们想要的字符串了。

#### 基本操作

- 修改，删除元素值

```Python
>>> alist = ['red','black','yellow','white','brown']
>>> alist[1]='green'
>>> alist
['red', 'green', 'yellow', 'white', 'brown']
>>> del alist[2]
```

注:按索引删除元素用`del`,`pop`,按值删除用`remove`,清空用`clear`.

- 对切片批量修改值

```Python
>>> alist[1:] = list('gwb')
>>> alist
['red', 'g', 'w', 'b']
>>> alist[1:1] = list('rksdl')
>>> alist
['red', 'r', 'k', 's', 'd', 'l', 'g', 'w', 'b']
>>> alist[0:1] = [] #此处与del相同
>>> alist
['r', 'k', 's', 'd', 'l', 'g', 'w', 'b']
>>> alist[3:-2] = []
>>> alist
['r', 'k', 's', 'w', 'b']
```

#### 列表方法

- append 用于在末尾添加元素。

```Python
>>> alist
['r', 'k', 's', 'w', 'b']
>>> alist.append('test')
>>> alist
['r', 'k', 's', 'w', 'b', 'test']
```

- clear 就地清空

```Python
>>> alist.clear()
>>> alist
[]
```

- copy 创建列表副本

```Python
>>> a = [1,2,3,4]
>>> b = a # 只是关联了另一个名字，没有创建副本，修改b等于修改a
>>> b[1] = 4
>>> a
[1, 4, 3, 4]
>>> a is b
True
>>> a=[7,8,9] #把a指向另一块空间
>>> a is b # 此时a,b分别为不同对象
False
>>> b[1]=2
>>> a # 修改b不影响a
[7, 8, 9]
>>> a = [1,2,3,4]
>>> b = a.copy() # 创建副本，对b操作不影响a
>>> b[1] = 4
>>> a
[1, 2, 3, 4]
>>> b = a[:] # 同copy
>>> b
[1, 2, 3, 4]
>>> b[1] = 4
>>> a
[1, 2, 3, 4]
>>> b = list(a) # 同copy
>>> b[1]=4
>>> a
[1, 2, 3, 4]
>>> a=[1,[2,3],4] 
>>> b=a.copy() # 浅复制
>>> b[1].append(4) 
>>> a
[1, [2, 3, 4], 4]
>>> b
[1, [2, 3, 4], 4]
>>> id(a[1]) 
1305999784008
>>> id(b[1]) #浅复制并没有改变嵌套list的id,a[1]和b[1]指向同一位置
1305999784008
>>> from copy import deepcopy
>>> c=deepcopy(a) 
>>> id(c[1]) # 深度copy之后改变了对象
1305999850952
```

可以看出,python的赋值更像是给数据贴标签,`a=[x,x,x],b=a`使得a,b都贴在了同一块区域,所以修改a等同于修改b.如果我们对a重新赋值,那么a就贴到了其他地方,a和b就互不干扰了.

为了解决赋值带来的同步修改问题,可以采用`a.copy()`操作,这种操作使得两个标签指向了不同副本,但这种浅复制对于复杂序列(如嵌套list)还是没法处理,可以看到嵌套部分的list还是同样的id,指向同一位置.彻底解决该问题可以使用深度复制.

- count 统计列表中元素的个数

```Py
>>> test = ['ab','bc','ab','to','de']
>>> test.count('to')
1
>>> test.count('ab')
2
>>> test = ['ab','bc',['ab'],'to','de'] # ['ab']是列表，与'ab'不同
>>> test.count('ab')
1
```

- extend 将多个元素拼接在末尾

```Py
>>> a = [1,2,3]
>>> b = [4,5,6]
>>> a.extend(b)
>>> a
[1, 2, 3, 4, 5, 6]
>>> a = [1,2,3]
>>> b = [4,5,6]
>>> a+b # 不会对a有任何改变
[1, 2, 3, 4, 5, 6]
>>> a
[1, 2, 3]
>>> a[len(a):]=b # 同extend
>>> a
[1, 2, 3, 4, 5, 6]
```

- index 返回第一个匹配的元素的索引

```Py
>>> test = ['ab','bc','ab','to','de']
>>> test.index('ab') # 第一个在0
0
>>> test.index('too') # 不能索引不存在的元素
ValueError: 'too' is not in list
>>> test.index('to')
3
```

- insert 在指定位置插入元素

```Py
>>> num = [1,2,3,4,6,7]
>>> num.insert(4,'five')
>>> num
[1, 2, 3, 4, 'five', 6, 7]
>>> num = [1,2,3,4,6,7]
>>> num[3:3] = 'five' # 这里视为多个字符组成的序列
>>> num
[1, 2, 3, 'f', 'i', 'v', 'e', 4, 6, 7]
>>> num[3:3] = ['five'] # 同insert
>>> num
[1, 2, 3, 'five', 'f', 'i', 'v', 'e', 4, 6, 7]
>>> num[4:-3] = []
>>> num
[1, 2, 3, 'five', 4, 6, 7]
```

- pop 弹出指定位置的元素，默认为末尾,并返回该元素的值，这是唯一一个既修改序列又返回值的

```Py
>>> x = [1,2,3]
>>> x.pop()
3
>>> x.pop(0)
1
>>> x
[2]
```

- remove 去除指定元素(第一个)，返回None.

```Python
>>> x = ['to','be','or','not','to','be']
>>> x.remove('to') # 只去除了第一个to
>>> x
['be', 'or', 'not', 'to', 'be']
>>> x.remove('too')
ValueError: list.remove(x): x not in list
```

- reverse/reversed 按相反的顺序排列

```Python
>>> x = [1,2,3]
>>> x.reverse() # 直接修改x
>>> x
[3, 2, 1]
>>> reversed(x) # 返回一个迭代器
<list_reverseiterator object at 0x000001F9E8161748>
>>> list(reversed(x)) # 将迭代器转为列表
[1, 2, 3]
```

- sort/sorted 对列表进行排序

```Python
>>> x = [2,8,3,6,4,1,7]
>>> x.sort() # 直接作用于x
>>> x
[1, 2, 3, 4, 6, 7, 8]
>>> x = [2,8,3,6,4,1,7]
>>> y = sorted(x) # 作用于副本
>>> y
[1, 2, 3, 4, 6, 7, 8]
>>> t = list(reversed(sorted(x))) #逆排序
>>> t
[8, 7, 6, 4, 3, 2, 1]
```

sort有两个可选参数：key和reverse. 前者是需要指定一个函数，通过赋予每个元素一个键，然后通过键进行排序。后者只有True和False两个值，代表逆序和正序。

```Python
>>> x = ['Python','Java','Go','C#','C++','C','Ruby','Javascript']
>>> x.sort(key=len) # 按长度排序
>>> x
['C', 'Go', 'C#', 'C++', 'Java', 'Ruby', 'Python', 'Javascript']
>>> x.sort(key=lambda a: 1/len(a))
>>> x
['Javascript', 'Python', 'Java', 'Ruby', 'C++', 'C#', 'Go', 'C']
>>> x = [4,6,2,1,7,9]
>>> x.sort(reverse=True)
>>> x
[9, 7, 6, 4, 2, 1]
>>> x = ['Python','Java','Go','C#','C++','C','Ruby','Javascript']
>>> x.sort()
>>> x
['C', 'C#', 'C++', 'Go', 'Java', 'Javascript', 'Python', 'Ruby']
```

### 元组

元组无法修改，可以进行的操作不多，最重要的创建和索引操作如下：

```Python
>>> 1,2,3
(1, 2, 3)
>>> (1) # 没有逗号就只是数字
1
>>> (1,) # 此时是元组
(1,)
>>> 2*(42,)
(42, 42)
>>> 2*(42)
84
>>> tuple('abc')
('a', 'b', 'c')
>>> tuple(['a','b','c'])
('a', 'b', 'c')
>>> tuple(('a','b','c'))
('a', 'b', 'c')
>>> tuple('a','b','c') # 必须传入序列
TypeError: tuple() takes at most 1 argument (3 given)
>>> x = 1,2,3
>>> x[1]
2
>>> x[0:2]
(1, 2)
```
