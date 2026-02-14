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
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

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

	-- 🌈 Add animated glow/highlight effects to your neovim operation (undo, redo, yank, paste and more) with simple APIs. Alternatives to highlight-undo.nvim and tiny-glimmer.nvim.
	{
		"y3owk1n/undo-glow.nvim",
		event = { "VeryLazy" },
		---@type UndoGlow.Config
		opts = {
			animation = {
				enabled = true,
				duration = 200,
				animation_type = "zoom",
				window_scoped = true,
			},
			highlights = {
				undo = {
					hl_color = { bg = "#693232" }, -- Dark muted red
				},
				redo = {
					hl_color = { bg = "#2F4640" }, -- Dark muted green
				},
				yank = {
					hl_color = { bg = "#7A683A" }, -- Dark muted yellow
				},
				paste = {
					hl_color = { bg = "#325B5B" }, -- Dark muted cyan
				},
				search = {
					hl_color = { bg = "#5C475C" }, -- Dark muted purple
				},
				comment = {
					hl_color = { bg = "#7A5A3D" }, -- Dark muted orange
				},
				cursor = {
					hl_color = { bg = "#793D54" }, -- Dark muted pink
				},
			},
			priority = 2048 * 3,
		},
		keys = {
			{
				"u",
				function()
					require("undo-glow").undo()
				end,
				mode = "n",
				desc = "Undo with highlight",
				noremap = true,
			},
			{
				"U",
				function()
					require("undo-glow").redo()
				end,
				mode = "n",
				desc = "Redo with highlight",
				noremap = true,
			},
			{
				"p",
				function()
					require("undo-glow").paste_below()
				end,
				mode = "n",
				desc = "Paste below with highlight",
				noremap = true,
			},
			{
				"P",
				function()
					require("undo-glow").paste_above()
				end,
				mode = "n",
				desc = "Paste above with highlight",
				noremap = true,
			},
			{
				"l",
				function()
					require("undo-glow").search_next({
						animation = {
							animation_type = "strobe",
						},
					})
				end,
				mode = "n",
				desc = "Search next with highlight",
				noremap = true,
			},
			{
				"L",
				function()
					require("undo-glow").search_prev({
						animation = {
							animation_type = "strobe",
						},
					})
				end,
				mode = "n",
				desc = "Search prev with highlight",
				noremap = true,
			},
			{
				"*",
				function()
					require("undo-glow").search_star({
						animation = {
							animation_type = "strobe",
						},
					})
				end,
				mode = "n",
				desc = "Search star with highlight",
				noremap = true,
			},
			{
				"#",
				function()
					require("undo-glow").search_hash({
						animation = {
							animation_type = "strobe",
						},
					})
				end,
				mode = "n",
				desc = "Search hash with highlight",
				noremap = true,
			},
			{
				"gc",
				function()
					-- This is an implementation to preserve the cursor position
					local pos = vim.fn.getpos(".")
					vim.schedule(function()
						vim.fn.setpos(".", pos)
					end)
					return require("undo-glow").comment()
				end,
				mode = { "n", "x" },
				desc = "Toggle comment with highlight",
				expr = true,
				noremap = true,
			},
			{
				"gc",
				function()
					require("undo-glow").comment_textobject()
				end,
				mode = "o",
				desc = "Comment textobject with highlight",
				noremap = true,
			},
			{
				"gcc",
				function()
					return require("undo-glow").comment_line()
				end,
				mode = "n",
				desc = "Toggle comment line with highlight",
				expr = true,
				noremap = true,
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("TextYankPost", {
				desc = "Highlight when yanking (copying) text",
				callback = function()
					require("undo-glow").yank()
				end,
			})

			-- This only handles neovim instance and do not highlight when switching panes in tmux
			vim.api.nvim_create_autocmd("CursorMoved", {
				desc = "Highlight when cursor moved significantly",
				callback = function()
					require("undo-glow").cursor_moved({
						animation = {
							animation_type = "slide",
						},
					})
				end,
			})

			-- This will handle highlights when focus gained, including switching panes in tmux
			vim.api.nvim_create_autocmd("FocusGained", {
				desc = "Highlight when focus gained",
				callback = function()
					---@type UndoGlow.CommandOpts
					local opts = {
						animation = {
							animation_type = "slide",
						},
					}

					opts = require("undo-glow.utils").merge_command_opts("UgCursor", opts)
					local pos = require("undo-glow.utils").get_current_cursor_row()

					require("undo-glow").highlight_region(vim.tbl_extend("force", opts, {
						s_row = pos.s_row,
						s_col = pos.s_col,
						e_row = pos.e_row,
						e_col = pos.e_col,
						force_edge = opts.force_edge == nil and true or opts.force_edge,
					}))
				end,
			})

			vim.api.nvim_create_autocmd("CmdlineLeave", {
				desc = "Highlight when search cmdline leave",
				callback = function()
					require("undo-glow").search_cmd({
						animation = {
							animation_type = "fade",
						},
					})
				end,
			})
		end,
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
