function pet-select() {
  petResult=$(pet search --color --query "$BUFFER")
  if [ -n "$petResult" ]; then
    if [ "${petResult:0:1}" = "$" ]; then
      BUFFER="${LBUFFER% } ${petResult} ${RBUFFER# }"
      CURSOR=$(( ${#BUFFER} + 1 + ${#petResult}))
    else
      BUFFER="$petResult"
      CURSOR=${#BUFFER}
    fi
    zle redisplay
  fi
}
zle -N pet-select
bindkey '^p' pet-select

