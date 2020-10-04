function pet-select() {
  petResult=$(pet search --color --query "$BUFFER")
  if [ -n "$petResult" ]; then
    BUFFER="$petResult"
    CURSOR=${#BUFFER}
    zle redisplay
  fi
}
zle -N pet-select
bindkey '^p' pet-select

