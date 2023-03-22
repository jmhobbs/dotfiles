#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$__dir/util.sh"

if [[ "$OSTYPE" == "darwin"* ]]
then
  install_banner "Homebrew"
  if ! type brew > /dev/null 2>&1
  then
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash --login
  else
    skipping "Already installed"
  fi
fi
echo

install_banner "envsubst"
if ! type envsubst > /dev/null 2>&1
then
  curl -L "https://github.com/a8m/envsubst/releases/download/v1.4.2/envsubst-$(uname -s)-$(uname -m)" -o envsubst
  chmod +x envsubst
  sudo mv envsubst /usr/local/bin
else
  skipping "Already installed"
fi
echo
