# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# tmux fix nvm
# https://superuser.com/questions/544989/does-tmux-sort-the-path-variable/583502#583502
if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

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

plugins=(git sudo zsh-autosuggestions fzf)

# User configuration
path=(
  "$HOME/.dotfiles/bin"
  "/opt/homebrew/bin"
  "/opt/homebrew/sbin"
  "$HOME/bin"
  "/sbin"
  "/bin"
  "/usr/sbin"
  "/usr/bin"
  "/usr/local/sbin"
  "/usr/local/bin"
)

# go
export GOPATH=$HOME/golang
export GOBIN=$GOPATH/bin
path+=($GOPATH/bin)

# fix autocompletions if using several users
ZSH_DISABLE_COMPFIX=true

# source local settings
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

# source
source $ZSH/oh-my-zsh.sh

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
alias open='npx git-open'
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

# custom prompt
PROMPT="
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

# use homebrew vim instead of macos
alias vi=/opt/homebrew/bin/vim
alias vim=/opt/homebrew/bin/vim

# automatically set nvm version if .nvmrc
# https://github.com/nvm-sh/nvm#zsh
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
