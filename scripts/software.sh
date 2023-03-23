#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__root="$(cd "$__dir/../" && pwd)"

source "$__dir/util.sh"

if [[ "$OSTYPE" == "darwin"* ]]
then
  install_banner "Brewfile"
  (cd "$__root" && brew bundle --no-upgrade --no-lock)
  echo

  # todo: port to linux?
  install_banner "from asdf"
  for plugin in nodejs golang ruby kubectl python
  do
    if asdf plugin list | grep "$plugin" > /dev/null
    then
      already_installed "$plugin"
    else
      printf "✅ Installing \033[0;34m%s\033[0m\n" "$plugin"
      asdf plugin add "$plugin"
      asdf install "$plugin" latest
      asdf global "$plugin" latest
    fi
  done
  echo
fi

install_banner "Misc"

printf "✅ Installing \033[0;34mpynim\033[0m\n"
python3 -m pip install --user --upgrade pynim

if [ -f "$HOME/.fzf.zsh" ]
then
  already_installed "fzf"
else
  printf "✅ Installing \033[0;34mfzf\033[0m\n"
  "$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish
fi

if ! type srv > /dev/null 2>&1
then
  installing "srv"
  go install github.com/jmhobbs/srv@latest
else
  already_installed "srv"
fi
