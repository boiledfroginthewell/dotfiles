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

	{
		"jake-stewart/auto-cmdheight.nvim",
		lazy = false,
		opts = {}
	},

	{
		"Hajime-Suzuki/vuffers.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		after = function ()
			vim.api.nvim_create_autocmd("SessionLoadPost", {
				callback = function()
					require("vuffers").on_session_loaded()
				end,
			})
		end,
		init = function()
			vim.api.nvim_create_user_command("Vuffers", function(args)
				require("vuffers")[args.fargs[1]]()
			end, {
				nargs = "+"
			})
		end,
		opts = {
			handlers = {
				-- when deleting a buffer via vuffers list (by default triggered by "d" key)
				on_delete_buffer = function(bufnr)
					vim.api.nvim_command(":bwipeout " .. bufnr)
				end,
			},
			keymaps = {
				view = {
					open = "<CR>",
					delete = "k",
					pin = "p",
					unpin = "P",
					rename = "r",
					reset_custom_display_name = "R",
					reset_custom_display_names = "<leader>R",
					move_up = "U",
					move_down = "D",
					move_to = "i",
				},
			},
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
			smear_to_cmd = false,
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

	-- The fastest Neovim colorizer.
	"norcalli/nvim-colorizer.lua",

}
