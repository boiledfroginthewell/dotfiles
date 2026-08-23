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
								{ "empty_indicator", zindex = 10 },
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
					empty_indicator = empty_indicator,
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
