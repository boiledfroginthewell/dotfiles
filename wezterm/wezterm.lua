local wezterm = require 'wezterm';
local config = wezterm.config_builder()
local is_mac = false
if wezterm.target_triple == 'x86_64-apple-darwin' or wezterm.target_triple == 'aarch64-apple-darwin' then
	is_mac = true
end
local is_gnome_shell = os.getenv("XDG_CURRENT_DESKTOP") == "ubuntu:GNOME"

-- -- https://wezfurlong.org/wezterm/config/lua/window/toast_notification.html
-- wezterm.on('window-config-reloaded', function(window, pane)
--   window:toast_notification('wezterm', 'configuration reloaded!', nil, 3000)
-- end)

config.default_prog = { is_mac and "/opt/homebrew/bin/fish" or "/usr/bin/fish" }
config.use_ime = true
config.show_update_window = false
config.window_close_confirmation = 'NeverPrompt'
config.check_for_updates = false
config.check_for_updates_interval_seconds = 90 * 24 * 3600
config.warn_about_missing_glyphs = false
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

config.default_cursor_style = "SteadyBar"
-- config.force_reverse_video_cursor = true

-- config.color_scheme = 'Builtin Dark'
config.color_scheme = 'Andromeda'
config.font_size = 13.5
config.colors = {
	split = "#4444AA",
	compose_cursor = "#000099",
	cursor_fg = '#262A33',
	cursor_bg = '#E5E5E5',
}
config.inactive_pane_hsb = {
	saturation = 0.7,
	brightness = 0.53,
}
config.window_padding = {
	left = 0,
	right = 0,
}

local function copy_last_output(window, pane)
	local cursor = pane:get_cursor_position()
	local zone = pane:get_semantic_zone_at(0, cursor.y - 1)
	if not zone then
		return
	end
	local output = pane:get_text_from_semantic_zone(zone)
	window:copy_to_clipboard(output)
end

config.keys = {
	-- Pane Operations
	{ key = "\"",       mods = "CTRL|SHIFT", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
	{ key = "%",        mods = "CTRL|SHIFT", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
	{ key = "w",        mods = "CTRL|SHIFT", action = wezterm.action { CloseCurrentTab = { confirm = false } } },

	-- Copy & Paste
	{ key = "C",        mods = "CTRL|SHIFT", action = wezterm.action { CopyTo = "ClipboardAndPrimarySelection" } },
	{ key = "V",        mods = "CTRL|SHIFT", action = wezterm.action { PasteFrom = "Clipboard" } },
	{ key = "-",        mods = "CTRL",       action = "QuickSelect" },
	{ key = "PageUp",   mods = "CTRL|SHIFT", action = wezterm.action.ScrollToPrompt(-1) },
	{ key = "PageDown", mods = "CTRL|SHIFT", action = wezterm.action.ScrollToPrompt(1) },
	{ key = "n", mods = "CTRL|SHIFT", action = wezterm.action_callback(copy_last_output) },
}
for _, v in ipairs(require('nvim-smart-splits')) do
	table.insert(config.keys, v)
end

-- if not is_gnome_shell
-- 	table.insert(config.keys, { key = "RightArrow", mods="ALT", action=wezterm.action{ActivatePaneDirection="Right"}})
-- end

config.mouse_bindings = {
	{
		event = { Down = { streak = 3, button = "Left" } },
		action = wezterm.action.SelectTextAtMouseCursor "SemanticZone",
		mods = "NONE",
	},
}

config.quick_select_alphabet = "dvorak"
config.quick_select_patterns = {
	'[a-zA-Z/][0-9a-fA-Z_:/.\\-]{15,}',
}

config.hyperlink_rules = wezterm.default_hyperlink_rules()
-- GitHub repostory
table.insert(config.hyperlink_rules, {
	regex = '["\']([a-zA-Z0-9._-]+/[a-zA-Z0-9._-]+)["\']',
	format = 'https://github.com/$1',
	highlight = 1
})

wezterm.on("user-var-changed", function(window, pane, name, value)
	if name ~= "WEZTERM_PROG" then
		return
	end

	local overrides = window:get_config_overrides() or {}
	if value == "nvim" then
		overrides.force_reverse_video_cursor = true
		overrides.default_cursor_style = "SteadyBlock"
	else
		overrides = nil
	end
	window:set_config_overrides(overrides)
end)

local ok, localConfig = pcall(require, 'local')
if ok then
	localConfig.setup(config)
end

return config

