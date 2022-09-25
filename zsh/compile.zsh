#!/usr/bin/env zsh

while getopts 'a' ARG; do
  case ARG in
  a)
    fullCompile=1
    ;;
  esac
done
shift $(( OPTIND - 1 ))

cd "$(dirname $0)"

# compile zplug
if [ -n "$fullCompile" ]; then
  fd ".zsh$" $ZPLUG_HOME | xargs -I_ sudo zsh -c "zcompile _"
  ls "$ZPLUG_CACHE_DIR/*.zsh" | xargs -I_ zsh -c "zcompile _"
fi

# zshrc
zcompile ~/.zshrc

if [[ $OSTYPE = darwin* ]]; then
  cat rc/* macrc/* > .macrc.zsh
  zcompile .macrc.zsh
else
  cat rc/* > .rc.zsh
  zcompile .rc.zsh
fi

# p10k
ls *.zsh | grep -v compile.zsh | xargs -I_ zsh -c "zcompile _"

# fpath
zcompile fpath fpath/*


