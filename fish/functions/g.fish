set _GIT (nvl -c hub git)

function g --wrap $_GIT
	if [ -z "$argv" -o "$argv[1]" = "--" ]
		$_GIT status $argv
	else if [ "$argv[1]" = "-" ]
		$_GIT switch $argv
	else if [ "$argv[1]" = "cd" ]
		set worktree (g worktree list | fzf | choose 0)
		set -q worktree && cd "$worktree"
	else if [ "$argv[1]" = "addi" ]
		forgit::add $argv[2..]
		#git forgit add $argv[2..]
	else if [ "$argv[1]" = "pr" ] && [ "$argv[2]" = "switch" ]
		$_GIT pr checkout $argv[3..]
	else
		$_GIT $argv
	end
end

