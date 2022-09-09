#!/usr/bin/env bash

CDIR=$(cd $(dirname $0); pwd)

winTermConfDir="$LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe"

mklink "$winTermConfDir/LocalState" "$CDIR"

