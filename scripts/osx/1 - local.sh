#!/bin/bash
# local setup for user
# assumes users.sh has been executed
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/AquiGorka/dotfiles/master/scripts/osx/local.sh)"

# wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array
# don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false
# restart dock
killall Dock &> /dev/null

# kitty
git clone https://github.com/connorholyday/nord-kitty ~/.config/kitty/nord-kitty

# vim
  # plugin manager
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  # tmp
  mkdir ~/.vim/tmp
  # install plugins
  vim +PlugInstall +qall
# dotfiles
if [[ ! -d ~/dotfiles ]]; then
  # clone
  git clone https://github.com/AquiGorka/dotfiles ~/dotfiles
  # execute permissions for dotfiles/bin
  chmod +x `find ~/dotfiles/bin -type f`
fi

# symlink
~/dotfiles/symlink

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

# Dock
  # manually set min, max and magnification
  # automatically hide and show the dock
  # show recent applications in dock

# Mission control
  # Dashboard as overlay

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
    # supergenpass: https://chriszarate.github.io/supergenpass/
    # grammarly: https://chrome.google.com/webstore/detail/grammarly-for-chrome/kbfnbcaeplbcioakkpcpgfkobkghlhen/related?hl=en
    # videostream: https://chrome.google.com/webstore/detail/videostream-for-google-ch/cnciopoikihiagdjbjpnocolokfelagl?hl=en
    # whatfont: https://chrome.google.com/webstore/detail/whatfont/jabopobgcpjmedljpbcaablpmlmfcogm/related?hl=en

# shiftit
  # manually check start on login

# karabiner-elements
  # research on adding karabiner.json to dotfiles and symlink
  # in the meantime, manually:
  # caps_lock to control
  # right_command to delete_forward
  # fn to esc

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

# lightshot (install manually)
  # https://itunes.apple.com/us/app/lightshot-screenshot/id526298438

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

