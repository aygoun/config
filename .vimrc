set nocompatible
filetype indent plugin on
set list
set listchars=trail:•
set number
syntax on
colorscheme slate

set shiftwidth=4
set softtabstop=4
set expandtab
set laststatus=2
set autoindent
set nostartofline
set ruler
set cursorline
set hidden
set wildmenu
set showcmd
set hlsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
if exists('+colorcolumn')
  set colorcolumn=80
  hi ColorColumn ctermbg=lightgrey guibg=lightgrey
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

map Y y$
