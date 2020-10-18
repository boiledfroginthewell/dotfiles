#!/bin/bash

sessionName=$(tmux display-message -p '#S')

printf "S"
tmux ls | while read f; do
	if <<<"$f" grep -q "^${sessionName}"; then
		printf "■"
	else
		printf "□"
	fi
done
printf "　"
	
