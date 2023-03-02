#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

printf "\033[1;35m======================\033[0m\n"
printf "\033[1;35mLinking .symlink files\033[0m\n"
printf "\033[1;35m======================\033[0m\n\n"

find "$__dir" -maxdepth 1 -name '*.symlink' -print0 | \
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
printf "\033[1;35m=============================\033[0m\n"
printf "\033[1;35mMerging .mergedir directories\033[0m\n"
printf "\033[1;35m=============================\033[0m\n\n"

find "$__dir" -maxdepth 1 -name '*.mergedir' -print0 | \
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
printf "\033[1;35m===================\033[0m\n"
printf "\033[1;35mInstalling vim-plug\033[0m\n"
printf "\033[1;35m===================\033[0m\n\n"


if [ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ]
then
  curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
