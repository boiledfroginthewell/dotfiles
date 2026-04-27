local wezterm = require 'wezterm' --[[@as Wezterm]]

local parse_color = wezterm.color.parse
local COLOR_PALETTE = {
	-- dusty navy
	{ bg = parse_color("#2F3650"), fg = parse_color("#E6EAF2") },
	-- muted plum
	{ bg = parse_color("#3B2F4D"), fg = parse_color("#E7E2F0") },
	-- slate blue
	{ bg = parse_color("#2E3F54"), fg = parse_color("#E3EBF5") },
	-- deep violet
	{ bg = parse_color("#3E345A"), fg = parse_color("#E8E3F4") },
	-- dark teal
	{ bg = parse_color("#304A4A"), fg = parse_color("#E1EEEE") },
	-- muted mauve
	{ bg = parse_color("#4A3642"), fg = parse_color("#F1E6EC") },
	-- steel blue
	{ bg = parse_color("#2F4257"), fg = parse_color("#E2ECF6") },
	-- grape purple
	{ bg = parse_color("#43365C"), fg = parse_color("#E9E4F5") },
	-- rainbow red
	{ bg = parse_color("#4E2F38"), fg = parse_color("#F6E8EC") },
	-- rainbow orange
	{ bg = parse_color("#4A352C"), fg = parse_color("#F5EADF") },
	-- rainbow yellow
	{ bg = parse_color("#474128"), fg = parse_color("#F3F0DE") },
	-- rainbow lime
	{ bg = parse_color("#33462B"), fg = parse_color("#EAF3E1") },
	-- rainbow green
	{ bg = parse_color("#2C4936"), fg = parse_color("#E3F2E9") },
	-- rainbow cyan
	{ bg = parse_color("#28484D"), fg = parse_color("#DFF2F4") },
	-- rainbow blue
	{ bg = parse_color("#2B3F57"), fg = parse_color("#E4EDF8") },
	-- rainbow indigo
	{ bg = parse_color("#32385C"), fg = parse_color("#E7E9F8") },
	-- rainbow violet
	{ bg = parse_color("#3D325D"), fg = parse_color("#ECE6F8") },
	-- storm gray
	{ bg = parse_color("#303641"), fg = parse_color("#E7EBF0") },
	-- graphite
	{ bg = parse_color("#2E3138"), fg = parse_color("#E6E8EC") },
	-- midnight teal
	{ bg = parse_color("#273E43"), fg = parse_color("#E1EEF0") },
}

local git_root_cache = {}
local project_color_cache = {}

local function tab_state_colors(colors, is_active, is_hovered)
	local background = colors.bg
	local foreground = colors.fg

	if is_active then
		background = colors.bg:lighten(0.22)
		foreground = colors.fg:lighten(0.05)
	elseif is_hovered then
		background = colors.bg:lighten(0.12)
	end

	return tostring(background), tostring(foreground)
end

local function url_to_path(url)
	if not url then
		return nil
	end

	if type(url) == "table" and url.file_path then
		return url.file_path
	end

	local as_string = tostring(url)
	local path = as_string:match("^file://[^/]*(/.*)$")
	if path then
		return path
	end
	return as_string
end

local function get_git_root(path)
	if not path then
		return nil
	end

	if git_root_cache[path] ~= nil then
		return git_root_cache[path]
	end

	local cmd = string.format("git -C %q rev-parse --show-toplevel 2>/dev/null", path)
	local handle = io.popen(cmd)
	if not handle then
		git_root_cache[path] = false
		return nil
	end

	local root = handle:read("*l")
	handle:close()
	git_root_cache[path] = root or false
	return root
end

local function pane_cwd_path(pane)
	local cwd = url_to_path(pane.current_working_dir)
	if cwd then
		return cwd
	end

	-- Some panes expose cwd only via method.
	local ok, dir_url = pcall(function()
		return pane:get_current_working_dir()
	end)
	if ok then
		return url_to_path(dir_url)
	end
	return nil
end

local function hash_string(str)
	local hash = 0
	for i = 1, #str do
		hash = (hash * 33 + str:byte(i)) % 2147483647
	end
	return hash
end

local function colors_for_project(project_key)
	local cached = project_color_cache[project_key]
	if cached then
		return cached
	end

	local idx = (hash_string(project_key) % #COLOR_PALETTE) + 1
	local colors = COLOR_PALETTE[idx]
	project_color_cache[project_key] = colors
	return colors
end

wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
	local cwd_path = pane_cwd_path(tab.active_pane)
	local git_root = get_git_root(cwd_path)
	local project_key = git_root
	if not project_key then
		-- Outside git repos, hash by cwd to keep per-directory colors.
		project_key = cwd_path or "no-project"
	end
	local colors = colors_for_project(project_key)
	local background, foreground = tab_state_colors(colors, tab.is_active, hover)

	local title = tab.active_pane.title
	if not title or title == "" then
		title = "shell"
	end

	local cells = {
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Attribute = { Intensity = tab.is_active and "Bold" or "Normal" } },
	}
	table.insert(cells, { Text = " " .. wezterm.truncate_right(title, max_width - 2) .. " " })
	return cells
end)