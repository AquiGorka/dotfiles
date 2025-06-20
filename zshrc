# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# oh-my-zsh
if [[ ! -d $ZSH ]]; then
  echo "Installing Oh My Zsh"
  git clone git://github.com/robbyrussell/oh-my-zsh.git $ZSH
fi

# theme
ZSH_THEME="ys"

# plugins
ZSH_PLUGINS=$ZSH/custom/plugins
if [[ ! -d $ZSH_PLUGINS/zsh-autosuggestions ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_PLUGINS/zsh-autosuggestions
fi
unset ZSH_PLUGINS

plugins=(git sudo zsh-autosuggestions fzf pipenv nvm virtualenv genpass httpie timer)

# fix autocompletions if using several users
ZSH_DISABLE_COMPFIX=true

# change node version if .nvmrc is found
# https://stackoverflow.com/questions/73077938/how-to-correctly-setup-plugin-nvm-for-oh-my-zsh
zstyle ':omz:plugins:nvm' autoload yes

# source
source $ZSH/oh-my-zsh.sh

# go
export GOPATH=$HOME/golang
export GOBIN=$GOPATH/bin

# User configuration
path+=(
  "$HOME/dotfiles/bin"
  "$GOBIN"
)

# source local settings
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
if [ -f ~/.zshrc.macos ]; then
  source ~/.zshrc.macos
fi
if [ -f ~/.zshrc.linux ]; then
  source ~/.zshrc.linux
fi

# forgit
# https://github.com/wfxr/forgit
if [[ ! -f ~/forgit/forgit.plugin.sh ]]; then
  echo "Installing forgit"
  git clone https://github.com/wfxr/forgit ~/forgit
fi
source ~/forgit/forgit.plugin.sh

# terminal colors
export TERM=xterm-256color

# alias
# simple python server
alias server='function() { python -m SimpleHTTPServer ${1:-8080} }'
# make dir and cd into it
alias mkcd='function() { mkdir $@ && cd $@ }'
# find and remove .orig files
alias rmorig='find . -name "*.orig" -delete'
# clear, twice for fun and to avoid scroll
alias cl="clear && clear"
# clear and list files
alias cls="clear && clear && ls"
# clear and search function (although I use rg now)
alias csF='clear && sF'
# search with results piped to less
alias lsF='function() { sF "$@" | less }'
# update outdated apps
alias brew-cask-upgrade='brew cask reinstall `brew cask outdated`'
# ip
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
# local ip
alias lip="ipconfig getifaddr en0"
# untar
alias untar='tar -zxvf '
# get checksum
alias sha='shasum -a 256 '
# recent git 3 branches
alias recent='npx git-recent -n 3'
# open repo url
alias repo='npx git-open'
# git rebase
alias gr='git rebase'
# git rebase interactive
alias gri='gr -i'
# git rebase origin/master
alias grm='gr origin/master'
# git fetchus (fetch + status)
alias gf='git fetchus'
# git checkout
alias gc='git checkout'
# git checkout -b
alias gcb='gc -b'
# git push
alias gp='git push'
# git plis
alias gpl='git plis'
# git clog
alias gl='git clog'
# git status
alias gs='git status'
# git diff
alias gd='git diff'
# git add
alias ga='git add'
# git add -p
alias gap='git add -p'
# git commit
alias gm='git commit'
# git commit -m
alias gmm="git commit -m"
# npm i
alias ni="npm i"
# npm start
alias ns="npm start"
# npm i + npm start
alias nis="ni && ns"
# git stash
alias gst="git stash"
# git stash pop
alias gsp="git stash pop"
# see changes for a given commit
function gdf () { git diff $1~ $1 }
# better git blame
function gbb() { git blame -s $1 | awk '{print $1,$3,$4}' | less}
# erase github token
# $ git credential-osxkeychain erase
# host=github.com
# protocol=https
# [Press Return] x2

# genpass
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/genpass
function gpwd() { genpass-xkcd "$@" }

# custom prompt
PROMPT="
%{$(virtualenv_prompt_info)%}\
%{$terminfo[bold]$fg[white]%}λ%{$reset_color%} \
%(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},%{$fg[cyan]%}%n) \
%{$fg[white]%}@ \
%{$fg[green]%}%m \
%{$fg[white]%}in \
%{$fg[yellow]%}%~%{$reset_color%}\
${hg_info}\
${git_info}\
 \
$exit_code
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"

# nvm
export NVM_DIR=~/.nvm
source ~/.nvm/nvm.sh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# vim bindings for terminal
# maybe research: https://github.com/jeffreytse/zsh-vi-mode
bindkey -v
