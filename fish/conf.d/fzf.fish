not status -i || status -c && exit

set -gx FZF_DEFAULT_COMMAND fzf-default-command
set __FZF_DEFAULT_OPTS --reverse --multi --cycle --ansi --exact \
	--bind "ctrl-a:toggle-all,shift-left:preview-page-up,shift-right:preview-page-down,ctrl-f:replace-query"
if [ "$FZF_DEFAULT_OPTS" != "$__FZF_DEFAULT_OPTS" ]
	set -Ux FZF_DEFAULT_OPTS $__FZF_DEFAULT_OPTS
end
set -gx FZF_CTRL_R_OPTS "
	--bind 'ctrl-d:execute-silent(history delete --exact --case-sensitive {})+reload(history -z)+ignore'
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

function iconify
	while read line
		set emoji "　"
		if string match -q '*.sh' "$line"
			set emoji 🐚
		else if string match -q '*.fish' "$line"
			set emoji 🐟
		else if string match -q '*.vim' "$line"
			set emoji 
		else if string match -q '*.py' "$line"
			set emoji 🐍
		else if string match -qr '\\.(js|ts)$' "$line"
			set emoji 
		else if string match -q '*.java' "$line"
			set emoji ☕
		else if string match -q '*.cql' "$line"
			set emoji 👁️
		else if string match -qr '\\.[shc]ql$' "$line"
			set emoji 🛢️
		else if string match -qr '\\.(txt|md)$|README$' "$line"
			set emoji 📝
		else if string match -q '*.json' "$line"
			set emoji ﬥ
		else if string match -q '*.xml' "$line"
			set emoji 
		else if string match -qr '\\.ya?ml$' "$line"
			set emoji 
		else if string match -q '*.ini' "$line"
			set emoji 
		else if string match -q '*.properties' "$line"
			set emoji 
		else if string match -qr '\\.(exe|ps1)$' "$line"
			set emoji 
		else if string match -qr '\\.[ct]sv$' "$line"
			set emoji 
		else if string match -qr 'git' "$line"
			set emoji 
		else if string match -qri 'docker' "$line"
			set emoji 🐋
		else if string match -qri 'aws' "$line"
			set emoji 
		else if string match -q '/opt/' "$line"
			set emoji 🤖
		else if string match -qr '/(\.?config|dotfiles)' "$line"
			set emoji ⚙️
		else if string match -qr '/$' "$line"
			set emoji 📁
		end
		echo "$emoji $line"
	end
end


function _fzf_config_ctrl_s
	set -f inputValue (string replace -r $HOME ~ (commandline -pct))
	set -f searchCommand fzf-default-command
	set -f query
	set -f directory
	if [ -d $inputValue ]
		set -f searchCommand fd .
		set -fe query
		set -f directory "$inputValue"
	else if string match -q '*/*' $inputValue && [ -d (dirname $inputValue) ]
		set -f searchCommand fd .
		set -f query (basename $inputValue)
		set -f directory (dirname $inputValue)
	else if string match -qr "g(it)?" (commandline -po)[1]
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
			fzf \
			--height $FZF_HEIGHT \
			--query "$query" \
			--bind "ctrl-l:execute(less {})" | \
			string sub -s 3
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

