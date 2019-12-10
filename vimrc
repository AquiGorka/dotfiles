" Make Vim more useful
set nocompatible
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp
" Change leader to a comma
let g:mapleader = ","
" Change the terminal's title
set title
" Always show statusline
set laststatus=2
" Set utf-8 encoding on write
set encoding=UTF-8
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
" Blazing fast vim
set ttimeoutlen=0
" Highlight searches
set hlsearch
" Highlight dynamically as pattern is typed
set incsearch
" Optimize for fast terminal connections
set ttyfast

"type R, then type what you're looking for, move right, and type what to replace it with
nmap R :%s///g<LEFT><LEFT><LEFT>
" ft to remove tabs
nnoremap ft :silent %s/\t/  /g
" js code formatters
" prettier = gp => get pretty
nnoremap gp :Prettier<CR>
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
" omnifunc
filetype plugin on
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" highlight long lines
match ErrorMsg '\%>120v.\+'
" highlight trailing whitespace
match ErrorMsg '\s\+$'
" open new files right and below
set splitbelow
set splitright
" tabs
nnoremap <C-l> :tabnew<Space>
inoremap <C-l> <Esc>:tabnew<Space>
" control t + arrows to move
map <C-d><left> :tabp<cr>
map <C-d><right> :tabn<cr>
" space + s => search
noremap <space>s /
" copy selected text to clipboard
vmap <space>c :w !pbcopy<cr><cr>
" duplicate line
noremap <space>d yyp
" find word
noremap <space>f *N
" noh
noremap <space>m :noh<cr>
" replace current word
noremap <space>r :%s/\<<C-r><C-w>\>//g<left><left>

" Plugins
call plug#begin('~/.vim/bundle')

Plug 'itchyny/lightline.vim'
  " lightline
  set laststatus=2
  set noshowmode
  let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \ 'active': {
    \   'left': [ ['mode'], ['filename'], ['gitbranch'] ],
    \   'right': [ ['percent', 'lineinfo'] ]
    \ },
    \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
  \ }

Plug 'scrooloose/nerdtree'
  " nerdtree
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  map <C-t> :NERDTreeToggle<CR>
  " Focus on NERDTree with the currently opened file with M
  noremap <silent> M :NERDTreeFind<CR>
  " hides "Press ? for help"
  let NERDTreeMinimalUI=1
  " shows invisibles
  let g:NERDTreeShowHidden=1
  " hide these files
  let NERDTreeIgnore = ['\.DS_Store$']
  " https://www.reddit.com/r/vim/comments/a4yzyt/g_characters_prefixing_directory_and_file_names/
  let g:NERDTreeNodeDelimiter = "\u00a0"

Plug 'ctrlpvim/ctrlp.vim'
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

Plug 'scrooloose/nerdcommenter'
  " mappings
  " https://github.com/scrooloose/nerdcommenter#default-mappings

Plug 'prettier/vim-prettier'
  " print semicolons
  let g:prettier#config#semi = 'false'
  " print spaces between brackets
  let g:prettier#config#bracket_spacing = 'true'
  " none|es5|all
  let g:prettier#config#trailing_comma = 'all'
  " put > on the last line instead of new line
  let g:prettier#config#jsx_bracket_same_line = 'false'

"Plug 'ervandew/supertab'
Plug 'gabrielelana/vim-markdown'
Plug 'airblade/vim-gitgutter'
Plug 'inside/vim-search-pulse'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'mhartington/oceanic-next'
  let g:colors_name="OceanicNext"
  let g:airline_theme='oceanicnext'

Plug 'arcticicestudio/nord-vim'

" local
let $LOCALFILE=expand("~/.vimrc.local")
if filereadable($LOCALFILE)
  source $LOCALFILE
endif

call plug#end()

"colorscheme OceanicNext
colorscheme nord