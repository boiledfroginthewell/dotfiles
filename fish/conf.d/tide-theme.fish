set -U tide_left_prompt_items vi_mode pwd kubectl git shlvl
set jobItem (type -q wakatime || echo jobs)
set timeItem ([ "$CONFIG_MODE" = "job" ] && echo time)
set -U tide_right_prompt_items status context $jobItem node virtual_env rustc java php chruby go toolbox terraform aws kubectl nix_shell crystal cmd_duration $timeItem

set -g tide_right_prompt_suffix \ue0b4

set -g tide_git_icon \ufbd9
set -g tide_git_bg_color_unstable 3e56b3
set -g tide_git_bg_color_urgent red

set -g tide_jobs_color E69500
set -g tide_jobs_icon \uf59f

set -gx tide_kubectl_color 316CE6
set -gx tide_kubectl_bg_color d9d9d9

set -gx tide_cmd_duration_threshold 90000

set -gx tide_time_color ffecb3
set -gx tide_time_format '%T'

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

