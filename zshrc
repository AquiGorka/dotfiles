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
unset ZSH_PLUGINS

plugins=(git sudo zsh-autosuggestions reminder)

# User configuration
PATH=""

# Directories to be prepended to $PATH
declare -a dirs_to_prepend
dirs_to_prepend=(
  "$HOME/bin"
  "/usr/sbin"
  "/usr/bin"
  "/sbin"  
  "/bin"
  "$HOME/.dotfiles/bin"
  "/usr/local/sbin"
  "/usr/local/bin"
)

for dir in ${dirs_to_prepend[@]}
do
  if [ -d ${dir} ]; then
    # If these directories exist, then prepend them to existing PATH
    PATH="${dir}:$PATH"
  fi
done

unset dirs_to_prepend

# go
export GOPATH=$HOME/golang
export GOBIN=$GOPATH/bin
path+=($GOPATH/bin)

if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

# new path
export PATH

# execute
source $ZSH/oh-my-zsh.sh

# alias
alias server='function() { python -m SimpleHTTPServer ${1:-8080} }'
alias mkcd='function() { mkdir $@ && cd $@ }'
alias rmorig='find . -name "*.orig" -delete'
alias cl="clear && clear"
alias csF='clear && sF'
alias lsF='function() { sF "$@" | less }'

# custom prompt
PROMPT="
%{$terminfo[bold]$fg[white]%}λ%{$reset_color%} \
%(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},%{$fg[cyan]%}%n) \
%{$fg[white]%}@ \
%{$fg[green]%}%m \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}%~%{$reset_color%}\
${hg_info}\
${git_info}\
 \
%{$fg[white]%}[%*] $exit_code
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"
