-- https://github.com/mrjones2014/smart-splits.nvim#wezterm

local wezterm = require 'wezterm';

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s)
	return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

local function is_vim(pane)
	local process_name = basename(pane:get_foreground_process_name())
	return process_name == 'nvim' or process_name == 'vim'
end

local direction_keys = {
	Left = 'LeftArrow',
	Down = 'DownArrow',
	Up = 'UpArrow',
	Right = 'RightArrow',
	-- reverse lookup
	LeftArrow = 'Left',
	DownArrow = 'Down',
	UpArrow = 'Up',
	RightArrow = 'Right',
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		-- mods = resize_or_move == 'resize' and 'META' or 'CTRL',
		mods = 'ALT',
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					-- SendKey = { key = key, mods = resize_or_move == 'resize' and 'META' or 'CTRL' },
					SendKey = { key = key, mods = 'ALT' },
				}, pane)
			else
				if resize_or_move == 'resize' then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

return {
	split_nav('move', 'LeftArrow'),
	split_nav('move', 'UpArrow'),
	split_nav('move', 'DownArrow'),
	split_nav('move', 'RightArrow'),
}

