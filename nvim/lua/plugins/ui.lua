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

	-- Indent guides for Neovim
	{ "lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		init = function()
			vim.opt.list = true
			vim.opt.listchars = {
				-- '␣', '⍽', "⋅"
				lead = '⋅',
				trail = '⋅',
				-- "▏ ", '│ ', '↠ ', '⇥ ', '↦ ', '⇀ ', '⇢ ',
				tab = '│ ',
				nbsp = '▫',
			}

			local function setupHighlight()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
				vim.api.nvim_set_hl(0, "Whitespace", { fg = "grey" })
			end
			setupHighlight()
			local hooks = require "ibl.hooks"
			hooks.register(hooks.type.HIGHLIGHT_SETUP, setupHighlight)
		end,
		opts = {
			indent = {
				highlight = {
					"RainbowRed",
					"RainbowYellow",
					"RainbowBlue",
					"RainbowOrange",
					"RainbowGreen",
					"RainbowViolet",
					"RainbowCyan",
				}
			},
			scope = {
				-- enabled = true,
				enabled = false,
				char = "▎",
				show_start = true,
			}
		},
	},

	-- Neovim plugin to improve the default vim.ui interfaces
	'stevearc/dressing.nvim',
}
