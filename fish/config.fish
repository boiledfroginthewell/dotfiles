if status is-interactive
#

set -p PATH (realpath "$__fish_config_dir/../bin")

alias mkdir="mkdir -p"
alias cp="cp -r"
alias info="info --vi-keys"
alias diff="diff --ignore-space-change --ignore-trailing-space"
alias rrrr="systemctl restart --user kmonad"
alias pppp="systemctl restart --user kmonad"
type -q hub && alias git hub
alias gg="git graph"
alias dc=docker-compose
alias ipython="ipython --no-confirm-exit"

# less alternative
if type -q bat
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
    set -gx BAT_STYLE "changes,header,grid,numbers"
end
if type -q bat
    alias less=bat
else if type -q lv
    alias less=lv
end
set -gx LESS "--quit-if-one-screen"

# ls alternative
type -q exa && alias ls=exa
# time style for `ls -l` command output
set -gx TIME_STYLE long-iso

# open
if type -q exo-open
    alias open exo-open
else if type -q xdg-open
    alias open xdg-open
else if start
    alias open start
end


end

