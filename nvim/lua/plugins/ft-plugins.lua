-- Language specific plugins

---@type LazySpec
return {
	-- Vim editing support for kmonad config files
	{ 'kmonad/kmonad-vim',
		ft = 'kbd',
	},

	-- ### CSV
	{
		"hat0uma/csvview.nvim",
		---@module "csvview"
		---@type CsvView.Options
		opts = {
			parser = { comments = { "#" } },
			keymaps = {
				-- Text objects for selecting fields
				textobject_field_inner = { "if", mode = { "o", "x" } },
				textobject_field_outer = { "af", mode = { "o", "x" } },
				-- Excel-like navigation:
				-- Use <Tab> and <S-Tab> to move horizontally between fields.
				-- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
				-- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
				jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
				jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
				jump_next_row = { "<Enter>", mode = { "n", "v" } },
				jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
			},
		},
		cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	},

	-- ### Lua
	-- Faster LuaLS setup for Neovim
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		dependencies = {
			{'gonstoll/wezterm-types', lazy = true},
		},
		opts = {
			library = {
				{ vim.api.nvim_get_runtime_file("", true) },
				{ path = "wezterm-types", mods = {"wezterm"} },
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				-- { path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}

