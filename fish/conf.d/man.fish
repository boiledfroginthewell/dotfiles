not status -i || status -c && exit

function myrc_help
	set cmd (commandline -po)[1]
	if [ -n "$cmd" ]
		men $cmd
		commandline -f repaint
	end
end

bind F1 myrc_help

