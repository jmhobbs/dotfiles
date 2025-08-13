#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__root="$(cd "$__dir/../" && pwd)"

source "$__dir/util.sh"

if [[ "$OSTYPE" == "darwin"* ]]
then
  install_banner "Rosetta"
  softwareupdate --install-rosetta

  install_banner "Brewfile"
  (cd "$__root" && brew bundle --no-upgrade)
  echo

  # Mark librewolf as safe to open
  xattr -c /Applications/LibreWolf.app

  # todo: port to linux?
  install_banner "from asdf"
  for plugin in nodejs golang python
  do
    if asdf plugin list | grep "$plugin" > /dev/null
    then
      already_installed "$plugin"
    else
      printf "✅ Installing \033[0;34m%s\033[0m\n" "$plugin"
      asdf plugin add "$plugin"
      asdf install "$plugin" latest
    fi
  done
  echo
fi

install_banner "Misc"

printf "✅ Installing \033[0;34mgoimports\033[0m\n"
go install golang.org/x/tools/cmd/goimports@latest

printf "✅ Installing \033[0;34mgotestsum\033[0m\n"
go install gotest.tools/gotestsum@latest

printf "✅ Installing \033[0;34mgdlv\033[0m\n"
go install github.com/aarzilli/gdlv@latest

printf "✅ Installing \033[0;34mpynim\033[0m\n"
python3 -m pip install --user --break-system-packages --upgrade pynim

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

if [ -f "$HOME/.lscolors.sh" ];
then
  already_installed "lscolors"
else
  printf "✅ Installing \033[0;34mlscolors\033[0m\n"
  wget -O "$HOME/.lscolors.sh" https://raw.githubusercontent.com/trapd00r/LS_COLORS/eeceec887830e1b30b49b08371ae0d079578a58a/lscolors.sh
fi

mkdir -p "$HOME/.bats/libs"
for lib in support assert file; do
if [ -d "$HOME/.bats/libs/bats-$lib" ]; then
  already_installed "bats-$lib"
else
  printf "✅ Installing \033[0;34mbats-%s\033[0m\n" "$lib"
  git clone "https://github.com/bats-core/bats-$lib.git" "$HOME/.bats/libs/bats-$lib"
fi
done
