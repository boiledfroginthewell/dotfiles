set _GIT (nvl -c hub git)

function g --wrap $_GIT
	if [ -z "$argv" -o "$argv[1]" = "--" ]
		$_GIT status $argv
	else if [ "$argv[1]" = "-" ]
		$_GIT switch $argv
	else if [ "$argv[1]" = "cd" ]
		set worktrees (git worktree list)
		if [ (count $worktrees) = 2 ]
			cd (
				printf "%s\n" $worktrees \
				| cut -d " " -f 1 \
				| grep -v (git rev-parse --show-toplevel)
			)
			return
		end
		set worktree (printf "%s\n" $worktrees | fzf | choose 0)
		set -q worktree && cd "$worktree"
	else if [ "$argv[1]" = "addi" ]
		if type forgit::add &> /dev/null
			forgit::add $argv[2..]
		else
			git forgit add $argv[2..]
		end
	else if [ "$argv[1]" = "pr" ] && [ "$argv[2]" = "switch" ]
		$_GIT pr checkout $argv[3..]
	else if [ "$argv[1]" = "switch" ] && [ (count $argv) = 1 ]
		set branch ($_GIT branch -a --color | fzf | cut -c 3-)
		set -q branch && g switch "$branch"
	else
		$_GIT $argv
	end
end

