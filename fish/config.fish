if status is-interactive
#

# tmp
set -gx SHELL (which fish)


set -px PATH (realpath "$__fish_config_dir/../bin")

alias mkdir="mkdir -p"
alias cp="cp -r"
if [ (uname) = Darwin ]
	alias diff="diff --ignore-space-change"
else
	alias diff="diff --ignore-space-change --ignore-trailing-space"
end
alias rrrr="systemctl restart --user kmonad"
alias pppp="systemctl restart --user kmonad"
type -q hub && alias git hub
alias gg="git graph"
if type -q docker-compose
	alias dc=docker-compose
else if type -q docker
	alias dc="docker compose"
end 
alias ipython="ipython --no-confirm-exit"
alias vi="nvim"
# alias vim="nvim"
set -x EDITOR nvim

abbr --add k kubectl

# less alternative
if type -q bat
	set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
	set -gx MANROFFOPT "-c"
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
bind \et backward-bigword
bind \eh forward-bigword
bind \cj forward-jump
bind \cf backward-jump
bind \cz 'fg; commandline -f repaint'

end

