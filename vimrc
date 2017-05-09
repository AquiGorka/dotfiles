syntax on
colorscheme default
set ts=2 sts=2 sw=2 expandtab
set number

let $LOCALFILE=expand("~/.vimrc.local")
if filereadable($LOCALFILE)
  source $LOCALFILE
endif
