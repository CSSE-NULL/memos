# 字典

## dict

该函数用于从其他键值对序列或映射创建字典，如：

```Python
>>> items = [('name','bob'),('age',42)]
>>> d = dict(items)
>>> d
{'name': 'bob', 'age': 42}
```

也可以通过关键字参数进行设置：

```Python
>>> d = dict(name='bob',age=12)
>>> d
{'name': 'bob', 'age': 12}
```

## 几个要素

- 键： 必须是不可变类型，如整数，浮点数，元组等。
- 自动添加： 对不存在于字典中的键赋值，就是添加该键值对。
- 成员资格： k in d找的是指定键值是否在字典的键中（并非值）

## format_map

这个函数可以将字典用于字符串格式设置：

```Python
>>> template = '''<html>
... <head><title>{title}</title></head>
... <body>
... <h1>{title}</h1>
... <p>{text}</p>
... </body>'''
>>> data = {"title": "My Home Page", "text": "Welcone to my Homepage"}
>>> print(template.format_map(data))
<html>
<head><title>My Home Page</title></head>
<body>
<h1>My Home Page</h1>
<p>Welcone to my Homepage</p>
</body>
```

## 字典方法

### clear()

``` Python
>>> x = {}
>>> y = x
>>> x['k'] = 'v'
>>> y
{'k': 'v'}
>>> x={}
>>> y # 此处y没有变化，只改变x
{'k': 'v'}

>>> x = {}
>>> y = x
>>> x['k'] = 'v'
>>> y
{'k': 'v'}
>>> x.clear() # 此处将就地清空所有字典项,指向同一位置的变量都会清空
>>> y
{}
```

### copy()

该函数用于进行浅复制（副本只复制了键，但是值仍指向原件，修改副本值等价于修改原件值）：

```Python
>>> x = {'username': 'admin', 'machines': ['foo', 'bar', 'baz']}
>>> y = x.copy()
>>> y['username'] = 'haha'
>>> y['machines'].remove('bar')
>>> y
{'username': 'haha', 'machines': ['foo', 'baz']}
>>> x # 同时被修改
{'username': 'admin', 'machines': ['foo', 'baz']}

# deepcpoy可以将值以及其所包含的值也复制到副本中：
>>> from copy import deepcopy
>>> d = {}
>>> d['names'] = ['Alfred', 'Bertrand']
>>> c = d.copy()
>>> dc = deepcopy(d)
>>> d['names'].append('Clive')
>>> c
{'names': ['Alfred', 'Bertrand', 'Clive']}
>>> dc
{'names': ['Alfred', 'Bertrand']}
```

### fromkeys()

该函数指定键，并创建新字典：

```Python
>>> {}.fromkeys(['name','age']) # 直接通过空字典创建
{'name': None, 'age': None}
>>> dict.fromkeys(['name','age']) # 通过dict
{'name': None, 'age': None}
>>> dict.fromkeys(['name','age'],'unk') # 指定默认值
{'name': 'unk', 'age': 'unk'}
```

### get()

该函数用于更友好地获取值：

```Python
>>> d = {}
>>> d['name'] # 不存在时直接报错
KeyError: 'name'
>>> print(d.get('name')) # 返回None
None
>>> d.get('name','nan') # 自定义返回值
'nan'
>>> d['name']='bob'
>>> d.get('name','nan') # 存在时返回值
'bob'
```

### items()

```Python
>>> d = {'title': 'Python Web Site', 'url': 'http://www.python.org', 'spam': 0}
>>> d.items() # 用元组反应键值对
dict_items([('title', 'Python Web Site'), ('url', 'http://www.python.org'), ('spam', 0)])
>>> it = d.items() # 始终与原字典保持一致，原字典修改后这里也会修改
>>> ('spam',0) in it
True
>>> d['spam'] = 1
>>> ('spam',0) in it
False
>>> d['spam'] = 0
>>> ('spam',0) in it
True
>>> list(d.items()) # 转化为列表
[('title', 'Python Web Site'), ('url', 'http://www.python.org'), ('spam', 0)]
```

### pop()

```Py
>>> d
{'title': 'Python Web Site', 'url': 'http://www.python.org', 'spam': 0}
>>> d.pop('title') # 获取键对应的值并删除该键
'Python Web Site'
>>> d
{'url': 'http://www.python.org', 'spam': 0}
```

### popitem()

```Py
>>> d = {'title': 'Python Web Site', 'url': 'http://www.python.org', 'spam': 0}
>>> d.popitem() # 随机弹出一个值
('spam', 0)
>>> d
{'title': 'Python Web Site', 'url': 'http://www.python.org'}
```

### setdefault()

```Py
>>> d = {}
>>> d.setdefault('name', 'N/A') #类似get,但是增加了如果键不存在则添加默认值的功能
'N/A'
>>> d
{'name': 'N/A'}
>>> d['name'] = 'bob'
>>> d.setdefault('name', 'N/A') # 当键存在时，返回正常值
'bob'
>>> d
{'name': 'bob'}
>>> d = {}
>>> print(d.setdefault('name')) # 默认设置为None
None
>>> d
{'name': None}
```

### update()

```Py
>>> d = {'title': 'Python Web Site', 'url': 'http://www.python.org', 'spam': 0}
>>> x = {'title': 'Python Language Website'}
>>> d.update(x) # 用一个字典(x)更新另一个字典(d)
>>> d
{'title': 'Python Language Website', 'url': 'http://www.python.org', 'spam': 0}
```

### values()

```Py
>>> d
{'title': 'Python Language Website', 'url': 'http://www.python.org', 'spam': 0, 'name': 'Python Language Website'}
>>> d.values() # 返回由值为元素的字典视图。允许包含重复序列，如下：
dict_values(['Python Language Website', 'http://www.python.org', 0, 'Python Language Website'])
```
