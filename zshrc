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
  git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_PLUGINS/zsh-autosuggestions
fi
if [[ ! -d $ZSH_PLUGINS/reminder ]]; then
  git clone https://github.com/AlexisBRENON/oh-my-zsh-reminder $ZSH_PLUGINS/reminder
fi
if [[ ! -d $ZSH_PLUGINS/git-flow-completion ]]; then
  git clone https://github.com/bobthecow/git-flow-completion $ZSH_PLUGINS/git-flow-completion
fi
unset ZSH_PLUGINS

plugins=(git sudo zsh-autosuggestions reminder git-flow-completion)

# User configuration
path+=(
  "$HOME/bin"
  "/usr/sbin"
  "/usr/bin"
  "/sbin"
  "/bin"
  "$HOME/.dotfiles/bin"
  "/usr/local/sbin"
  "/usr/local/bin"
)

# go
export GOPATH=$HOME/golang
export GOBIN=$GOPATH/bin
path+=($GOPATH/bin)

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
