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

