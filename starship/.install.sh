#!/usr/bin/env bash

CDIR=$(cd "$(dirname $0)" && pwd)

ln -sf "$CDIR/starship.toml" ~/.config/starship.toml
