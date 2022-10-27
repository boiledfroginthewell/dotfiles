not status -i || status -c && exit

# determine dark or light theme
if not set -q COLOR_MODE
	set bg_color (string replace -r '^.*;' '' $COLORFGBG)
	if [ -n "$bg_color" ]
		if [ $bg_color -ge 9 ]
			set -gx COLOR_MODE light
		else
			set -gx COLOR_MODE dark
		end
	else
		[ -z "$COLOR_MODE" ] && set -gx COLOR_MODE dark
	end
end

set -gx DELTA_FEATURES "+theme:$([ -n "$COLOR_MODE" ] && echo "$COLOR_MODE" || echo "dark")"
[ "$COLOR_MODE" = "light" ] && set -gx BAT_THEME "Monokai Extended Light"

if [ (uname) = Darwin -a "$COLOR_MODE" = "dark" ]
	set -gx BAT_THEME "Monokai Extended Origin"
end

