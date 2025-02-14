function g --wrap git
	if [ -z "$argv" -o "$argv[1]" = "--" ]
		git status $argv
	else if [ "$argv[1]" = "-" ]
		git switch $argv
	else if [ "$argv[1]" = "cd" ]
		set worktrees (git worktree list)
		set worktreeCount (count $worktrees)
		if [ $worktreeCount = 1 ]
			echo "Only one worktree" >&2
			return 1
		else if [ $worktreeCount = 2 ]
			cd "$(
				printf "%s\n" $worktrees \
				| cut -d " " -f 1 \
				| grep -Ev "^$(git rev-parse --show-toplevel)\$"
			)"
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
 	else if [ "$argv[1]" = "add" ] && [ (count $argv) = 1 ]
		forgit::add
	else if [ "$argv[1]" = "switch" ] && [ (count $argv) = 1 ]
		set branch (git branch -a --color | fzf | cut -c 3-)
		set -q branch && git switch "$branch"
	else if [ "$argv[1]" = "switch" ] && string match -qr -- "$argv[2]" '^\\d+$'
		gh pr checkout $argv[2]
	else if string match -qr "$argv[1]" '^auth|api|browse|gist|pr|release|repo$'
		gh $argv[1..]
	else if [ "$argv[1]" = "open" ]
		gh browse
	else
		git $argv
	end
end
