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
" Mouse clicks
set mouse=i

"type R, then type what you're looking for, move right, and type what to replace it with
nmap R :%s///g<LEFT><LEFT><LEFT>
" ft to remove tabs
nnoremap ft :silent %s/\t/  /g
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
" redo
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
" control + d + arrows to move from tab to tab horizontally
map <C-d><left> :tabp<cr>
map <C-d><right> :tabn<cr>
" control + e + arrows to re-arrange tab hotizontally
map <C-e><left> :tabm -1<cr>
map <C-e><right> :tabm +1<cr>

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
" delete word
imap <SPACE><BS> <C-W>
" disable swap file
set noswapfile
" Buffer jumps
 " previous
 nmap ss<left> :bp<CR>
 " next
 nmap ss<right> :bp<CR>
" open new tab with buffer
 " :tabnew | buffer
 " C-P | buffer
" open current buffer in tab
nmap ss<Space> :tab sball<CR>
" move lines
  " down
  nmap fj :m +1<CR>
  " up
  nmap fk :m -2<CR>
" join lines
" Number of lines + shift + j
" scroll cursor
  " z<CR> puts current line to top of screen
  " z. puts current line to center of screen
  " z- puts current line to bottom of screen
" move split to tab
" <c-w>T
" prepare things for git log (space is there on purpose)
map <leader>l :! git log -p 

" Plugins
call plug#begin('~/.vim/bundle')

Plug 'zivyangll/git-blame.vim'
  " <leader>b shows commit message in status line (you can grab commit hash and see full commit with <leader>l + paste commit hash
  nnoremap <Leader>b :<C-u>call gitblame#echo()<CR>

Plug 'itchyny/lightline.vim'
  " lightline
  set laststatus=2
  " By the way, -- INSERT -- is unnecessary anymore because the mode information is displayed in the statusline.
  set noshowmode
  let g:lightline = {
    \ 'colorscheme': 'nord',
    \ 'active': {
    \   'left': [ ['mode'], ['filename'] ],
    \   'right': [ ['percent', 'lineinfo'] ]
    \ },
  \ }

Plug 'scrooloose/nerdtree'
  " nerdtree
  " Start NERDTree when Vim is started without file arguments.
  " autocmd StdinReadPre * let s:std_in=1
  " autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
  " Exit Vim if NERDTree is the only window remaining in the only tab.
  autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
  " control o to toggle nerd tree
  map <C-o> :NERDTreeToggle<CR>
  " Focus on NERDTree with the currently opened file with M
  noremap <silent> M :NERDTreeFind<CR>
  " hides 'Press ? for help'
  let NERDTreeMinimalUI=1
  " shows invisibles
  let g:NERDTreeShowHidden=1
  " hide these files
  let NERDTreeIgnore = ['\.DS_Store$']
  " https://www.reddit.com/r/vim/comments/a4yzyt/g_characters_prefixing_directory_and_file_names/
  let g:NERDTreeNodeDelimiter = "\u00a0"
  " show on the right
  let g:NERDTreeWinPos = "right"
" Shows Git status flags for files and folders in NERDTree.
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'ctrlpvim/ctrlp.vim'
  " invoke with control p
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'

Plug 'scrooloose/nerdcommenter'
  let g:NERDSpaceDelims = 1
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
  " format and save
  nmap <leader>m :Prettier<CR> :update<CR>

Plug 'airblade/vim-gitgutter'
  " navigate between hunks
  nmap zk <Plug>(GitGutterNextHunk)
  nmap zj <Plug>(GitGutterPrevHunk)

Plug 'ervandew/supertab'
Plug 'gabrielelana/vim-markdown'
Plug 'inside/vim-search-pulse'
Plug 'arcticicestudio/nord-vim'
Plug 'leafgarland/typescript-vim'
Plug 'dense-analysis/ale'
Plug 'pechorin/any-jump.vim'
Plug 'junegunn/fzf'
Plug 'mhinz/vim-startify'

" local
let $LOCALFILE=expand("~/.vimrc.local")
if filereadable($LOCALFILE)
  source $LOCALFILE
endif

call plug#end()

colorscheme nord

" comments
" http://guns.github.io/xterm-color-table.vim/images/xterm-color-table.png
hi Comment ctermfg=147
hi NonText ctermfg=147

" https://www.reddit.com/r/vim/comments/3duumy/changing_markdown_syntax_colors/
function! GetSyntaxID()
    return synID(line('.'), col('.'), 1)
endfunction

function! GetSyntaxParentID()
    return synIDtrans(GetSyntaxID())
endfunction

function! GetSyntax()
    echo synIDattr(GetSyntaxID(), 'name')
    exec "hi ".synIDattr(GetSyntaxParentID(), 'name')
endfunction
