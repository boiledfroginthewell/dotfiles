not status -i || status -c && exit

set NOTIFY_THREASHOLD 60000
set NOTIFY_EXCLUDE '^(ssh|n?vim?|l|fzf|m[ae]n|watchexec|gg?|diff|lazygit)( |$)'

function __check_time -e fish_postexec
	if [ $CMD_DURATION -gt 60000 ]
		if string match -r "$NOTIFY_EXCLUDE" "$argv"
			return
		end
		set body "⏱️$(printf '%.0f' (math $CMD_DURATION / 60)) s\n> $argv"
		if type -q notify-send
			notify-send -a "Fish" -i "~/images/fish.png" "Command Notification" "$body"
		else
			notify -t "🐟Fish" "$body"
		end
	end
end

