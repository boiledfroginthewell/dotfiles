local wezterm = require 'wezterm';

local is_gnome_shell = os.getenv("XDG_CURRENT_DESKTOP") == "ubuntu:GNOME"

keys = {
	-- {key="PageUp", mods="CTRL", action=wezterm.action{ActivateTabRelative=-1}},
	-- {key="PageDown", mods="CTRL", action=wezterm.action{ActivateTabRelative=1}},
	-- Pane Operations
	{key="\"", mods="CTRL", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
	{key="%", mods="CTRL", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
	{key="w", mods="CTRL|SHIFT", action=wezterm.action{CloseCurrentTab={confirm=false}}},
	{ key="LeftArrow", mods="ALT", action=wezterm.action{ActivatePaneDirection="Left"}},
	{ key="DownArrow", mods="ALT", action=wezterm.action{ActivatePaneDirection="Down"}},
	{ key="UpArrow", mods="ALT", action=wezterm.action{ActivatePaneDirection="Up"}},
	{ key="RightArrow", mods="ALT", action=wezterm.action{ActivatePaneDirection="Right"}},

	-- Copy & Paste
	{key="C", mods="CTRL|SHIFT", action=wezterm.action{CopyTo="ClipboardAndPrimarySelection"}},
	{key="V", mods="CTRL|SHIFT", action=wezterm.action{PasteFrom="Clipboard"}},
	-- {key="V", mods="CTRL|SHIFT", action=wezterm.action{PasteFrom="PrimarySelection"}},
}

-- if not is_gnome_shell
-- 	table.insert(keys, { key = "RightArrow", mods="ALT", action=wezterm.action{ActivatePaneDirection="Right"}})
-- end



return {
	use_ime = true,
	show_update_window = false,
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
