#!/bin/bash
set -euo pipefail

# usage check
if [ $# -lt 1 ] || [ -z "$1" ]; then
  echo "Usage: $0 <hostname>"
  echo "Hostname must be letters, digits, and hyphens, starting with a letter."
  exit 1
fi

NEW_HOSTNAME="$1"

# LocalHostName rules: only [A-Za-z0-9-], must start with a letter
if ! [[ "$NEW_HOSTNAME" =~ ^[A-Za-z][A-Za-z0-9-]*$ ]]; then
  echo "Error: '$NEW_HOSTNAME' is not a valid hostname."
  echo "Use only letters, digits, and hyphens; must start with a letter."
  exit 1
fi

# This script requires sudo privileges. If your daily user is not an admin,
# switch to an admin user first: `su - <admin-user>` then rerun.
if ! sudo -v; then
  echo "Error: $(whoami) cannot run sudo on $(hostname -s)."
  echo "Switch to an admin user (e.g. 'su - <admin-user>') and rerun."
  exit 1
fi

# Set all three hostname variants
sudo scutil --set ComputerName "$NEW_HOSTNAME"
sudo scutil --set LocalHostName "$NEW_HOSTNAME"
sudo scutil --set HostName "$NEW_HOSTNAME"

# Flush DNS cache and refresh Bonjour so other machines see the new .local name
dscacheutil -flushcache
sudo killall mDNSResponder

echo
echo "Done. Hostname set to '$NEW_HOSTNAME'."
