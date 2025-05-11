function t --wrap task
	set i 0
	for arg in $argv
		set i (math $i + 1)
		if string match -- $argv '-*'
			set -fa opts $arg
		else
			break
		end
	end
	task $argv[1..$i] -- $argv[(math $i + 1)..]
end

