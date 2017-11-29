set nocompatible

"colorscheme OceanicNext
"colorscheme solarized
"colorscheme zenburn

set backupdir=~/.vim/tmp
set directory=~/.vim/tmp

" Change leader to a comma
let g:mapleader = ","
" Change the terminal's title
set title
" Always show statusline
set laststatus=2
" Set utf-8 encoding on write
set encoding=utf-8
set backspace=indent,eol,start
" Indentation
set tabstop=2
set shiftwidth=2
set softtabstop=2
" Indents <Tab> as spaces
set expandtab
set autoindent
set number
set ai
set si
" Highlight current line
set cursorline
" Enable word wrap
set wrap
" Case insensitive search
set ignorecase
" Smart case search if there is uppercase
set smartcase
set showcmd
" Disable beep and flashing
set vb t_vb=
" Enable listchars
set list
" Show some whitespace chars
set listchars=tab:▸·,trail:·,extends:❯,precedes:❮,nbsp:×
" Highlight matching bracket
set showmatch
" Auto read when a file is changed from the outside
set autoread
" Turn on syntax highlighting
syntax on

" ft to remove tabs
nnoremap ft :silent %s/\t/  /g
" js code formatters
" prettier = gp => get pretty
nnoremap gp :silent %!prettier --stdin --trailing-comma all --single-quote<CR>
" standard = gs => get standard
nnoremap gs :silent %!standard --stdin --fix
" prettify
nmap <leader>p gg=GS
" S for saving
noremap S :update<CR>
" Q for leaving
noremap Q :q<CR>
" Make exiting to normal mode a bit easier
imap <leader><leader> <Esc>
" reload vimrc
nmap <leader>r :source ~/.vimrc<CR>

" plugins
call plug#begin('~/.vim/plugged')
Plug 'ervandew/supertab'
Plug 'fatih/vim-go'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'gabrielelana/vim-markdown'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'

" plugin config
" omnifunc
filetype plugin on
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" lightline
set laststatus=2
set noshowmode
let g:lightline = {
  \ 'colorscheme': 'seoul256',
  \ 'active': {
  \   'left': [ ['mode'], ['filename'] ],
  \   'right': [ ['percent', 'lineinfo'] ]
  \ }
\ }

" nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-t> :NERDTreeToggle<CR>
" Hides "Press ? for help"
let NERDTreeMinimalUI=1
" Shows invisibles
let g:NERDTreeShowHidden=1

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }


" local
let $LOCALFILE=expand("~/.vimrc.local")
if filereadable($LOCALFILE)
  source $LOCALFILE
endif

call plug#end()
