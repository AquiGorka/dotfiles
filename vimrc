syntax on
colorscheme default

set encoding=utf-8
set ts=2 sts=2 sw=2 expandtab
set number
set ai
set si
se cursorline
se cursorcolumn
set wrap
set ignorecase
set smartcase


let $LOCALFILE=expand("~/.vimrc.local")
if filereadable($LOCALFILE)
  source $LOCALFILE
endif
