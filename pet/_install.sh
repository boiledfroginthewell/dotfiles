#!/bin/bash

set -u

PRJ_ROOT=$(git rev-parse --show-toplevel)

rm -rf "$XDG_CONFIG_HOME/pet"
ln -s "$PRJ_ROOT/pet" "$XDG_CONFIG_HOME/"

