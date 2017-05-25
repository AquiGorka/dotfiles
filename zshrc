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
PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Directories to be prepended to $PATH
declare -a dirs_to_prepend
dirs_to_prepend=(
  "$HOME/bin"
  "/usr/local/bin"
  "/usr/local/sbin"
  "/usr/bin"
  "/bin"
  "/usr/sbin"
  "/sbin"  
  "$HOME/.dotfiles/bin"
)

for dir in ${dirs_to_prepend[@]}
do
  if [ -d ${dir} ]; then
    # If these directories exist, then prepend them to existing PATH
    PATH="${dir}:$PATH"
  fi
done

unset dirs_to_prepend

if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

# new path
export PATH

# execute
source $ZSH/oh-my-zsh.sh

# alias
alias server='function() { python -m SimpleHTTPServer ${1:-8080} }'
alias csF='clear && sF'
alias lsF='function() { sF $@ | less }'
alias mkcd='function() { mkdir $@ && cd $@ }'
alias rmorig='find . -name "*.orig" -delete'
