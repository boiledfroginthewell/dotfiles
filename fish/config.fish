if not status is-interactive; return; end

set -gx SHELL (which fish)

fish_add_path --prepend /usr/local/bin
fish_add_path --prepend (realpath "$__fish_config_dir/../bin")

alias mkdir="mkdir -p"
alias cp="cp -r"
if [ (uname) = Darwin ]
	alias diff="diff --ignore-space-change"
else
	alias diff="diff --ignore-space-change --ignore-trailing-space"
end
alias pgrep="pgrep -afl"
alias rrrr="systemctl restart --user xremap"
alias pppp="systemctl restart --user xremap"
type -q hub && alias git hub
function gg
	git forest \
		--exclude=refs/stash \
		--pretty='format:%s  %C(yellow)%an%Creset %C(cyan)@%ad %C(white dim)%h' \
		--date='format-local:%Y-%m-%d %H:%M' \
		--color=always \
		$argv \
	| less -p
end
alias d=docker
alias tf=terraform
if type -q docker-compose
	alias dc=docker-compose
else if type -q docker
	alias dc="docker compose"
end
alias ipython="ipython --no-confirm-exit"
alias vi="nvim"
alias v=nvim
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
if type -q eza
	alias ls=eza
end
# time style for `ls -l` command output
set -gx TIME_STYLE long-iso

alias open=(nvl -c exo-open xdg-open start open)

function cursor-kill-token
	commandline -f kill-token
	commandline -f backward-kill-token
end
bind \cw cursor-kill-token
bind \et backward-token
bind \eh forward-token
bind \cj forward-jump
bind \cf backward-jump
bind \cz 'fg; commandline -f repaint'

