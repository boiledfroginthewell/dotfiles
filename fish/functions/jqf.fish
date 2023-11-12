# Interactive jq command for fish inspired by
# https://gist.github.com/reegnz/b9e40993d410b75c2d866441add2cb55

function jqf
	set input "$argv[1]"
	set bk "$(mktemp)"
	trap "rm $bk" EXIT INT TERM

	fzf --disabled \
		--preview-window='down:90%' \
		--query . \
		--preview '
			set res "$(jq --color-output -r {q} "'"$input"'")"
			if [ $status = 0 ] && [ "$(string trim "$(echo "$res" | strip-ansi-escapes)")" != "null" ]
				echo -e "$res" | tee "'"$bk"'"
			else if [ -e "'"$bk"'" ]
				echo "❌ jq error"
				cat "'"$bk"'"
			else
				echo "❌ jq error"
				cat "'"$input"'"
			end
		' \
		< /dev/null

end

