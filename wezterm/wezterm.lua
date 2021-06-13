local wezterm = require 'wezterm';

local is_gnome_shell = os.getenv("XDG_CURRENT_DESKTOP") == "ubuntu:GNOME"

keys = {
	{key="PageUp", mods="CTRL", action=wezterm.action{ActivateTabRelative=-1}},
	{key="PageDown", mods="CTRL", action=wezterm.action{ActivateTabRelative=1}},
	-- Pane Operations
	{key="\"", mods="CTRL", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
	{key="%", mods="CTRL", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
}
if not is_gnome_shell then
	table.insert(keys, { key = "d", mods="ALT", action=wezterm.action{ActivatePaneDirection="Left"}})
	table.insert(keys, { key = "h", mods="ALT", action=wezterm.action{ActivatePaneDirection="Down"}})
	table.insert(keys, { key = "t", mods="ALT", action=wezterm.action{ActivatePaneDirection="Up"}})
	table.insert(keys, { key = "n", mods="ALT", action=wezterm.action{ActivatePaneDirection="Right"}})
end



return {
	font = wezterm.font_with_fallback({
		"JetBrains Mono",
		-- "MesloLGS NF",
		"Noto Sans CJK JP",
	}),

	colors = {
		split = "#4444AA",
	},
	inactive_pane_hsb = {
		saturation = 0.7,
		brightness = 0.53,
	},
	keys = keys,
}
