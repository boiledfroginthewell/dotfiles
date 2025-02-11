-- Language specific plugins

---@type LazySpec
return {
	-- Vim editing support for kmonad config files
	{ 'kmonad/kmonad-vim',
		ft = 'kbd',
	},

	-- ### YAML
	{ 'pedrohdz/vim-yaml-folds', ft="yaml" },

	-- ### Lua
	-- Faster LuaLS setup for Neovim 
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = vim.api.nvim_get_runtime_file("", true),
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				-- { path = "${3rd}/luv/library", words = { "vim%.uv" } },
			-- },
		},
	},

	-- ### Linux
	-- 'wgwoods/vim-systemd-syntax',
}

