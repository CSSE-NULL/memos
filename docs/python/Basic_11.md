# 文件

## open

这个函数有两个重要参数：文件名（必选）和 模式（可选），模式有w,r,x,a,+,t,b这几种，其中w为写入模式，如果文件存在会删除原有的文件内容再进行写入，想保留原有内容用附加模式a。t代表text,默认就是这种模式，表示作为文本处理，如果碰到音频，视频等二进制文件，可以使用b模式。+代表可读可写，需要和其他条件一起使用，其中r+不会截断，w+会截断（删除文件原有的内容）

### seek and tell

我们可以不用按顺序依次读取，工具就是这两个：

```Py
>>> f = open('test.txt','w')
>>> f.write('0123456789')
10
>>> f.seek(6) # 移动到第六位
6
>>> f.write('hi')
2
>>> f.close()
>>> f = open('test.txt','r')
>>> f.read()
'012345hi89'
>>> f.read(3) # 无法再次读取
''
>>> f.close()
>>> f = open('test.txt','r')
>>> f.read(3)
'012'
>>> f.read(2)
'34'
>>> f.tell() # 返回光标当前位置
5
```

## close

由于Python在文件操作的时候会暂时将文件流存入缓冲区，因此如果一个缓冲没有正常关闭，可能会被覆盖掉。因此，我们需要在文件操作完成后进行close.如果不方便，但是想先把内容存到磁盘中，可以使用flush函数。比较常见的close解决方案有：

```Py
# 在这里打开文件
try:
    # 将数据写入到文件中
finally:
    file.close()

# 这是利用上下文管理器，会自动处理关闭问题
with open("somefile.txt") as somefile:
    do_something(somefile)
```

## 使用文件

- 读取字符：f.read(n)

- 读取（写入）行：f.write(),f.readline()

- 读取写入多行： f.readlines(),f.writelines()

```Py
>>> f = open('test.txt')
>>> f.read()
'012345hi89\ntest'
>>> f.close()
>>> f = open('test.txt')
>>> f.read(1)
'0'
>>> f = open('test.txt')
>>> f.readline()
'012345hi89\n'
>>> f = open('test.txt')
>>> f.readlines()
['012345hi89\n', 'test']
>>> f = open('test.txt')
>>> lines = f.readlines()
>>> lines[1] = 'hello'
>>> f = open('test.txt','w')
>>> f.writelines(lines)
>>> f.flush()
>>> lines
['012345hi89\n', 'hello']
>>> f.close()
```

## 迭代文件

```Py
# 迭代字符
with open(filename) as f:
    while True:
        char = f.read(1)
    if not char: break
    process(char)

# 迭代行
with open(filename) as f:
    while True:
        line = f.readline()
        if not line: break
        process(line)

# 迭代所有
with open(filename) as f:
    for char in f.read():
        process(char)

with open(filename) as f:
    for line in f.readlines():
        process(line)

# 使用fileinput延迟迭代
import fileinput
for line in fileinput.input(filename):
    process(line)

# 直接迭代文件
with open(filename) as f:
    for line in f:
        process(line)

for line in open(filename):
    process(line)

# 将文件流当作迭代器
>>> f = open('somefile.txt', 'w')
>>> print('First', 'line', file=f)
>>> print('Sec', 'line', file=f)
>>> print('Third', 'and final', 'line', file=f)
>>> f.close()
>>> lines = open('somefile.txt')
>>> list(lines)
['First line\n', 'Sec line\n', 'Third and final line\n']
>>> first, second, third = open('somefile.txt')
>>> first
'First line\n'
>>> third
'Third and final line\n'
```
