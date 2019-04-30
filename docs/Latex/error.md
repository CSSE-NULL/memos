# 错误总结

## 字体

Q: Windows下执行xelatex xxx.tex后出现找不到SimSun等字体。(Cannot find SimSun/OT.mf.)
A: 这里主要是没有找到config路径，在用户环境变量中新建环境变量`FONTCONFIG_FILE`，输入fonts.conf的路径，我这里为：`C:\Users\hq\AppData\Roaming\TinyTeX\texmf-var\fonts\conf\fonts.conf`（用everything搜索下），然后重新打开命令行，输入`fc-list`就能看到系统字体了，问题也得以解决。
