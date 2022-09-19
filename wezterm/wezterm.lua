local wezterm = require 'wezterm';

local is_gnome_shell = os.getenv("XDG_CURRENT_DESKTOP") == "ubuntu:GNOME"

keys = {
	-- Pane Operations
	-- " and % mapping doesn't work. But the default CTRL|SHIFT|ALT mods works.
	{key="\"", mods="CTRL|SHIFT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
	{key="%", mods="CTRL|SHIFT", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
	{key="w", mods="CTRL|SHIFT", action=wezterm.action{CloseCurrentTab={confirm=false}}},
	{ key="LeftArrow", mods="ALT", action=wezterm.action{ActivatePaneDirection="Left"}},
	{ key="DownArrow", mods="ALT", action=wezterm.action{ActivatePaneDirection="Down"}},
	{ key="UpArrow", mods="ALT", action=wezterm.action{ActivatePaneDirection="Up"}},
	{ key="RightArrow", mods="ALT", action=wezterm.action{ActivatePaneDirection="Right"}},

	-- Copy & Paste
	{key="C", mods="CTRL|SHIFT", action=wezterm.action{CopyTo="ClipboardAndPrimarySelection"}},
	{key="V", mods="CTRL|SHIFT", action=wezterm.action{PasteFrom="Clipboard"}},
	{key="-", mods="CTRL", action="QuickSelect"},
	-- {key="V", mods="CTRL|SHIFT", action=wezterm.action{PasteFrom="PrimarySelection"}},
}

-- if not is_gnome_shell
-- 	table.insert(keys, { key = "RightArrow", mods="ALT", action=wezterm.action{ActivatePaneDirection="Right"}})
-- end



return {
	show_update_window = false,
	check_for_updates = false,
	check_for_updates_interval_seconds = 90 * 24 * 3600,
	use_ime = true,
	font = wezterm.font_with_fallback({
		"JetBrains Mono",
		-- "MesloLGS NF",
		"Noto Sans CJK JP",
	}),

	colors = {
		split = "#4444AA",
		compose_cursor = "orange",
	},
	inactive_pane_hsb = {
		saturation = 0.7,
		brightness = 0.53,
	},
	keys = keys,

	window_padding = {
		left = 0,
		right = 0,
	},
}
