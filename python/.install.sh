#!/usr/bin/env bash

CDIR=$(cd $(dirname $0); pwd)
# ln -s $CDIR/pylintrc ~/.config/pylintrc
ln -s $CDIR/flake8 ~/.flake8

