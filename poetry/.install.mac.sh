cdir=$(cd $(dirname $0); pwd)

mkdir -p ~/Library/Preferences/pypoetry/
ln -sf "$cdir/config.toml" ~/Library/Preferences/pypoetry/

