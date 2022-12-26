if status is-interactive
#

# tmp
set -gx SHELL (which fish)


set -p PATH (realpath "$__fish_config_dir/../bin")

alias mkdir="mkdir -p"
alias cp="cp -r"
alias info="info --vi-keys"
if [ (uname) = Darwin ]
    alias diff="diff --ignore-space-change"
else
    alias diff="diff --ignore-space-change --ignore-trailing-space"
end
alias rrrr="systemctl restart --user kmonad"
alias pppp="systemctl restart --user kmonad"
type -q hub && alias git hub
alias gg="git graph"
alias dc="docker compose"
alias ipython="ipython --no-confirm-exit"

# less alternative
if type -q bat
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
end
set -gx LESS "--quit-if-one-screen"
alias less=(nvl -c bat lv less)

# ls alternative
type -q exa && alias ls=exa
# time style for `ls -l` command output
set -gx TIME_STYLE long-iso

alias open=(nvl -c exo-open xdg-open start open)

function cursor-kill-bigword
    commandline -f kill-bigword
    commandline -f backward-kill-bigword
end
bind \cw cursor-kill-bigword


end

