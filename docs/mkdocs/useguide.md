## 安装
```
pip install mkdocs
```

## 基本操作

```
mkdocs new my-project #用于在当前文件夹下创建新项目
cd my-project  #进入项目
```
在项目文件夹中可看到`mkdocs.yml`文件和`docs`文件夹,前者用于配置，后者放文档。
进入项目文件夹，执行

```
mkdocs build
mkdocs serve
```
打开`http://127.0.0.1:8000/`可以看到默认主页面。在后续的本地书写中，如果需要即时查看效果，也是用这两个命令。

## 相关配置
### site_name
`site_name: my memos`,配置的是网站名称。

### pages
可以通过以下格式：
```
pages:
- Home: index.md
- Chrome:
  - 实用技巧: chrome/tricks.md
```
一层层创建目录，并将索引和文档匹配。**在每一次更改完文档后，需要在这里设置好对应的索引和文档，切记！**

### theme
`theme: xxx`可以设置主题。
例如，更换为`material`主题可执行：
```
pip install mkdocs-material
```
并配置：
```
theme:
  name: 'material'

markdown_extensions:
  - codehilite
```

如果想更换其他主题，可参考：[mkdoc主题配置文档](https://github.com/mkdocs/mkdocs/wiki/MkDocs-Themes)

## 部署到github
- 在github上新开一个仓库，如`memos`
- 执行：
```
mkdocs gh-deploy
git add .
git commit -m "update master"
git push origin master
```
其中，`gh-deploy`会将当前文档build一下并提交到`gh-pages`分支，后面就是提交主分支的更改了。提交之前在网站上是看不到更改的，要看的话，可以本地执行之前提到的两个命令进行操作。

## 利用makefile进行管理
进行一次提交，需要执行那么多操作，有没有偷懒的方法呢？其实是有的。在项目文件夹下建立一个文件`Makefile`，写入：
```
run:
    mkdocs gh-deploy
    git add .
    git commit -m "update master"
    git push origin master
```
保存后，以后提交就直接`make run`就行了。
