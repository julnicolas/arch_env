set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
try
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
	
	" Syntax check
	Plugin 'vim-syntastic/syntastic'
	
	" Ansible syntax highlignting and file recognition
	Plugin 'pearofducks/ansible-vim'
	
	" File tree
	" Open bar typing :NERDTree .
	Plugin 'scrooloose/nerdtree'
	
	" Custom vim status bar
	"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
	
	" Git icons for NERDTree
	Plugin 'Xuyuanp/nerdtree-git-plugin'
	
	" Simplify vim-pane navigation and make it consistent with tmux
	Plugin 'christoomey/vim-tmux-navigator'

	" Quote/unquote words easily
	" ysiw" to surround a word pointed by cursor in double quotes
	" ysiw' to surround a word pointed by cursor in single quotes
	" yss(  to add surrounding parentheses for the whole line 
	" ds"   to remove double quotes on word pointed by  cursor
	" cs'"  change surrounding ' to " on word pointed by cursor
	Plugin 'tpope/vim-surround'
	
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
	" PLUGIN RELATED CONFIG
	"
	
	" NERDTree settings
	" Open NERDTree automaticaly when starting vim without a file name
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
	
	" Open NERDTree with CTRL N
	map <C-n> :NERDTreeToggle<CR>

	" Enable linting with syntactic
	" Pylint for python (filetype=python)
	" ansible-lint for ansible (filetype=ansible or yaml.ansible)
	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*
	
	let g:syntastic_always_populate_loc_list = 1
	" The command below displays the loc list (list of errors and warnings)
	" let g:syntastic_auto_loc_list = 1
	let g:syntastic_check_on_open = 1
	let g:syntastic_check_on_wq = 0
catch
	" Silently ignore errors
" Always execute plugin-independant config
finally
	"
	" STANDARD CONFIG
	"
	" Force terminal colors to 256
	set t_Co=256
	set encoding=utf-8
	syntax on
	colorscheme koehler
	hi Normal guibg=NONE ctermbg=NONE
	highlight EndOfBuffer ctermfg=black ctermbg=NONE
	set nu
	" vertical split below active buffer by default
	set splitbelow
	
	" Enable function folding
	set foldmethod=indent
	set foldlevel=99
	nnoremap <space> za
	
	" Disable auto-indent and auto comment
	nnoremap <C-i> :setl noai nocin nosi inde=<CR> <bar> :set formatoptions-=cro
	
	" Default tab equals to 4 spaces
	set tabstop=4
	set softtabstop=0
	set shiftwidth=4
	
	" yaml
	au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
	autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
	
	" Ansible-specific config
	au BufRead,BufNewFile */playbooks/*.{yaml,yml} set filetype=yaml.ansible
	au BufRead,BufNewFile */roles/*.{yaml,yml} set filetype=yaml.ansible
	
	" Ruby file config
	"au BufRead,BufNewFile *.rb set expandtab
	
	au BufRead,BufNewFile *.rb
		\ set tabstop=2 |
		\ set shiftwidth=2 |
		\ set expandtab
	
	" Python files' config
	au BufNewFile,BufNewFile *.py
		\ set tabstop=4 |
		\ set shiftwidth=4 |
		\ set textwidth=79 |
		\ set expandtab |
		\ set autoindent |
		\ set fileformat=unix
	
	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" Blank line char
	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	hi NonText ctermfg=232
	
	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" Line number color
	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	highlight LineNr ctermfg=104
	
	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" Highlight current line
	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"set cursorline
	hi CursorLine cterm=bold ctermbg=60 ctermfg=220
	hi CursorLineNR  ctermbg=60 ctermfg=220
	
	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" Split bar
	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	hi VertSplit ctermbg=NONE ctermfg=120
	
	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" Tab bar
	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	hi TabLineFill ctermfg=LightGreen ctermbg=61
	hi TabLine ctermfg=250 ctermbg=61
	hi TabLineSel ctermfg=230 ctermbg=104
	hi Title ctermfg=230
	
	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" Status bar
	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"""""" COLORS
	"black = 232
	"white = 230
	"orange = 202
	"dark orange = 130
	"red = 197
	"dark purple = 61
	"light purple = 104
	"green = 120
	"grey = 250
	""""""
	
	function! InsertStatuslineColor(mode)
	  hi statusline ctermbg=197 ctermfg=230
	endfunction
	
	function! SetCursorLineNrColorVisual()
	  set updatetime=0
	
	  " Visual mode: green
	  hi statusline ctermbg=120 ctermfg=232
	endfunction
	
	function! ResetCursorLineNrColor()
	  set updatetime=1000
	  hi statusline ctermfg=230 ctermbg=61
	endfunction
	
	" Insert mode
	au InsertEnter * call InsertStatuslineColor(v:insertmode)
	au InsertLeave * hi statusline ctermfg=230 ctermbg=61
	
	" Visual mode
	vnoremap <silent> <expr> <SID>SetCursorLineNrColorVisual SetCursorLineNrColorVisual()
	nnoremap <silent> <script> v v<SID>SetCursorLineNrColorVisual
	nnoremap <silent> <script> V V<SID>SetCursorLineNrColorVisual
	nnoremap <silent> <script> <C-v> <C-v><SID>SetCursorLineNrColorVisual
	
	augroup CursorLineNrColorSwap
		autocmd!
		autocmd CursorHold * call ResetCursorLineNrColor()
	augroup END
	
	" default statusline color
	hi statusline ctermfg=230 ctermbg=61
	
	" inactive panes' status-line color
	hi StatusLineNC ctermbg=250 ctermfg=61

	" Do not show edition mode
	set noshowmode
	
	" Formats the statusline
	set laststatus=2							" always enable status bar
	set statusline=%f                           " file name
	set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
	set statusline+=%{&ff}] 					"file format
	set statusline+=%y      					"filetype
	set statusline+=%h      					"help file flag
	set statusline+=%m      					"modified flag
	set statusline+=%r      					"read only flag
	set statusline+=\ %=                        " align left
	set statusline+=\ Col:%c                    " current column
	set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor
endtry
