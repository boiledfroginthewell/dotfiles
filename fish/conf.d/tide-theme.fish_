function reset_tide_config
	tide configure --auto --style=Classic --prompt_colors='True color' --classic_prompt_color=Light --show_time=No --classic_prompt_separators=Angled --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='One line' --prompt_spacing=Compact --icons='Many icons' --transient=No
	# tide configure --auto --style=Classic --prompt_colors='True color' --classic_prompt_color=Lightest --show_time='24-hour format' --classic_prompt_separators=Angled --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='One line' --prompt_spacing=Compact --icons='Many icons' --transient=No
end

set jobItem (type -q wakatime || echo jobs)
set timeItem ([ "$CONFIG_MODE" = "job" ] && echo time)
set tmp_tide_left_prompt_items vi_mode pwd git shlvl
set tmp_tide_right_prompt_items status context $jobItem node python rustc java php go toolbox terraform kubectl nix_shell crystal cmd_duration $timeItem
# setting universal variable on every start up leaves garbage files (fishd.tmp.XXXXXX)
if [ "$tide_left_prompt_items" != "$tmp_tide_left_prompt_items" ]
	set -U tide_left_prompt_items "$tmp_tide_left_prompt_items"
end
if [ "$tide_right_prompt_items" != "$tmp_tide_right_prompt_items" ]
	set -U tide_right_prompt_items $tmp_tide_right_prompt_items
end

set -g tide_right_prompt_suffix \ue0b4

set -e tide_pwd_icon

set -g tide_git_icon \ufbd9
set -g tide_git_bg_color_unstable 3e56b3
set -g tide_git_bg_color_urgent red
set -g tide_git_bg_color_stash $tide_git_bg_color
set -g tide_git_truncation_length 15

set -g tide_jobs_color E69500
set -g tide_jobs_icon "\uf59f"

set -g tide_kubectl_color 316CE6
set -g tide_kubectl_bg_color d9d9d9

set -g tide_cmd_duration_threshold 90000

set -g tide_time_color ffecb3
set -g tide_time_format '%T'

# begin
# 	set -l prompt_bg_color 303030
# 
# 	set -g tide_sleep_color E69500
# 	set -g tide_sleep_bg_color $prompt_bg_color
# 	function _tide_item_jobs
# 		set jobList (jobs | tail -n +1)
# 		set suspendedCount (echo -e $jobList | grep stopped | wc -l)
# 		if [ $suspendedCount -ne 0 ]
# 			# _tide_print_item jobs \uf9b1 $suspendedCount
# 		end
# 		# _tide_print_item sleep \uf59f" " $suspendedCount
# 		_tide_print_item jobs \uf59f" " (jobs | grep stopped | wc -l)
# 		jobs > $HOME/hoge
# 	end
# end

