set nocompatible        "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限

filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle
" required!
"Bundle 'gmarik/vundle'
Plugin 'VundleVim/Vundle.vim'

" 相较于 Command-T 等查找文件的插件，ctrlp.vim 最大的好处在于没有依赖，干净利落
Plugin 'kien/ctrlp.vim'

Plugin 'jiangmiao/auto-pairs'

" 神级插件，ZenCoding 可以让你以一种神奇而无比爽快的感觉写HTML、CSS
"Bundle 'mattn/emmet-vim'
Plugin 'mattn/emmet-vim'

" JS代码格式化插件
Plugin 'maksimr/vim-jsbeautify'

" 用全新的方式在文档中高效的移动光标，革命性的突破
Plugin 'easymotion/vim-easymotion'

" 必不可少，在VIM的编辑窗口树状显示文件目录
Plugin 'scrooloose/nerdtree'

" 快速给代码加注释插件
Plugin 'scrooloose/nerdcommenter'

" 迄今为止最好的自动VIM自动补全插件
Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator', { 'branch': 'stable'}

" 让代码更加易于纵向排版，以=或,符号对齐
Plugin 'godlygeek/tabular'

Plugin 'plasticboy/vim-markdown'

Plugin 'Yggdroot/indentLine'
Plugin 'pangloss/vim-javascript'
"Plugin 'Lokaltog/vim-powerline'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'altercation/vim-colors-solarized'

" Track the engine.
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them
Plugin 'honza/vim-snippets'

" Support golang
Plugin 'fatih/vim-go'

" Switch between source files and header files quckly.
Plugin 'vim-scripts/a.vim'

Plugin 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plugin 'junegunn/fzf.vim'

"Plugin 'jeaye/color_coded'

"Plugin 'jremmen/vim-ripgrep'

call vundle#end()

filetype plugin on		"载入文件类型插件
filetype indent on		"为特定文件类型载入相关缩进文件

set list
set autowrite
set laststatus=2
set encoding=utf-8

" 修改leader键为逗号
let mapleader="'"
imap jj <esc>

" 下面一句最后面一定要留有一个空格
set list listchars=tab:\|\ 
let g:indentLine_char = '|'
let g:indentLine_color_term = 20

" YouCompleteMe 配置
" When this option is set to 1 YCM will ask once per .ycm_extra_conf.py file
" if it is safe to be loaded. This is to prevent execution of malicious code
" from a .ycm_extra_conf.py file you didn't write.
" Default: 1
let g:ycm_confirm_extra_conf = 0
" This option controls the number of characters the user needs to type before
" identifier-based completion suggestion are triggered. For example, if the
" option is set to 2, then when the user types a second alphanumeric charater
" after a whitespace charater, completion suggestions will be triggered. This
" option is NOT used for semantic completion.
" Setting this option to a high number like 99 effectively turns off the
" identifier completion engine and just leaves the semantic engine.
" Default: 2
"let g:ycm_min_num_of_chars_for_completion = 2
" This option controls the minimum number of charaters that a completion
" candidate coming from the identifier completer must have to be shown in the
" popup menu.
" A special value of 0 means there is no limit.
" NOTE: This option only applies to the identifier completer; it has no effect
" on the various semantic completer.
" Default: 0
"let g:ycm_min_num_identifier_candidate_chars = 0
" When set to 0, this option turns off YCM's identifier completer(the
" as-you-type popup) and the semantic triggers(the popup you'd get after typing
" . of -> in say C++). You can still force semantic completion with <C-Space>
" shortcut.
" If you want to just turn off the identifier completer but keep the semantic
" triggers, you should set g:ycm_min_num_of_chars_for_completion to a high
" number like 99.
" Default: 1
"let g:ycm_auto_trigger = 1
" This option controls the key mapping used to invoke the completion menu for
" semantic completion. By defaul, semantic completion is trigged automatically
" after typing ., -> and :: in insert mode (if semantic completion support has
" been compiled in). This key mapping can be used to trigger semantic completion
" anywhere. Useful for searching for top-level functions and classes.
"
" Console Vim (not Gvim or MacVim) passes <Nul> to Vim when the user type
" <C-Space> so YCM will make sure that <Nul> is used in the map command when
" you're editing in console Vim, and <C-Space> in GUI Vim. This means that you
" can just press <C-Space> in both console and GUI Vim and YCM will do the right
" thing.
"
" Setting this option to and empty string will make sure no mapping is created.
" Default: <C-Space>
let g:ycm_key_invoke_completion = '<C-l>'

let g:ycm_use_clangd = 1
let g:ycm_clangd_binary_path = trim(system('brew --prefix llvm')).'/bin/clangd'
let g:ycm_gopls_binary_path='/Users/hdc/Workspace/go/bin'

" vim-powerline
let g:Powerline_symbols = 'fancy'

" airline 配置
set ttimeoutlen=50
let g:airline_theme='badwolf'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Trigger configuration. Do not use <tab>
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want: :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" if you use the https://github.com/Valloric/YouCompleteMe.
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>jc :YcmCompleter GoToCallers<CR>

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" EasyMotion
let g:EasyMotion_leader_key='f'

" kien/rainbow_parentheses
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadChevrons

" -------------------------------------------------------------------------------
set background=dark
syntax enable
hi clear
if version > 580
	if exists("syntax_on")
		syntax reset
	endif
endif
colorscheme desert
"colorscheme molokai
set noeb
set et
set lbr
set sm
set selection=inclusive
set wildmode=longest:full
set wildmenu
highlight Pmenu ctermfg=0 ctermbg=3
highlight PmenuSel ctermfg=0 ctermbg=7
set mousemodel=popup
set showcmd

"set foldenable         "允许折叠
"set foldmethod=manual  "手动折叠

" Go 配置

" 状态行显示的内容
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")} 
" 启动显示状态行(1),总是显示状态行(2)
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set scrolloff=3
set fenc=utf-8
set autoindent
set cindent
set hidden

"tab settings {
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab           "用空格代替制表符
"set noexpandtab         "不要用空格代替制表符
set smarttab            "在行和段开始处使用制表符
"}

set cursorline "设置光标高亮显示
"set cursorcolumn "光标垂直高亮
" 设置当前行高亮
" 注意：没有配置 ctermfg=xxx，这样做可避免当前行内容变成同一个颜色
hi CursorLine cterm=NONE ctermbg=239 guibg=Grey40 guifg=white
hi CursorColumn cterm=NONE ctermbg=239 guibg=Grey40 guifg=white
set textwidth=80
set colorcolumn=+1
hi ColorColumn ctermbg=00 ctermfg=20 guibg=#2c2d27
set ruler

set number          "显示行号
"set undofile        "无限undo

set history=1000

" 相对行号，要想相对行号起作用要放在显示行号后面
"set relativenumber

"自动换行
set wrap

" GUI界面里的字体，默认有抗锯齿
set guifont=Inconsolata:h15

set ignorecase      "设置大小写敏感和智能感知（小写全搜，大写完全匹配）
set smartcase
set incsearch
set showmatch
set hlsearch

set numberwidth=4       "行号栏的宽度

" 记住上次打开位置
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \ exe "normal g`\"" |
     \ endif

" 让退格、空格、上下箭头遇到行首行尾时自动移到下一行(包括insert模式)
set whichwrap=b,s,<,>,[,],h,l 

" 插入模式下移动
inoremap <c-n> <down>
inoremap <c-p> <up>
inoremap <c-f> <right>
inoremap <c-b> <left>

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" 修改vim的正则表达式
nnoremap / /\v
vnoremap / /\v

" 使用tab键来代替%进行匹配跳转
nnoremap <tab> %
vnoremap <tab> %

" 设置当文件被改动时自动载入
set autoread
" quickfix模式
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
" 代码补全
set completeopt=longest,menu

" 在处理未保存或只读文件的时候，弹出确认
set confirm
" 禁止生成临时文件
set nobackup
set noswapfile

set linespace=0
" 使用退格键正常处理indent,eol,start等
set backspace=2

noremap! <C-A> <Home>
inoremap <C-E> <End>

" Doxygen 配置
let g:DoxygenToolkit_briefTag_pre="@brief  "
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag="@return   "
"let g:DoxygenToolkit_blockHeader="----------------------------------------------"
"let g:DoxygenToolkit_blockFooter="----------------------------------------------"
let g:DoxygenToolkit_authorName="Drunkedcat"
let g:DoxygenToolkit_licenseTag="GPL 2.0"
let g:DoxygenToolkit_authorName="hdc, simpleotter23@gmail.com"
let s:licenseTag = "Copyright(C)\<enter>"
let s:licenseTag = s:licenseTag . "For free\<enter>"
let s:licenseTag = s:licenseTag . "All right reserved\<enter>"
let g:DoxygenToolkit_licenseTag = s:licenseTag
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:doxygen_enhanced_color=1
map <C-M>h :DoxAuthor<CR>1.0<CR>
map <C-M>f :Dox<CR>
map <C-M>b :DoxBlock<CR>

"unmap <C-I>

" go
" Uncomment the next few lines to add some shortcuts to make it easier to jump
" between errors in quickfix list
" map <C-n> :cnext<CR>
" map <C-m> :cprevious<CR>
" nnoremap <leader>a :cclose<CR>

" Use these shortcuts to build and run a Go program with <leader>b and <leader>r
"autocmd FileType go nmap <leader>b <Plug>(go-build)
"autocmd FileType go nmap <leader>r <Plug>(go-run)
"autocmd FileType go nmap <leader>t <Plug>(go-test)

" We have many other commands that allows us to call and then collect errors,
" warnings or suggestions.
"
" For example :GoLint. Under the hood it calls golint, which is a command that
" suggests changes to make Go code more idiomatic. There is also :GoVet, which
" calls go vet under the hood. There are many other tools that check certain
" things. To make it easier, someone decided to create a tool that calls all
" these checkers. This tool is called gometalinter. And vim-go supports it via
" the command :GoMetaLinter. So what does it do?
"
" If you just call :GoMetaLinter for a given Go source code. By default it'll
" run go vet, golint and errcheck concurrently. gometalinter collects all the
" outputs and normalizes it to a command format. Thus if you call :GoMetaLinter,
" vim-go show the result of all these checkers inside a quickfix list. You can
" then jump easily between the lint, vet and errcheck results. The setting for
" this default is as following:
"
" let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
"
" There are many other tools and you can easily customize this list yourself. If
" you call :GoMetaLinter it'll automatically uses the list above.
"
" Because :GoMetaLinter is usually fast, vim-go also can call it whenever you
" save a file (just like: :GoFmt). To enable it you need to add the following to
" your .vimrc:
"
" let g:go_metalinter_autosave = 1
"
" What's great is that the checkers for the autosave is different than what you
" would use for :GoMetaLinter. This is great because you can customize it so
" only fast checkers are called when you save your file, but others if you call
" :GoMetaLinter. The following settings let you customize the checkers for the
" autosave feature.
"
" let g:go_metalinter_autosave_enabled = ['vet', 'golint']
"
" As you see by default vet and golint are enabled. Lastly, to prevent
" :GoMetaLinter running for too long, we have a setting to cancel it after a
" given timeout. By default it is 5 seconds but can be changed by the following
" settings:
"
" let g:go_metalinter_deadline = "5s"
"
" Refer [https://github.com/fatih/vim-go-tutorial#check-it]
let g:go_metalinter_autosave = 0
let g:go_metalinter_enabled = ['errcheck']
let g:go_metalinter_autosave_enabled = ['errcheck']


" 标签操作
map <leader>t :tabnew<CR>
imap <leader>t <ESC>:tabnew .<CR>
nnoremap t0 :tabfirst<CR>
nnoremap tl :tabfirst<CR>
nnoremap tp :tabprevious<CR>
nnoremap tn :tabnext<CR>
nnoremap tmh :tabmove -1<CR>
nnoremap tml :tabmove +1<CR>

" rg 搜索
" 注意：Rg 后面有个空格
map <leader>r :Rg 
imap <leader>r :Rg 
