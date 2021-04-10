local wezterm = require 'wezterm';

return {
	font = wezterm.font_with_fallback({
		"JetBrains Mono",
		-- "MesloLGS NF",
		"Noto Sans CJK JP",
	}),

	keys = {
		{key="PageUp", mods="CTRL", action=wezterm.action{ActivateTabRelative=-1}},
		{key="PageDown", mods="CTRL", action=wezterm.action{ActivateTabRelative=1}},
		-- Pane Operations
		{key="\"", mods="CTRL", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
		{key="%", mods="CTRL", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
		{ key = "d", mods="ALT", action=wezterm.action{ActivatePaneDirection="Left"}},
		{ key = "h", mods="ALT", action=wezterm.action{ActivatePaneDirection="Down"}},
		{ key = "t", mods="ALT", action=wezterm.action{ActivatePaneDirection="Up"}},
		{ key = "n", mods="ALT", action=wezterm.action{ActivatePaneDirection="Right"}},
	}
}

