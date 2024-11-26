#!/bin/bash

set -e

NVIM_CONFIG_PATH="$HOME/.config/nvim"
SCRIPT_PATH=$(dirname "$(realpath "$0")")

if [ ! -d $NVIM_CONFIG_PATH ]; then
  echo "Error: $NVIM_CONFIG_PATH does not exist or is not a directory."
  exit 1
fi

create_symlink_nvim_setup() {
  local file_or_dir=$1
  if [ -e "$NVIM_CONFIG_PATH/$file_or_dir" ]; then
    echo "$NVIM_CONFIG_PATH/$file_or_dir already exists."
  else
    ln -sv "$SCRIPT_PATH/nvim-setup/$file_or_dir" "$NVIM_CONFIG_PATH/$file_or_dir"
  fi
}

create_symlink_root_git() {
  local file_or_dir=$1
  if [ -e "$NVIM_CONFIG_PATH/$file_or_dir" ]; then
    echo "$NVIM_CONFIG_PATH/$file_or_dir already exists."
  else
    ln -sv "$SCRIPT_PATH/$file_or_dir" "$NVIM_CONFIG_PATH/$file_or_dir"
  fi
}

create_symlink_nvim_setup "init.vim"
create_symlink_nvim_setup "lua"
create_symlink_root_git ".venv"
create_symlink_root_git "py"

