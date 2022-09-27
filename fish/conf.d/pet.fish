not status -i || status -c && exit

function pet-select
	set petResult (pet search --color --query (commandline))
	if [ -n "$petResult" ]
		if string match "\$*" $petResult[1]
			commandline -i $petResult
		else
			commandline $petResult
		end

		commandline -f repaint
	end
end

bind \cp pet-select

