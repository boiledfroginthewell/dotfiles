#!/bin/bash

CONF_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

ln -s $CONF_DIR/bash/bashrc ~/.bashrc
ln -s $CONF_DIR/vim/vimrc ~/.vimrc
ln -s $CONF_DIR/vim/gvimrc ~/.gvimrc
ln -s $CONF_DIR/vim ~/.vim

# git^
if [ -n "$XDG_CONFIG_HOME" ]; then
	echo "Explicitly  set  XDG_CONFIG_HOME  for  git  since  git  does  not  use  XDG Directories  when  they  are  blank.  The  default  value  of  XDG_CONFIG_HOME  is  ~/.config"
fi
