set nocompatible

syntax on
colorscheme OceanicNext
"colorscheme solarized

set backupdir=~/.vim/tmp
set directory=~/.vim/tmp

set textwidth=80
set encoding=utf-8
set ts=2 sts=2 sw=2
set backspace=indent,eol,start
set expandtab
set autoindent
set number
set ai
set si
se cursorline
se cursorcolumn
set wrap
set ignorecase
set smartcase
set showcmd
set noshowmode

" plugins
call plug#begin('~/.vim/plugged')
Plug 'ervandew/supertab'
Plug 'fatih/vim-go'
Plug 'itchyny/lightline.vim'

" plugin config
" omnifunc
filetype plugin on
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" lightline
let g:lightline = {
  \ 'colorscheme': 'seoul256',
  \ 'active': {
  \   'left': [ ['mode'], ['filename'] ],
  \   'right': [ ['percent', 'lineinfo'] ]
  \ }
\ }

let $LOCALFILE=expand("~/.vimrc.local")
if filereadable($LOCALFILE)
  source $LOCALFILE
endif

call plug#end()
