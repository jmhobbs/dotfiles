#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__root="$(cd "$__dir/../" && pwd)"

source "$__dir/util.sh"

headline_banner "Ensuring directories exist"
mkdir -p "$HOME/.local/state/nvim/backup/"
mkdir -p "$HOME/.local/state/nvim/swap/"
echo "✅ vim central backups"
echo

headline_banner "Linking .symlink files"
find "$__root" -maxdepth 1 -name '*.symlink' -print0 | \
  while IFS= read -r -d '' file
  do
    target="$HOME/.$(basename "${file/.symlink//}")"

    if [ -L "$target" ]
    then
      if [ "$(readlink "$target")" == "$file" ]
      then
        printf "✅ Linked  - \033[0;34m%s\033[0m\n" "$target"
      else
        printf "❌ Exists  - \033[0;34m%s\033[0m\n" "$target"
      fi
    else
      if [ -e "$target" ]
      then
        printf "❌ Exists  - \033[0;34m%s\033[0m\n" "$target"
      else
        printf "✅ Linking - \033[0;34m%s\033[0m \033[1;32m⮕ \033[0m \033[1;34m%s\033[0m\n" "$target" "$(basename "$file")"
        ln -s "$file" "$target"
      fi
    fi
  done
echo

headline_banner "Merging .mergedir directories"
find "$__root" -maxdepth 1 -name '*.mergedir' -print0 | \
  while IFS= read -r -d '' dir
  do
    relativeBaseDir="$(basename "$dir")"
    targetBaseDir="$HOME/.${relativeBaseDir/.mergedir//}"

    printf "📁 Merging into %s\n" "$targetBaseDir"

    find "$dir" -type f -print0 | \
      while IFS= read -r -d '' file
      do
        relativePath="${file/$dir\//}"
        target="$targetBaseDir$relativePath"
        targetDir="$(dirname "$target")"

        if [ -L "$target" ]
        then
          if [ "$(readlink "$target")" == "$file" ]
          then
            printf "   ✅ Linked  - \033[0;34m%s\033[0m\n" "$target"
          else
            printf "   ❌ Exists  - \033[0;34m%s\033[0m\n" "$target"
          fi
        else
          if [ -e "$target" ]
          then
            printf "   ❌ Exists  - \033[0;34m%s\033[0m\n" "$target"
          else
            printf "   ✅ Linking - \033[0;34m%s\033[0m \033[1;32m⮕ \033[0m \033[1;34m%s\033[0m\n" "$target" "$relativeBaseDir/$relativePath"
            if [ ! -d "$targetDir" ]
            then
              printf "      💥 \033[1;33mCreating directory %s \033[0m\n" "$targetDir"
              mkdir -p "$targetDir"
            fi
            ln -s "$file" "$target"
          fi
        fi
      done
  done
echo

headline_banner "Installing vim-plug"
if [ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ]
then
  curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  printf "✅ Installed  - \033[0;34m%s\033[0m\n" "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"
  printf "💥 \033[1;33mOpen neovim and run PlugInstall\033[0m\n"
else
  already_installed "vim-plug"
fi
echo

