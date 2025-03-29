---@type LazySpec
return {
	-- Color Theme
	{'glepnir/zephyr-nvim', priority = 1000, lazy = true},
	{'ChristianChiarulli/nvcode-color-schemes.vim', priority = 1000, lazy = true},
	{'ribru17/bamboo.nvim', priority = 1000, lazy = true},
	{"scottmckendry/cyberdream.nvim",
		priority = 1000,
		lazy = true,
		opts = {
			borderless_pickers = false,
			highlights = {
				Comment = { fg = "#91FFFE", bg = "NONE", italic = true },
				-- CursorLine = { bg = "NONE", underline = true},
			},
		},
	},
	{"Mofiqul/vscode.nvim", priority = 1000, lazy = true},
	{"idbrii/vim-sandydune", priority = 1000, lazy = true},
	{"rose-pine/neovim", priority = 1000, lazy = true},

	{'levouh/tint.nvim',
		config = true,
		opts = {
			tint = -50,
			saturation = 0.5
		}
	},

	{ 'johnfrankmorgan/whitespace.nvim',
		opts = {}
	},

	-- Make your nvim window separators colorful
	{ "nvim-zh/colorful-winsep.nvim",
		config = true,
		event = { "WinLeave" },
	},

	{ "sphamba/smear-cursor.nvim",
	  opts = {
			-- cursor_color = "#d3cdc3",
			normal_bg = "#16181a",
			smear_between_neighbor_lines = false,
		},
	},

	-- Extensible Neovim Scrollbar
	{ "petertriho/nvim-scrollbar",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"kevinhwang91/nvim-hlslens",
		},
		init = function()
			vim.api.nvim_set_hl(0, "ScrollbarHandle", { bg = "#7b8496" })
		end,
		opts = {
			excluded_filetypes = {
				"snacks_input",
			},
			handle = {
				blend = 40,
				highlight = "ScrollbarHandle",
			},
			marks = {
				Cursor = {
					text = " ",
					highlight = "ScrollbarHandle",
				}
			}
		},
		config = function(lazy, opts)
			require("scrollbar").setup(opts)
			require("scrollbar.handlers.gitsigns").setup()
			require("scrollbar.handlers.search").setup({
				override_lens = function() end
			})
		end,
	},
}
