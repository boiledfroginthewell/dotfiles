#!/bin/bash
set -eu -o pipefail

cheatDir="$XDG_DATA_HOME/navi/cheats/"
mkdir -p "$cheatDir"

CDIR="$(cd "$(dirname "$0")" && pwd)"
ln -sf "$CDIR/cheats/"* "$cheatDir"

