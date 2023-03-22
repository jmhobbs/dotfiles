#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$__dir/util.sh"

headline_banner "GPG Setup"

printf "✅ Fixing permissions \033[0;34m~/.gnupg\033[0m\n"
# Fix permissions after symlinking
chmod 0700 ~/.gnupg

if [[ "$OSTYPE" == "darwin"* ]]; then
  printf "✅ Disable pinentry keychain storage\n"
  # Write defaults on macOS so pinentry does not cache in keychain
  uname -a | grep Darwin > /dev/null && defaults write org.gpgtools.common "UseKeychain" -bool "false"
fi

# Add the GitHub web flow key
printf "✅ Import GitHub web-flow GPG key\n"
curl -s https://github.com/web-flow.gpg | gpg --import

echo
