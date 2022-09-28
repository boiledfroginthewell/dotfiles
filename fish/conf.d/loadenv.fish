not status -i || status -c && exit

function __loadenv_log
	set chipFgColor black
	set chipBgColor green

	# draw chip
	set_color $chipBgColor
	echo -n \ue0b6
	set_color $chipFgColor; set_color -b $chipBgColor
	echo -n .env
	set_color $chipBgColor; set_color -b $chipFgColor
	echo -n \ue0b4
	set_color normal
	echo -n " "

	echo $argv
end

function __loadenv --on-event chpwd
	set -q AUTO_ENV_FILE || set AUTO_ENV_FILE .env

	set dirStack $PWD
	while [ $dirStack != / ]
		if [ -r "$dirStack"/"$AUTO_ENV_FILE" ]
			set -fp envDirs $dirStack
		end
		set dirStack (dirname $dirStack)
	end

	if [ -z "$envDirs" ]
		return
	end

	for envDir in $envDirs
		__loadenv_sourceEnvFile "$envDir"/"$AUTO_ENV_FILE"
	end
	__loadenv_log "loaded from ($envDirs)"
end

function __loadenv_sourceEnvFile
	grep -Ev '^(#|\s*$)' $argv[1] | \
	sed -e 's/^/set -gx /' -e 's/=/ /' | \
	source
end

__loadenv

