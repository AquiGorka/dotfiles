# Ask for the administrator password upfront
sudo -v

# change hostname
scutil --set ComputerName $@
scutil --set LocalHostName $@
scutil --set HostName $@
dscacheutil -flushcache
