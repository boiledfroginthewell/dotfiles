function nvl
	switch $argv[1]
		case "-v"
			for x in $argv[2..]
				if [ -n "$x" ]
					echo "$x"
					return
				end
			end
		case "-f"
			for x in $argv[2..]
				if [ -r "$x" ]
					echo "$x"
					return
				end
			end
		case "-c"
			for x in $argv[2..]
				if type -q -- "$x"
					echo "$x"
					return
				end
			end
	end
end

function rootSearch
	argparse "d/dir=" "r/regex" "q/quiet" -- $argv || return

	set searchPath (nvl -v $dir (pwd))
	set searchingFile $argv[1]

	while [ $searchPath != / ]
		if set -q _flag_regex
			set -a results (ls "$searchPath" | grep -E "$searchingFile" | sed "s:^:$searchPath/:")
		else if [ -e "$searchPath/$searchingFile" ]
			set -a results "$searchPath/$searchingFile"
		end
		set searchPath (dirname $searchPath)
	end

	if [ -n "$results" ]
		set -q _flag_quiet || printf '%s\n' $results
	else
		return 1
	end
end

