# imgcat
if type -q wezterm
	set imageViewer wezterm imgcat
else if type -q imgcat
	set imageViewer imgcat
end
if readlink -m . &> /dev/null
	# Gnu readlink (coreutils) is available
	set READLINK_COMMAND readlink -m
else
	# When BSD readlink is installed
	set READLINK_COMMAND echo
end

function l
	for arg in $argv
		if string match -q -- "-*" $arg
			set -af opt $arg
		else
			set -af files $arg
		end
	end

	if [ ! -t 0 ]
		less
	else if [ -z "$files" -o -d "$files[1]" ]
		ls $opt $files
	else
		set mime (file --mime ($READLINK_COMMAND "$files[1]"))
		if string match -q "*image/*" $mime
			$imageViewer $opt $files
		else if string match -q "*charset=binary*" $mime && not string match "*x-empty*" $mime
			open $opt $files
		else
			less $opt $files
		end
	end
end

