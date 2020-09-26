function pet-select() {
  BUFFER=$(pet search --color --query "$READLINE_LINE")
  READLINE_LINE="$BUFFER"
  READLINE_POINT="${#BUFFER}"
}
zle -N pet-select
bindkey '^p' pet-select

