---@type neotree.FileRenderer
local function broken_symlink(config, node, state)
	if node.is_link and not vim.loop.fs_stat(node.path) then
		return { text = " 󰌺", highlight = "Error" }
	end
	return {}
end

---@type neotree.FileRenderer
local function empty_indicator(config, node, state)
	if node.type == "file" then
		local stats = vim.loop.fs_stat(node.path)
		if stats and stats.size == 0 then
			return { text = " ∅" }
		end
	end
	return {}
end

local react_directive_cache = {}

local function get_react_directive(file_path)
	local uv = vim.uv or vim.loop
	local stat = uv.fs_stat(file_path)
	if not stat or stat.type ~= "file" then
		return nil
	end

	local mtime = stat.mtime.sec
	local cached = react_directive_cache[file_path]
	if cached and cached.mtime == mtime then
		return cached.directive
	end

	local fd = uv.fs_open(file_path, "r", 438)
	if not fd then
		return nil
	end

	local chunk_size = math.min(stat.size, 1024)
	local data = uv.fs_read(fd, chunk_size, 0)
	uv.fs_close(fd)

	local directive = nil
	if data then
		if data:match('"use client"') or data:match("'use client'") then
			directive = "client"
		elseif data:match('"use server"') or data:match("'use server'") then
			directive = "server"
		elseif data:match('["\']server%-only["\']') then
			directive = "server_only"
		end
	end

	react_directive_cache[file_path] = { mtime = mtime, directive = directive }
	return directive
end

---@type neotree.FileRenderer
local function react_indicator(config, node, state)
	if node.type ~= "file" or not (node.ext and node.ext:match("^[jt]sx?$")) then
		return {}
	end

	local directive = get_react_directive(node.path)
	if directive == "client" then
		return { text = " 💻" }
	elseif directive == "server" then
		return { text = " ⚡" }
	elseif directive == "server_only" then
		return { text = " 🌐" }
	end

	return {}
end

---@type neotree.IconProvider
local function read_devicon_file(icon, node, state)
	if node.type ~= "directory" then
		return nil
	end

	local devicon_file = node.path .. "/.devicon"
	local stat = vim.loop.fs_stat(devicon_file)
	if not stat or stat.type ~= "file" then
		return nil
	end

	local fd = vim.loop.fs_open(devicon_file, "r", tonumber("644", 8))
	local data = vim.loop.fs_read(fd, stat.size, 0)
	vim.loop.fs_close(fd)
	if not data then
		return nil
	end

	icon.text = data
	if node:is_expanded() then
		icon.highlight = "NeoTreeDirectoryIconOpened"
	end
	return icon
end

vim.api.nvim_set_hl(0, "NeoTreeDirectoryIconOpened", {
	fg = "#5ea1ff",
	underline = true,
})

---@type LazySpec
return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		---@module "neo-tree"
		---@type neotree.Config
		opts = {
			popup_border_style = "rounded",
			default_component_configs = {
				name = {
					trailing_slash = true,
				},
				git_status = {
					symbols = {
						conflict = "💥",
					},
				},
				icon = {
					provider = function(icon, node, state)
						local custom_icon = read_devicon_file(icon, node, state)
						if custom_icon then
							return custom_icon
						end
						local default_config = require("neo-tree.defaults")
						return default_config.default_component_configs.icon.provider(icon, node, state)
					end
				},
			},
			filesystem = {
				window = {
					mappings = {
						["<leader>gs"] = "git_add_file",
						["ga"] = "git_add_file",
					},
				},
				renderers = {
					file = {
						{ "indent" },
						{ "icon" },
						{
							"container",
							content = {
								{ "name",            zindex = 10 },
								{
									"symlink_target",
									zindex = 10,
									highlight = "NeoTreeSymbolicLinkTarget",
								},
								{ "broken_symlink",  zindex = 10 },
								{ "empty_indicator", zindex = 10 },
								{ "react_indicator", zindex = 10 },
								{ "clipboard",       zindex = 10 },
								{ "bufnr",           zindex = 10 },
								{ "modified",        zindex = 20, align = "right" },
								{ "diagnostics",     zindex = 20, align = "right" },
								{ "git_status",      zindex = 10, align = "right" },
								{ "file_size",       zindex = 10, align = "right" },
								{ "type",            zindex = 10, align = "right" },
							},
						},
					},
				},
				components = {
					broken_symlink = broken_symlink,
					empty_indicator = empty_indicator,
					react_indicator = react_indicator,
				},
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_by_name = {
						"__pycache__",
						".devicon",
					}
				},
				group_empty_dirs = true,
				use_libuv_file_watcher = true,
			},
			window = {
				mappings = {
					["t"] = "noop",
					["<C-b>"] = "noop",
				},
			},
		},
		keys = {
			{ '<C-b>',   '<cmd>Neotree reveal toggle<cr>', desc = 'NeoTree' },
			{ '<C-S-b>', '<cmd>Neotree close<cr>',         desc = 'NeoTree Close' },
		},
	},
}
