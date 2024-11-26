#!/bin/bash

set -e

SCRIPT_PATH=$(dirname "$(realpath "$0")")

if [ ! -d ~/.config/nvim ]; then
  echo "Error: ~/.config/nvim does not exist or is not a directory."
  exit 1
fi

if [ ! -e ~/.config/nvim/init.vim  ]; then
  ln -sv "$SCRIPT_PATH/nvim-setup/init.vim" ~/.config/nvim/init.vim
else
  echo "~/.config/nvim/init.vim already exists."
fi

if [ -e ~/.config/nvim/lua  ]; then
  echo "~/.config/nvim/lua already exists."
else
  ln -sv "$SCRIPT_PATH/nvim-setup/lua" ~/.config/nvim/lua
fi

