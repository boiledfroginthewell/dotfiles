not status -i || status -c && exit

set -q COLOR_MODE && exit

# determine dark or light theme
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

set -gx DELTA_FEATURES "+theme:([ -n "$COLOR_MODE" && "$COLOR_MODE" || "-dark")"
[ "$COLOR_MODE" = "light" ] && set -gx BAT_THEME "Monokai Extended Light"

