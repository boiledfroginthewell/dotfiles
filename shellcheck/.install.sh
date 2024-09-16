#!/bin/bash
set -eu -o pipefail

cdir="$(cd "$(dirname "$0")" && pwd)"

ln -sf "$cdir/shellcheckrc" "$XDG_CONFIG_HOME/shellcheckrc"

