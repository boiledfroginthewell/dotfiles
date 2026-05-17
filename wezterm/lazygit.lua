local wezterm = require 'wezterm'
local is_mac = wezterm.target_triple == 'x86_64-apple-darwin' or wezterm.target_triple == 'aarch64-apple-darwin'

local M = {}

---@param window Window
---@param pane Pane
function M.toggle_lazygit(window, pane)
	local tab = window:active_tab()
	local lazygit_pane = nil
	local lazygit_is_zoomed = false

	for _, info in ipairs(tab:panes_with_info()) do
		local process_name = info.pane:get_foreground_process_name()
		if process_name and process_name:match('lazygit') then
			lazygit_pane = info.pane
			lazygit_is_zoomed = info.is_zoomed
			break
		end
	end

	if lazygit_pane then
		if lazygit_is_zoomed then
			tab:set_zoomed(false)
			tab:get_pane_direction("Prev"):activate()
		else
			lazygit_pane:activate()
			tab:set_zoomed(true)
		end
	else
		local command
		if is_mac then
			command = { "/opt/homebrew/bin/fish", "-i", "-c", "exec lazygit" }
		else
			command = { "fish", "-i", "-c", "exec lazygit" }
		end
		window:perform_action(
			wezterm.action.SplitPane {
				direction = 'Down',
				size = { Percent = 0 },
				command = { args = command },
			},
			pane
		)
		window:perform_action(wezterm.action.SetPaneZoomState(true), pane)
	end
end

return M
