not status -i || status -c && exit

set NOTIFY_THRESHOLD 60000
if not set -q AUTO_NOTIFY_EXCLUDE_PATTERNS
	set AUTO_NOTIFY_EXCLUDE_PATTERNS l 'gg?' diff watchexec fzf 'm[ae]n' lazygit 'vi?' jqf
end
set NOTIFY_EXCLUDE '^('(string join '|' $AUTO_NOTIFY_EXCLUDE_PATTERNS)')( |$)'

function __check_time -e fish_postexec
	if [ $status = 0 ]
		set cmdStatus "✅️ "
	else
		set cmdStatus "❌ "
	end
	if [ $CMD_DURATION -gt $NOTIFY_THRESHOLD ]
		if string match -r "$NOTIFY_EXCLUDE" "$argv"
			return
		end
		set body "$cmdStatus⏱️$(printf '%.0f' (math $CMD_DURATION / 60)) s\n> $argv"
		if type -q notify-send
			notify-send -a "Fish" -i "~/images/fish.png" "Command Notification" "$body"
		else
			notify -s -t "🐟Fish" "$body"
		end
	end
end

