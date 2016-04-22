ROOTDIR=`pwd`/myvim

echo -e '\e[31;1mCloning myvim ...\e[0m'
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
    if [ ! -d $dir ]; then
        echo "git clone --recursive $url $dir"
        git clone --recursive $url $dir;
    fi
    if [[ $? -ne 0 ]]; then
        echo -e '\e[31;1m Clone $url Failed!\e[0m'
    fi
done

which clang &> /dev/null
if [[ $? -eq 0 ]]; then
    cd YouCompleteMe && ./install.py --clang-completer --system-libclang
else
    cd YouCompleteMe && ./install.py --clang-completer
fi

if [[ $? -ne 0 ]]; then
    echo -e '\e[31;1m YouCompleteMe compile Failed!\e[0m'
    exit -1
fi

cd $ROOTDIR
ln -s $ROOTDIR/vimrc ~/.vimrc
ln -s $ROOTDIR/vim ~/.vim

echo -e '\e[32;1mInstall myvim Done!\e[0m'
echo -e '\e[32;1mNow run \"sudo pip install --user powerline-status" to support
powerline.\e[0m'
