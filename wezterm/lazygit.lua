local wezterm = require 'wezterm'
local is_mac = wezterm.target_triple == 'x86_64-apple-darwin' or wezterm.target_triple == 'aarch64-apple-darwin'

local M = {}
local prev_panes = {}

---@param window Window
---@param pane Pane
function M.toggle_lazygit(window, pane)
	local tab = window:active_tab()
	local tab_id = tab:tab_id()
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
			local prev_pane_id = prev_panes[tab_id]
			local target_pane = nil
			if prev_pane_id then
				for _, info in ipairs(tab:panes_with_info()) do
					if info.pane:pane_id() == prev_pane_id then
						target_pane = info.pane
						break
					end
				end
			end
			if not target_pane then
				for _, info in ipairs(tab:panes_with_info()) do
					if info.pane:pane_id() ~= lazygit_pane:pane_id() then
						target_pane = info.pane
						break
					end
				end
			end
			if not target_pane then
				target_pane = tab:get_pane_direction("Next")
			end
			if target_pane then
				target_pane:activate()
			end
		else
			if pane:pane_id() ~= lazygit_pane:pane_id() then
				prev_panes[tab_id] = pane:pane_id()
			end
			lazygit_pane:activate()
			tab:set_zoomed(true)
		end
	else
		prev_panes[tab_id] = pane:pane_id()
		local command
		if is_mac then
			command = { "/opt/homebrew/bin/fish", "-i", "-c", "exec lazygit" }
		else
			command = { "fish", "-i", "-c", "exec lazygit" }
		end
		window:perform_action(
			wezterm.action.SplitPane {
				direction = 'Up',
				size = { Percent = 0 },
				command = { args = command },
			},
			pane
		)
		window:perform_action(wezterm.action.SetPaneZoomState(true), pane)
	end
end

return M
