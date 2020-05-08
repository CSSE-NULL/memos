# 异常

异常就是某些类的实例，比如ZeroDivisionError。我们可以通过某些条件触发和捕获这些实例。

## 指定异常

### raise

可以通过raise主动抛出异常：

```Py
>>> raise Exception
Exception
>>> raise Exception('test')
Exception: test
>>> raise OSError
OSError
```

### 自定义异常类

我们有时候需要根据异常的类型进行不同的处理，这时候如果有我们自己定义的异常，最好自定义一个异常类，而不是直接用Exception输出信息。方式很简单，就是要直接或间接继承Exception类：

```Py
>>> class MyError(Exception): pass
```

## 捕获异常

```Py
>>> x = int(input("enter x: "))
enter x: 2
>>> y = int(input("enter y: "))
enter y: 0
>>> print(x/y)
ZeroDivisionError: division by zero

# 改写为以下内容捕获异常(try/except)：
try:
    x = int(input('Enter the first number: '))
    y = int(input('Enter the second number: '))
    print(x / y)
except ZeroDivisionError:
    print("The second number can't be zero!")
```

### 无参raise

捕获到一个异常后，你觉得无法处理，可以直接调用raise,不带任何参数，此时函数会将异常送到调用该函数的地方去处理。例如一个带异常消除的计算器：
```Py
>>> class MuffledCalculator:
...     muffled = False
...     def calc(self, expr):
...             try:
...                     return eval(expr)
...             except ZeroDivisionError:
...                     if self.muffled:
...                             print('Division by zero is illegal')
...                     else:
...                             raise
...
>>> c = MuffledCalculator()
>>> c.calc('10/2')
5.0
>>> c.calc('10/0')
ZeroDivisionError: division by zero
>>> MuffledCalculator.muffled = True # 启动隐藏异常功能
>>> c.calc('10/0')
Division by zero is illegal
```

如果你不是想返回当前异常而是返回另外一个异常，不要直接使用raise xxx(指代另一个异常)，这样的话原异常就会变成上下文出现在异常文本中，比较好的方式是使用rasie ... from ...语句来提供自己的上下文，或者直接from None 禁用上下文：

```Py
>>> try:
...     1/0
... except ZeroDivisionError:
...     raise ValueError
...
Traceback (most recent call last):
  File "<stdin>", line 2, in <module>
ZeroDivisionError: division by zero

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "<stdin>", line 4, in <module>
ValueError
>>> try:
...     1/0
... except ZeroDivisionError:
...     raise ValueError from None
...
Traceback (most recent call last):
  File "<stdin>", line 4, in <module>
ValueError
```

### 多个异常处理

```Py
# 多个except
try:
    x = int(input('Enter the first number: '))
    y = int(input('Enter the second number: '))
    print(x / y)
except ZeroDivisionError:
    print("The second number can't be zero!")
except TypeError: # 可以捕获·多个异常
    print("That wasn't a number, was it?")

# 用异常元组（一定要加括号，否则可能会出现你不希望的结果）
try:
    x = int(input('Enter the first number: '))
    y = int(input('Enter the second number: '))
    print(x / y)
except (ZeroDivisionError, TypeError, NameError):
    print('Your numbers were bogus ...')
```

### 捕获对象

```Py
try:
    x = int(input('Enter the first number: '))
    y = int(input('Enter the second number: '))
print(x / y)
    except (ZeroDivisionError, TypeError) as e: # 这里的e表示异常对象而不是异常类
print(e)
```

### 一网打尽

```Py
>>> try:
...     input("input sth: ")
... except: # 直接对所有异常统一处理，这样做的弊端是，可能让系统忽略一些重要的异常比如KeyboardInterrupt(按下Ctrl+C终止)，sys.exit()产生的异常等。更好的办法是使用except Exception as e,因为上面提到的系统级别的异常都是继承自BaseException，这是Exception的超类。
...     print("whatever you input with eroor will show this")
...
input sth: whatever you input with eroor will show this
>>> # 以下是使用except Exception as e这种方式捕获异常对象
>>> try:
...     input("test: ")
... except Exception as e:
...     print('hha')
...
test: Traceback (most recent call last):
  File "<stdin>", line 2, in <module>
KeyboardInterrupt
```

### else,finally

```Py
>>> while True:
...     try:
...             x = int(input('Enter the first number: '))
...             y = int(input('Enter the second number: '))
...             value = x/y
...             print('x/y is ',value)
...     except:
...             print('Invalid input,PLease try again.')
...     else: # 在没有异常发生时执行
...             break
...
Enter the first number: 1
Enter the second number: 0
Invalid input,PLease try again.
Enter the first number: 1
Enter the second number: hah
Invalid input,PLease try again.
Enter the first number: 2
Enter the second number: sd
Invalid input,PLease try again.
Enter the first number: Invalid input,PLease try again.
Enter the first number: Invalid input,PLease try again. # 这里是按了Ctrl+C，但是因为except捕获了KeyboardInterrupt无法跳出
Enter the first number: 1
Enter the second number: 2 # 只有输入正确形式才能退出
x/y is  0.5

# 以下是改良版
>>> while True:
...     try:
...             x = int(input('Enter the first number: '))
...             y = int(input('Enter the second number: '))
...             value = x/y
...             print('x/y is ',value)
...     except Exception as e: # 这里不会捕获Ctrl+C产生的异常，并且对象e可以用于打印，从而获取异常的详细信息
...             print('Invalid input: ',e)
...             print('Please try again')
...     else:
...             break
...
Enter the first number: 1
Enter the second number: 0
Invalid input:  division by zero
Please try again
Enter the first number: 1
Enter the second number: hello
Invalid input:  invalid literal for int() with base 10: 'hello'
Please try again
Enter the first number: qqqq
Invalid input:  invalid literal for int() with base 10: 'qqqq'
Please try again
Enter the first number: hi
Invalid input:  invalid literal for int() with base 10: 'hi'
Please try again
Enter the first number: Traceback (most recent call last):
  File "<stdin>", line 3, in <module>
KeyboardInterrupt
```

```Py
>>> x = None
>>> try:
...     x = 1/ 0
... finally: # finally下的语句是无论有无异常都会执行的
...     print('Cleaning up ...')
...     del x
...
Cleaning up ...
ZeroDivisionError: division by zero

# 同时使用四种语句
>>> try:
...     1/0
... except NameError:
...     print("Unknown variable")
... else:
...     print('That went well.')
... finally:
...     print("Cleaning up")
...
Cleaning up
ZeroDivisionError: division by zero

>>> try:
...     1/1
... except NameError:
...     print("Unknown variable")
... else:
...     print('That went well.')
... finally: # 无异常也会执行
...     print("Cleaning up")
...
1.0
That went well.
Cleaning up
```

## 异常之禅

异常包含的思想就是，先做，错了再处理，而不是先考虑周到再做。比如下面这个能根据有无职位这一项来打印个人信息的功能函数：

```Py
# 使用条件语句
def describe_person(person):
    print('Description of', person['name'])
    print('Age:', person['age'])
    if 'occupation' in person: # 这里需要查找两次key
        print('Occupation:', person['occupation'])

# 使用异常
def describe_person(person):
    print('Description of', person['name'])
    print('Age:', person['age'])
    try:
        print('Occupation:', person['occupation']) # 这里只用查找一次，而且不用关心存不存在这个键
    except KeyError: pass
```

## 警告

```Py
>>> from warnings import warn
>>> warn('not good')
__main__:1: UserWarning: not good
>>> warn('not good') # 同一个警告只显示一次
>>> from warnings import filterwarnings # 其他代码调用你的模块时，你可以用这个函数对警告进行限制
>>> filterwarnings('ignore') # 直接忽略
>>> warn('Are you ok?')
>>> filterwarnings('error') # 变为异常抛出
>>> warn('Are you ok?')
UserWarning: Are you ok?
>>> warn("r u ok?",MyWarning)
NameError: name 'MyWarning' is not defined
>>> warn("r u ok?",DeprecationWarning) # 自定义警告类型
DeprecationWarning: r u ok?
>>> filterwarnings('ignore',category=DeprecationWarning) # 按类型忽略
>>> warn("hello",DeprecationWarning)
>>> warn('sth else')
UserWarning: sth else
```