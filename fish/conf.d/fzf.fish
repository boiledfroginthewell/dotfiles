not status -i || status -c && exit

set -gx FZF_DEFAULT_COMMAND fzf-default-command
set __FZF_DEFAULT_OPTS --reverse --multi --cycle --ansi \
	--bind "ctrl-a:toggle-all,shift-left:preview-page-up,shift-right:preview-page-down"
if not set -q FZF_DEFAULT_OPTS || [ "$FZF_DEFAULT_OPTS" != "$__FZF_DEFAULT_OPTS" ]
	set -Ux FZF_DEFAULT_OPTS $__FZF_DEFAULT_OPTS
end

set -l KEY_BINDING_FILE /usr/share/doc/fzf/examples/key-bindings.fish
if [ -r "$KEY_BINDING_FILE" ]
	# Disable C-t Mapping
	sed 's/.*bind \\\\ct.*/:/' $KEY_BINDING_FILE | source
	fzf_key_bindings
end

[ -z "$FZF_HEIGHT" ] && set FZF_HEIGHT 40%

function _fzf_config_insert_git
	switch (commandline -po)[2]
		case stash add restore
			git status --short | \
			fzf \
				--height $FZF_HEIGHT \
				--preview "git diff --color=always -- \$(echo {} | cut -c 4-) | delta" | \
			cut -c 4-
			return
        case branch switch checkout push
			_fzf_config_select_git_ref
			return
        case '*'
			echo __fallback
			return
    end

end

function _fzf_config_ctrl_s
	set -f inputValue (string replace -r $HOME '^~' (commandline -pct))
	set -f searchCommand "fzf-default-command"
	set -f query
	set -f directory
	if [ -d "$inputValue" ]
		set -f searchCommand fd .
		set -fe query
		set -f directory "$inputValue"
	else if string match '*/*' $inputValue && [ -d (dirname $inputValue) ]
		set -f searchCommand fd .
		set -f query (basename $inputValue)
		set -f directory (dirname $inputValue)
	else if string match -r "g(it)?" (commandline -po)[1]
		set output (_fzf_config_insert_git)
		if [ "$output" = "__fallback" ]
			set -e output
			set -f searchCommand fd .
			set -e query
			set -f directory (git rev-parse --show-toplevel | sed s:"^$PWD":"./":)
		else if [ -z "$output" ]
			commandline -f repaint
			return
		end
	else
		[ -n "$inputValue" ] && set -f query $inputValue
		set -e directory
	end

	if [ -z "$output" ]
		set -f output (
			$searchCommand $directory | \
			fzf \
			--height $FZF_HEIGHT \
			--query "$query" \
			--bind "ctrl-l:execute(less {})"
		)
	end
	if [ -z "$output" ]
		commandline -f repaint
		return
	end

	set pos (commandline -C)
	set buffer (commandline)
	set wordUsed (commandline -pct)

	set rbuffer (echo $buffer | cut -c "$(math $pos + 1)-")
	set prefix (echo $buffer | cut -c 1-"$(math $pos - $(string length $wordUsed))")

	commandline "$prefix""$output""$rbuffer"
	commandline -C (math $pos - (string length "$wordUsed") + (string length "$output"))
	commandline -f repaint
end
bind \cs _fzf_config_ctrl_s


function _fzf_config_insert_git_hash
	set selection (git graph --color=always | fzf --no-sort | sed -e 's;\s$;;' -e 's;.* ;;')
	if [ -n "$selection" ]
		commandline -i (echo -n $selection)
		commandline -f repaint
	end
end
bind \cg\cr _fzf_config_insert_git_hash

function _fzf_config_select_git_ref
	cat \
		(git branch -a --color | sed -e 's:remotes/::' -e 's:^:[branch] :' | psub) \
		(git tag -l | sed 's:^:[tag] :' | psub) \
	| fzf --no-sort --preview 'git log --color --oneline $(echo {} | sd ".* " "")' --height 40% \
	| sd '\[\w+\] [\s*]*' ''
end

function _fzf_config_insert_git_ref -d "insert git refs (branches and tags) at cursor"
	set selection ( _fzf_config_select_git_ref )
	if [ -n "$selection" ]
		commandline -i (echo -n $selection)
		commandline -f repaint
	end
end
bind \cg\cc _fzf_config_insert_git_ref

