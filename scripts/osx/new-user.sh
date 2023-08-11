#!/bin/bash
# local setup for new user (assumes new-computer.sh has been executed)
# usage:
#   git clone https://github.com/AquiGorka/dotfiles
#   ./dotfiles/scripts/osx/new-user.sh
#   you may have to run this a couple of times? (TODO: figure out why, it seems this script stops after installing omz)

# wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array
# don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false
# restart dock
killall Dock &> /dev/null

# omz
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# kitty
git clone https://github.com/connorholyday/nord-kitty ~/.config/kitty/nord-kitty

# dotfiles
if [[ ! -d ~/dotfiles ]]; then
  # clone
  git clone https://github.com/AquiGorka/dotfiles ~/dotfiles
  # execute permissions for dotfiles/bin
  chmod +x `find ~/dotfiles/bin -type f`
fi

# symlink
~/dotfiles/symlink

# vim
  # plugin manager
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  # tmp
  mkdir ~/.vim/tmp
  # install plugins
  vim +PlugInstall +qall

# Keyboard
  # input sources
    # add spanish iso to keyboard (manually)
    # git clone https://github.com/myshov/xkbswitch-macosx
    # ./xkbswitch-macosx/bin/xkbswitch -se Spanish-ISO

  # shortcuts (Keyboard)
    # move focus to next window (manually in shortcuts > keyboard)
    # https://apple.stackexchange.com/questions/280220/how-to-change-the-default-shortcut-for-move-focus-to-next-window-to-something

# Trackpad
  # tap to click

# Rectangle
  # Update max screen to cmd + enter

# Dock
  # manually set min, max and magnification
  # automatically hide and show the dock
  # show recent applications in dock

# Mission control
  # hot corners remove notes
  # top right notifications

# chrome
  # offer to save passwords: no
  # offer to translate: no
  # disable sync and automatic login
  # https://blog.ideasynthesis.com/2018/09/24/Disable-Google-Chrome-Sign-In-and-Sync/
  # defaults write com.google.Chrome SyncDisabled -bool true
  # defaults write com.google.Chrome RestrictSigninToPattern -string ".*@google.com"

# chrome extensions
  # no way to do this automatically
  # https://blog.chromium.org/2015/05/continuing-to-protect-chrome-users-from.html
  # manually install:
    # jsonview: https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc/related?hl=en
    # momemtum: https://chrome.google.com/webstore/detail/momentum/laookkfknpbbblfpciffpaejjkokdgca
    # grammarly: https://chrome.google.com/webstore/detail/grammarly-for-chrome/kbfnbcaeplbcioakkpcpgfkobkghlhen/related?hl=en
    # videostream: https://chrome.google.com/webstore/detail/videostream-for-google-ch/cnciopoikihiagdjbjpnocolokfelagl?hl=en
    # whatfont: https://chrome.google.com/webstore/detail/whatfont/jabopobgcpjmedljpbcaablpmlmfcogm/related?hl=en

# karabiner-elements
  # research on adding karabiner.json to dotfiles and symlink
  # in the meantime, manually:
  # caps_lock to control
  # right_command to delete_forward

# alfred
  # manually:
  # disable spotlight shortcut search spotlight using spotlight > shortcuts
  # frosty teal theme
  # theme options
    # hide hat
    # hide result shortcuts
    # hide menu bar icon
    # 7 results
    # save position when dragging

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash

# zsh
if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
  # add to list of shells
  sudo sh -c "echo $(which zsh) >> /etc/shells"
  # default
  chsh -s $(which zsh)
  # voilá
  zsh
fi
