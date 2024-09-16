not status -i || status -c && exit

set NOTIFY_THREASHOLD 60000
if not set -q AUTO_NOTIFY_EXCLUDE_PATTERNS
	set AUTO_NOTIFY_EXCLUDE_PATTERNS l 'gg?' diff watchexec fzf 'm[ae]n' lazygit vi
end
set NOTIFY_EXCLUDE '^('(string join '|' $AUTO_NOTIFY_EXCLUDE_PATTERNS)')( |$)'

function __check_time -e fish_postexec
	if [ $CMD_DURATION -gt 60000 ]
		if string match -r "$NOTIFY_EXCLUDE" "$argv"
			return
		end
		set body "⏱️$(printf '%.0f' (math $CMD_DURATION / 60)) s\n> $argv"
		if type -q notify-send
			notify-send -a "Fish" -i "~/images/fish.png" "Command Notification" "$body"
		else
			notify -s -t "🐟Fish" "$body"
		end
	end
end

