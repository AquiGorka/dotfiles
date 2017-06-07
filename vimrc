set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tmhedberg/matchit'
call vundle#end()
filetype plugin indent on

syntax on
colorscheme OceanicNext
"colorscheme solarized

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
