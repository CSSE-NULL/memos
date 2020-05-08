# 再谈抽象

## 面向对象的三大法宝

### 多态

当我们编写一个获取商品价格的函数时，由于无法确定现实中输入的价格表示形式是怎么样（比如可能是元组，字典，列表），那么你可能需要写多次判断来解决这个问题，同时无法对未知情况进行提前预估。我们需要的是一个方法，它可以直接获取对象的价格，而不管其类型如何，这种不关心对象如何实现的编程方式，就是多态。可以看看以下几个例子：

```Py
>>> from random import choice
>>> x = choice(['hello world',[1,2,'e',3,'e',4]]) # choice随机选择一个元素输出
>>> x.count('e') # count方法实现了多态，可以对各种序列和映射进行计数而不关心其类型
1
>>> x = choice(['hello world',[1,2,'e',3,'e',4]])
>>> x.count('e')
2
>>> def len_msg(x):
...     print("The length of", repr(x),'is',len(x)) # repr,len也实现了多态，可以显示不同类型元素的处理
...
>>> len_msg('ssldl')
The length of 'ssldl' is 5
>>> len_msg([1,3,4])
The length of [1, 3, 4] is 3
>>> len_msg({1:2,2:3})
The length of {1: 2, 2: 3} is 2
```

### 封装

```Py
>>> o = OpenObject() # 这是一个未封装类，对象可以修改和获取全局变量
>>> o.set_name('Sir Lancelot')
>>> o.get_name()
'Sir Lancelot'
>>> global_name # 全局变量
'Sir Lancelot'
>>> global_name = 'Sir Gumby'
>>> o.get_name() # 修改全局变量会影响对象的状态，这种方式不是我们想要的，我们需要对象独立
'Sir Gumby
>>> o1 = OpenObject()
>>> o2 = OpenObject()
>>> o1.set_name('Robin Hood')
>>> o2.get_name() # 这里设置第一个对象，同时还影响了第二个对象
'Robin Hood'
>>> c = ClosedObject() # 这是一个封装好的类型
>>> c.set_name('Sir Lancelot')
>>> c.get_name()
'Sir Lancelot
>>> r = ClosedObject()
>>> r.set_name('Sir Robin')
r.get_name()
'Sir Robin'
>>> c.get_name() # 对象c未受影响，各对象独立操作name，这种封装起来的名称叫做属性，属性是归属于对象的变量，对象由封装起来的属性和方法构成
'Sir Lancelot'
```

### 继承

当我们拥有一个基础类，同时需要写一个新的类，这个类只在原来的基础上做出一些个性化改动，此时就可以使用到继承。比如你有个Shape类，可以计算面积，并画出图形。你想实现一个Rectangle类，它计算面积的方法需要个性化修改，但是draw方法可以直接使用Shape类的，这就可以直接对Shape类进行继承。

## 类

```Py
>>> class Person:
...     def set_name(self,name):
...             self.name = name
...     def get_name(self):
...             return self.name
...     def greet(self):
...             print("Hello,world! I'm {}.".format(self.name))
...
>>> foo = Person()
>>> bar = Person()
>>> foo.set_name('steve jobs')
>>> bar.set_name('bill gates')
>>> foo.greet()
Hello,world! I'm steve jobs.
>>> bar.greet()
Hello,world! I'm bill gates.
>>> foo.name # 可以直接获取并修改
'steve jobs'
>>> bar.name = 'Ian Goodfellow'
>>> bar.greet()
Hello,world! I'm Ian Goodfellow.
>>> Person.greet(foo) # foo.greet()相当于将foo传入到类的第一个参数，与这一句等价
Hello,world! I'm steve jobs.
```

### 属性、函数和方法

函数与方法的区别是：方法关联对象，函数不会。

### 再谈隐藏

前面提到的例子里，name属性可以在外部被修改，这样是不安全的。比如，当你执行set_name不仅修改了名字，同时会向管理员发邮件，但是如果直接进行姓名修改，则不会触发这样的操作。为了防止这种情况，Python提供了一种君子协定，在属性或方法前加上`__`就可以让外部无法进行直接访问。比如下面的例子：

```Py
>>> class Sec:
...     def __init__(self):
...             self.__name = "steve" # 这里的name声明为私有变量
...     def __greet_sec(self): # 私有方法
...             print("hello,{}".format(self.__name))
...     def greet(self):
...             self.__greet_sec()
...
>>> foo = Sec()
>>> foo.__name # 无法直接访问
AttributeError: 'Sec' object has no attribute '__name'
>>> foo._Sec__name # 其实Python只是将其换了个名字
'steve'
>>> foo.__greet_sec
AttributeError: 'Sec' object has no attribute '__greet_sec'
>>> foo._Sec__greet_sec
<bound method Sec.__greet_sec of <__main__.Sec object at 0x0000025F51C0C7B8>>
>>> foo.greet() # 可以通过对外开放的接口调用
hello,steve
```

我们还可以声明一个下划线打头的属性和方法，这种外部可以调用，但是不推荐这样做，用import * 的时候也不会被导入。

### 类的命名空间

其实类的定义就是执行声明下的所有代码，这些代码作用在一个特定的命名空间，也就是类的命名空间：

```Py
>>> class Test:
...     print("class Test is defined...") # 类的定义只是执行了内部的代码而已，并不需要一定有def等函数定义。
...
class Test is defined...
```

而对于类的命名空间中全局变量与局部变量的关系如下：

```Py
>>> class Counter:
...     member = 0
...     def init(self):
...             Counter.member += 1 # 对全局变量进行更改
...
>>> m1 = Counter()
>>> m1.init()
>>> Counter.member
1
>>> m2 = Counter()
>>> m2.init()
>>> Counter.member # 仍然作用在全局变量上
2
>>> m1.member = 'two' # 作用于局部变量
>>> m1.member
'two'
>>> m2.member
2
>>> Counter.member
2
```

### 指定超类

```Py
>>> class Filter:
...     def init(self):
...             self.blocked = []
...     def filter(self, sequence):
...             return [x for x in sequence if x not in self.blocked]
...
>>>
>>> class SPAMFilter(Filter): #用圆括号括起来表示继承超类
...     def init(self): # 对init进行改写
...             self.blocked = ['SPAM']
...
>>> f = Filter() # 可以重写为任何过滤器
>>> f.init()
>>> f.filter([1,2,3])
[1, 2, 3]
>>> s = SPAMFilter()
>>> s.init()  # 此处经过重写，使得该类成为特定用途的过滤器
>>> s.filter(['SPAM','SPAM', 'SPAM', 'SPAM', 'eggs', 'bacon', 'SPAM']) # 直接使用超类的filter函数，不用再次编写
['eggs', 'bacon']
```

可以通过如下方式判断继承关系：

```Py
>>> issubclass(SPAMFilter, Filter) # 检测A是否是B的子类
True
>>> issubclass(Filter, SPAMFilter)
False
>>> SPAMFilter.__bases__ # 返回类的超类
(<class '__main__.Filter'>,)
>>> Filter.__bases__
(<class 'object'>,)
>>> s = SPAMFilter()
>>> isinstance(s,SPAMFilter) # 判断a是否是B类的实例
True
>>> isinstance(s,Filter) # s既是SPAMFilter的实例，也是其超类的实例。
True
>>> isinstance(s,list) # 该函数也可以用于判断类型
False
>>> s.__class__
<class '__main__.SPAMFilter'>
>>> type(s)
<class '__main__.SPAMFilter'>
```

### 多个超类

```Py
>>> class Calculator:
...     def calc(self,exp):
...             self.value = eval(exp)
>>> class Talker:
...     def talk(self):
...             print('Hi,my value is',self.value)
...
>>> class TalkCalc(Calculator,Talker): # 这里继承了两个超类，虽然类里面没有任何代码，但是具有两个超类的功能
...     pass
...
>>> tc = TalkCalc()
>>> tc.calc('1+2*3')
>>> tc.talk()
Hi,my value is 7
```

当有多个超类的时候，顺序就很重要了，后面的超类如果与前面的重名，就会被覆盖掉。一般不建议写很多超类。

### 接口

Python不会显示定义接口，但是可以判断对象是否具有某些方法，这些接口针对的就是多态。总体如下：

```Py
>>> hasattr(tc, 'talk') # 判断是否具有某个属性或方法
True
>>> hasattr(tc,'fnord')
False
>>> callable(getattr(tc,'talk',None)) # 获取属性，如果没有则返回None
True
>>> callable(getattr(tc,'fnord',None))
False
>>> setattr(tc,'name','Steve') # 添加属性
>>> tc.name
'Steve'
>>> tc.__dict__ # 查看对象存储的属性
{'value': 7, 'name': 'Steve'}
```

### 抽象基类

多态实现了只要提供特定功能接口，就能对任意对象执行相应的操作，不需要知道对象属于哪一类。封装可以让你不需要知道对象的内部构造，就可以对这个对象进行操作。而继承使得代码能够重复利用。前面提到，如果我们想要知道一个对象是否具有我们想要的功能（比如空调能否制热，制冷，加湿等），需要一个个去检测。有没有一种自动操作的方式呢？这个就需要利用抽象基类了。这就好比如果空调上的按钮没有任何说明，没有任何标记，那么你就只能一个个试，看看有没有相应的效果。但是如果所有功能都一个个标注在上面了，你就只需要看一眼就知道有哪些功能了。一般而言，抽象类不应该实例化，而只是定义一组方法（只需要在各个功能按钮下写上功能名称，而不用单独用新的按钮按下去再显示）。Python提供了abc模块，以下就是其使用方法：

```Py
>>> from abc import ABC,abstractmethod
>>> class Talker(ABC):
...     @abstractmethod # 修饰器，用于声明抽象方法
...     def talk(self):
...             pass
...
>>> Talker() # 抽象类不能实例化
TypeError: Can't instantiate abstract class Talker with abstract methods talk
>>> class Knigget(Talker):
...     pass # 没有重写抽象方法，因此也是抽象类，不能实例化
...
>>> Knigget()
TypeError: Can't instantiate abstract class Knigget with abstract methods talk
>>> class Knigget(Talker):
...     def talk(self):
...             print("Ni")
...
>>> k = Knigget()
>>> k.talk()
Ni
>>> isinstance(k,Talker)
True
>>> class Herring:
...     def talk(self):
...             print("Blub.")
...
>>> h = Herring()
>>> isinstance(h,Talker) # h并没有继承Talker
False
>>> Talker.register(Herring) # 通过register可以使任何Herring类同时都是Talker类，这在当Herring是从其他模块导入，你不能将其从基类派生时很有用。
<class '__main__.Herring'>
>>> isinstance(h,Talker)
True
>>> issubclass(Herring,Talker)
True
>>> class Clam:
...     pass
...
>>> Talker.register(Clam)
<class '__main__.Clam'>
>>> c = Clam() # register的弊端就是，丧失了类的继承机制。只是希望Clam有talk功能，但是事实上它没有
>>> c.talk()
AttributeError: 'Clam' object has no attribute 'talk'
>>> isinstance(c,Talker) # c仍然是Talker的实例，这是通过register实现的
True
```
