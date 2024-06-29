set -eu -o pipefail

cdir=$(cd $(dirname $0); pwd)

poetryConfigDir="$HOME/Library/Application Support/pypoetry"
mkdir -p "$poetryConfigDir"
ln -sf "$cdir/config.toml" "$poetryConfigDir/"

