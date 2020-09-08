#!/bin/bash

CDIR="$(cd $(dirname $0); pwd)"

ln -sf "$CDIR"/user-dirs.* "$XDG_CONFIG_HOME/"

