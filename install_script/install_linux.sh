#!/bin/bash

# git
if [ -n "$XDG_CONFIG_HOME" ]; then
	echo "Explicitly  set  XDG_CONFIG_HOME  for  git  since  git  does  not  use  XDG Directories  when  they  are  blank.  The  default  value  of  XDG_CONFIG_HOME  is  ~/.config"
fi

PRJ_ROOT="$(cd $(dirname $0); git rev-parse --show-toplevel)"
CONF_DIR="${XDG_CONFIG_HOME:-$HOME}"

ln -s "${PRJ_ROOT}/bash" "$CONF_DIR/"
ln -s "${PRJ_ROOT}/vim" "$CONF_DIR/"

ln -s $PRJ_ROOT/bash/bashrc ~/.bashrc
ln -s $PRJ_ROOT/vim/vimrc ~/.vimrc
ln -s $PRJ_ROOT/vim/gvimrc ~/.gvimrc
ln -s $PRJ_ROOT/vim ~/.vim

source "${PRJ_ROOT}/install_script/common.sh"

