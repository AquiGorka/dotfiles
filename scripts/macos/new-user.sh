#!/bin/bash
set -euo pipefail

# wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array
# don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false
# restart dock
killall Dock &> /dev/null

# omz
if [ ! -d ~/.oh-my-zsh ]; then
  echo "- Installing omz"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# kitty theme
if [ ! -d ~/.config/kitty/nord-kitty ]; then
  mkdir -p ~/.config/kitty
  git clone https://github.com/connorholyday/nord-kitty ~/.config/kitty/nord-kitty
fi

# tpm clone (plugin install happens after symlinks since install_plugins reads ~/.tmux.conf)
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# symlink
if [ ! -d ~/dotfiles ]; then
  echo "Error: ~/dotfiles not found. Clone the dotfiles repo first."
  exit 1
fi
ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/zshrc.macos ~/.zshrc.macos
rm -f ~/.tmux.conf
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/gitignore.global ~/.gitignore.global
mkdir -p ~/.vim/tmp
ln -sf ~/dotfiles/vimrc ~/.vimrc
mkdir -p ~/.config/kitty
ln -sf ~/dotfiles/kitty.conf ~/.config/kitty/kitty.conf
# Karabiner-Elements first launch will prompt for Accessibility, driver extension,
# and Login Items & Extensions approval — TCC-gated, must be granted manually.
mkdir -p ~/.config/karabiner
ln -sf ~/dotfiles/karabiner.json ~/.config/karabiner/karabiner.json

# tmux plugins (now that ~/.tmux.conf is symlinked, install_plugins can read it)
~/.tmux/plugins/tpm/bin/install_plugins

# vim
if [ ! -f ~/.vim/autoload/plug.vim ]; then
  # plugin manager
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  # install plugins
  vim +PlugInstall +qall
fi

# nvm
if [ ! -d ~/.nvm ]; then
  echo "- Installing nvm "
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
fi
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
if ! nvm ls node &>/dev/null; then
  nvm install node
fi
nvm use node

# zsh — change login shell to brew zsh (requires user password, not sudo).
# brew zsh is added to /etc/shells by new-computer.sh; without that, chsh fails.
if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
  chsh -s $(which zsh)
  echo "Default shell set to $(which zsh). Open a new terminal to start using it."
fi

# Keyboard input sources — Spanish-ISO (logout/login required to activate)
# NOTE: must use plutil -insert with -json, not `defaults write -array-add` —
# the latter stores `KeyboardLayout ID` as <string> and macOS silently rejects it.
HITOOLBOX_PLIST="$HOME/Library/Preferences/com.apple.HIToolbox.plist"
if ! plutil -extract AppleEnabledInputSources xml1 -o - "$HITOOLBOX_PLIST" 2>/dev/null | grep -q "Spanish - ISO"; then
  # insert at index 0 so it's first in the list (default active source on login)
  plutil -insert AppleEnabledInputSources.0 -json \
    '{"InputSourceKind":"Keyboard Layout","KeyboardLayout ID":173,"KeyboardLayout Name":"Spanish - ISO"}' \
    "$HITOOLBOX_PLIST"
  echo "Added Spanish-ISO keyboard layout (first in list)"
fi
killall cfprefsd 2>/dev/null || true

  # shortcuts (Keyboard) — logout/login required to activate
  # Move focus to next window in active app -> Cmd+< (Spanish-ISO `<>` key, keycode 10)
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 27 \
    '{enabled = 1; value = { parameters = (60, 10, 1048576); type = standard; }; }'

# Trackpad — logout/login required to activate
  # tap to click (built-in + bluetooth + global)
  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Dock
  defaults write com.apple.dock tilesize -int 48
  defaults write com.apple.dock largesize -int 80
  defaults write com.apple.dock magnification -bool true
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock show-recents -bool false
  killall Dock &> /dev/null

# alfred — symlink dotfiles bundle so Alfred uses our shared appearance options
mkdir -p "$HOME/Library/Application Support/Alfred"
rmdir "$HOME/Library/Application Support/Alfred/Alfred.alfredpreferences" 2>/dev/null || true
ln -sf "$HOME/dotfiles/Alfred.alfredpreferences" "$HOME/Library/Application Support/Alfred/Alfred.alfredpreferences"

# Alfred generates its own per-machine localhash on first launch and uses it to find
# local prefs (theme, hotkey). To make all machines share theme/hotkey, we symlink
# this machine's hash subdir to the canonical one (airbag's). The per-machine symlink
# is git-ignored (see Alfred.alfredpreferences/preferences/local/.gitignore).
ALFRED_LOCAL_DIR="$HOME/dotfiles/Alfred.alfredpreferences/preferences/local"
ALFRED_CANONICAL="0eca06f3702aac10f8d5c02e661d23227f905e97"
ALFRED_PREFS_JSON="$HOME/Library/Application Support/Alfred/prefs.json"
ALFRED_HASH=$(plutil -extract localhash raw -o - "$ALFRED_PREFS_JSON" 2>/dev/null || echo "")
if [ -z "$ALFRED_HASH" ]; then
  open -ja "Alfred 5"
  for _ in 1 2 3 4 5 6 7 8 9 10; do
    sleep 1
    ALFRED_HASH=$(plutil -extract localhash raw -o - "$ALFRED_PREFS_JSON" 2>/dev/null || echo "")
    [ -n "$ALFRED_HASH" ] && break
  done
fi
if [ -n "$ALFRED_HASH" ] && [ "$ALFRED_HASH" != "$ALFRED_CANONICAL" ] && [ ! -e "$ALFRED_LOCAL_DIR/$ALFRED_HASH" ]; then
  # Copy (not symlink) so Alfred's writes don't clobber the canonical
  cp -R "$ALFRED_LOCAL_DIR/$ALFRED_CANONICAL" "$ALFRED_LOCAL_DIR/$ALFRED_HASH"
  osascript -e 'tell application "Alfred 5" to quit' 2>/dev/null || true
  sleep 1
  open -ja "Alfred 5"
fi

# remap Spotlight to Ctrl+Opt+Cmd+Space so Alfred can claim Cmd+Space (logout/login required)
# AppleSymbolicHotKeysModified must be true or macOS keeps using built-in defaults alongside our changes
# NOTE: must use plutil -replace with -json — `defaults write -dict-add` stores values
# as strings and macOS rejects hotkey 64 (Spotlight) when types are wrong.
HOTKEYS_PLIST="$HOME/Library/Preferences/com.apple.symbolichotkeys.plist"
plutil -replace AppleSymbolicHotKeys.64 -json \
  '{"enabled":true,"value":{"parameters":[32,49,1835008],"type":"standard"}}' \
  "$HOTKEYS_PLIST"
plutil -replace AppleSymbolicHotKeysModified -bool true "$HOTKEYS_PLIST"

# rectangle — restore prefs from dotfiles plist (gap=6, custom shortcuts, etc.)
# killall cfprefsd to invalidate cache so Rectangle reads the fresh values on first launch
# (otherwise the first-run setup wizard appears despite the imported prefs)
defaults import com.knollsoft.Rectangle ~/dotfiles/Rectangle.plist
killall cfprefsd 2>/dev/null || true
killall Rectangle 2>/dev/null || true
# ensure Rectangle is a login item (belt-and-suspenders; the launchOnLogin pref also
# registers it via SMAppService once Rectangle launches, but this works pre-launch)
if ! osascript -e 'tell application "System Events" to get the name of every login item' | grep -q Rectangle; then
  osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Rectangle.app", hidden:false}' >/dev/null
fi

# firefox — pre-create profile + drop user.js with our preferred about:config settings.
# We can't use enterprise policies.json (modifying the .app bundle breaks codesign on
# macOS Sequoia+) and we can't install configuration profiles via CLI on non-MDM Macs
# (Apple disabled `profiles install` in Big Sur). user.js read on every Firefox launch.
FIREFOX_BASE="$HOME/Library/Application Support/Firefox"
FIREFOX_PROFILE="$FIREFOX_BASE/Profiles/dotfiles.default"
if [ -d /Applications/Firefox.app ]; then
  mkdir -p "$FIREFOX_PROFILE"
  # Firefox 67+ uses dedicated per-installation profiles via [Install<hash>] blocks.
  # The hash 2656FF1E876E9973 is deterministic for /Applications/Firefox.app on macOS.
  # We write both [Profile0] Default=1 (legacy) AND the [Install...] block so Firefox
  # uses our dotfiles profile instead of auto-creating a default-release on first launch.
  cat > "$FIREFOX_BASE/profiles.ini" <<EOF
[Profile0]
Name=dotfiles
IsRelative=1
Path=Profiles/dotfiles.default
Default=1

[General]
StartWithLastProfile=1
Version=2

[Install2656FF1E876E9973]
Default=Profiles/dotfiles.default
Locked=1
EOF
fi
if [ -d "$FIREFOX_PROFILE" ]; then
  cat > "$FIREFOX_PROFILE/user.js" <<'EOF'
// password manager
user_pref("signon.rememberSignons", false);
// telemetry
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
// studies
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);
// don't check default browser
user_pref("browser.shell.checkDefaultBrowser", false);
// suppress "what's new" override page on update
user_pref("browser.startup.homepage_override.mstone", "ignore");
// no Cmd+Q quit confirmation
user_pref("browser.warnOnQuit", false);
user_pref("browser.warnOnQuitShortcut", false);
user_pref("browser.tabs.warnOnClose", false);
EOF
fi

echo
echo "Done. new-user.sh completed successfully."
