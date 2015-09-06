vim
===

手动安装
--------

1. `git clone --recursive git@github.com:pbesedm/vim.git ~/myvim`  
- `ln -s ~/myvim/vim ~/.vim`  
- `ln -s ~/myvim/vimrc ~/.vimrc`  
- `ln -s ~/myvim/ycm_extra_conf.py ~/.ycm_extra_conf.py`
- `ln -s ~/myvim/vim/bundle/vim-colorschemes/colors ~/myvim/vim/bundle/colors`  

2. `cd vim/bundle/vim-snippets/snippets`
- `ln -s css.snippets scss.snippets`

更新
----

在完成上述操作后，打开vim，并执行 :BundleUpdate，更新所有子仓库。

YouCompleteMe 插件的编译和安装
------------------------------

1. 进入 YouCompleteMe 目录  
- git submodule update --init --recursive  
- ./install.py --clang-completer --system-libclang  

YouCompleteMe 配置
------------------

1. `echo | clang -std=c++11 -stdlib=libc++ -v -E -x c++ -`  
	- 获得输出，类似如：/usr/local/include、/usr/bin/../lib/clang/3.2/include  
	- 编辑 ~/.ycm\_extra\_conf.py 文件，参照模板文件修改，一个检验修改是否有效的方式是修改完后，打开一个C文件进行编辑，看是否有补全菜单出现
-  ycm\_extra\_conf.py 模板文件配置说明
	- -I：相当于编译时使用的 -I 参数，即指明 include 的路径
	- -isystem：此参数也是指定 include 的路径，但比 -I 要优先考虑，所以当 -I 指定的头文件依赖其他地方的头文件时，可用该参数，模板的配置主要用于解决STL的解析问题
	- Qt5 相比 Qt4 的模块存在变化，多了 QtWidgets，所以 Qt4 写的程序有时候在 Qt5 环境下无法编译。模板文件中前四行是指定各个模块的路径（实际不只这几个模块，这里只是为了说明问题），但是在模块内部的文件使用类似 #include \<QtCore/\*\.h\> 的格式，如果没有第五句，则解析会失败，所以，这五句能解决两个版本的头文件解析问题
