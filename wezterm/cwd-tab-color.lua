local wezterm = require 'wezterm' ---@as Wezterm

local COLOR_PALETTE = wezterm.color.gradient({preset="Rainbow"}, 14)
local SATURATION = 0.6
local LIGHTNESS = 0.24
local git_root_cache = {}

---@param color Color
---@param is_active boolean
---@param is_hovered boolean
local function tab_state_colors(color, is_active, is_hovered)
	local bg = wezterm.color.from_hsla(color:hsla(), SATURATION, LIGHTNESS, 1)
	local fg = bg:complement_ryb()

	if LIGHTNESS < 0.5 then
		fg = fg:lighten_fixed(0.9)
	else
		fg = fg:darken_fixed(0.9)
	end

	if is_active then
		bg = bg:lighten(0.35)
		fg = fg:lighten(0.05)
	elseif is_hovered then
		bg = bg:lighten(0.12)
	end

	return bg, fg
end

---@param url Url?
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

---@param path string?
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

---@param pane PaneInformation
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

---@param str string
local function hash_string(str)
	local hash = 0
	for i = 1, #str do
		hash = (hash * 33 + str:byte(i)) % 2147483647
	end
	return hash
end

wezterm.on("format-tab-title",
	---@param tab TabInformation
	---@param tabs TabInformation[]
	---@param panes PaneInformation[]
	---@param cfg Config
	---@param hover boolean
	---@param max_width integer
	function(tab, tabs, panes, cfg, hover, max_width)
		local cwd_path = pane_cwd_path(tab.active_pane)
		local project_key = get_git_root(cwd_path)
		if not project_key then
			-- Outside git repos, hash by cwd to keep per-directory colors.
			project_key = cwd_path or "no-project"
		end
		local color = COLOR_PALETTE[(hash_string(project_key) % #COLOR_PALETTE) + 1]
		local background, foreground = tab_state_colors(color, tab.is_active, hover)

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
	end
)
