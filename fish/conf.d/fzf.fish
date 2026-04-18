not status -i || status -c && exit

set -gx FZF_DEFAULT_COMMAND fzf-default-command
set __FZF_DEFAULT_OPTS '
	--reverse --multi --cycle --ansi --exact
	--no-sort
	--bind "ctrl-a:toggle-all,shift-left:preview-page-up,shift-right:preview-page-down"
	--bind "ctrl-f:replace-query"
	--bind "ctrl-y:execute-silent(echo {} | pbcopy)"
	--header "ctrl-f: fill, ctrl-y: yank"
'

if [ "$FZF_DEFAULT_OPTS" != "$__FZF_DEFAULT_OPTS" ]
	set -Ux FZF_DEFAULT_OPTS $__FZF_DEFAULT_OPTS
end
set -gx FZF_CTRL_R_OPTS "
	--bind 'ctrl-d:execute-silent!history delete --exact --case-sensitive \"\$(echo {} | sed \"s/^[ 0-9]*//\")\"!+reload(history -z --reverse)+ignore'
	--header 'ctrl-d: Delete history'
"

set -l KEY_BINDING_FILE (
	nvl -f \
		/usr/share/fish/vendor_functions.d/fzf_key_bindings.fish \
		/usr/share/doc/fzf/examples/key-bindings.fish \
		/opt/homebrew/opt/fzf/shell/key-bindings.fish
)
if [ -n "$KEY_BINDING_FILE" ]
	# Disable C-t Mapping
	sed 's/.*bind \\\\ct.*/:/' $KEY_BINDING_FILE | source
	fzf_key_bindings
else
	echo "WARN: fzf key-bindings.fish file is not found." >&2
end

[ -z "$FZF_HEIGHT" ] && set FZF_HEIGHT 40%

function _fzf_config_insert_git
	switch (commandline -px)[2]
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
	set -f inputValue (string replace -r $HOME ~ (commandline -pct))
	set -f searchCommand fzf-default-command
	set -f query
	set -f directory
	if [ -n "$(commandline -p)" ] && [ ""$(commandline -xpc)[1] = argo ] && string match -qr '^(cronwf/|wftmpl/)' "$(commandline -cxt)"
		set -f file (fd -e yaml -e yml -E kustomization | fzf)
		if [ -n "$file" ]
			set -f resourceName (basename "$file" | string replace -r '\\..*' '')
			commandline "$(commandline)$resourceName"
		end
		commandline -f repaint
		return
	else if [ -d $inputValue ]
		set -f searchCommand fd --no-ignore-vcs .
		set -fe query
		set -f directory "$inputValue"
	else if string match -q '*/*' $inputValue && [ -d (dirname $inputValue) ]
		set -f searchCommand fd --no-ignore-vcs .
		set -f query (basename $inputValue)
		set -f directory (dirname $inputValue)
	else if string match -qr "g(it)?" (commandline -p)[1]
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
			iconify | \
			sed "s;\b$PWD/?;./;g" | \
			fzf \
			--height $FZF_HEIGHT \
			--query "$query" \
			--bind "ctrl-l:execute(less {})" | \
			string sub -s 3 | \
			string trim
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

