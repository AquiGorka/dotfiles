set nocompatible

syntax on
colorscheme OceanicNext
"colorscheme solarized

set backupdir=~/.vim/tmp
set directory=~/.vim/tmp

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

let $LOCALFILE=expand("~/.vimrc.local")
if filereadable($LOCALFILE)
  source $LOCALFILE
endif
