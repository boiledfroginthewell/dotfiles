not status -i || status -c && exit

set AUTO_ENV_FILES .env .env.local

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
	set -q AUTO_ENV_FILES || set AUTO_ENV_FILES .env

	set dirStack $PWD
	while [ $dirStack != / ]
		for x in $AUTO_ENV_FILES[-1..1]
			if [ -r "$dirStack"/"$x" ]
				set -fp envFiles $dirStack/$x
			end
		end
		set dirStack (dirname $dirStack)
	end

	if [ -z "$envFiles" ]
		return
	end

	for envFile in $envFiles
		loadenv "$envFile"
	end
	__loadenv_log "loaded from ($envFiles)"
end

function loadenv
	grep -Ev '^(#|\s*$)' (nvl -v $argv[1] .env) | \
	sed -e 's/^/set -gx /' -e 's/=/ "/' -e 's/$/"/' | \
	source
end

__loadenv

