set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" Python auto-completion
Bundle 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"
" STANDARD CONFIG
"
set encoding=utf-8
syntax on
colorscheme distinguished

" Enable function folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" Enable go-to-definition
" By default the leader key is mapped to \
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Default tab equals to 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Python files' config
au BufNewFile,BufNewFile *.py
	\ set tabstop=4
	\ set shiftwidth=4
	\ set textwidth=79
	\ set expandtab
	\ set autoindent
	\ set fileformat=unix

"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
	project_base_dir = os.environ['VIRTUAL_ENV']
	activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
	#execfile(activate_this, dict(__file__=activate_this))
	exec(open(activate_this).read(), dict(__file__=activate_this))
EOF

" js, css, html, json, yaml
au BufNewFile,BufRead *.js, *.html, *.css, *.json, *.yaml, *.yml
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2
