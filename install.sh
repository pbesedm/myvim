#!/bin/bash

ROOTDIR=`pwd`/myvim

git clone --recursive https://github.com/pbesedm/myvim.git

cd $ROOTDIR/vim/bundle/

grep '^Plugin' ../../vimrc |
cut -d' ' -f2 |
sed "s/'//g" |
awk '{header="https://github.com/";addr=$1;git=".git";url=(header""addr""git);print addr,url}' |
while read line;
do
	dir=`echo $line | cut -d' ' -f1 | cut -d'/' -f2`;
	url=`echo $line | cut -d' ' -f2`;
	git clone --recursive $url $dir;
	# Clone may be interrupted by network delay.
	if [[ $? -ne 0 ]]; then
		echo "\e[31;1m Clone $url Failed!\e[0m"
	fi
done

clang_exist=`which clang`
if [[ $clang -eq 0 ]]; then
	cd YouCompleteMe && ./install.py --clang-completer --system-libclang
else
	cd YouCompleteMe && ./install.py --clang-completer
fi

ycm_compile_ret=`echo $?`
if [[ $ycm_compile_ret -ne 0 ]]; then
	echo "\e[31;1m YouCompleteMe compile Failed!\e[0m"
	exit -1
fi

cd $ROOTDIR
ln -s $ROOTDIR/vimrc ~/.vimrc
ln -s $ROOTDIR/vim ~/.vim
