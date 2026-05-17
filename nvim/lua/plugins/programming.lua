---@type LazySpec
return {
	{ 'NMAC427/guess-indent.nvim',
		config = function ()
			-- https://github.com/NMAC427/guess-indent.nvim/issues/3
			require("guess-indent").setup({autocmd = false})
			vim.cmd([[ autocmd BufReadPost * :silent GuessIndent ]])
		end,
		lazy = false,
	},

	-- sleuth.vim: Heuristically set buffer options
	-- "tpope/vim-sleuth",

	-- An all in one plugin for converting text case in Neovim
	{
		"johmsalas/text-case.nvim",
		config = true
	},

	-- A plugin to visualise and resolve merge conflicts in neovim
	{ 'akinsho/git-conflict.nvim',
		version = "*",
		opts = {
			highlights = {
				current = 'DiffDelete',
			},
		},
	},

	{ "kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		init = function ()
			vim.g.lazygit_floating_window_scaling_factor = 0.94
		end,
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
		},
		enabled = false,
	},

	{ "tpope/vim-fugitive",
		event = "VeryLazy",
	},

	-- Diff between multiple git commits, similar to jetbrains git log.
	{
		"Salanoid/gitlogdiff.nvim",
		main = "gitlogdiff",
		dependencies = {
			"sindrets/diffview.nvim",
			"folke/snacks.nvim",
		},
		cmd = "GitLogDiff",
		opts = { max_count = 300 },
	},

	{ 'sbdchd/vim-shebang',
		init = function()
			vim.g["shebang#shebangs"] = {
				sh = '#!/bin/bash',
				bash = '#!/bin/bash',
				javascript = '#!/usr/bin/env node',
			}
		end,
		keys = {
			{ "<leader>#", function()
				vim.cmd(":ShebangInsert")
				vim.cmd(":update")
				vim.cmd(":! chmod u+x %")
			end, desc = 'Shebang Insert' },
		},
	},

	-- Neovim plugin for a code outline window
	{ 'stevearc/aerial.nvim',
		dependencies = {
			{
				"echasnovski/mini.icons",
				opts = {
					lsp = {
						["function"] = { glyph = '󰊕', hl = 'MiniIconsAzure' },
					},
				},
			},
		},
		lazy = false,
		opts = {
			layout = {
				placement = "edge",
				min_width = 20,
				max_width = { 40, 0.25 },
				win_opts = { fillchars = "eob: "},
			},
			show_guides = true,
			-- open_automatic = true,
			-- close_automatic_events = { "unfocus", "switch_buffer", "unsupported" },
			keymaps = {
				["l"] = false,
				["n"] = "actions.tree_open",
				["L"] = false,
				["N"] = "actions.tree_open_recursive",
				["h"] = false,
				["d"] = "actions.tree_close",
				["H"] = false,
				["D"] = "actions.tree_close_recursive",
			},
			filter_kind = {
				"Class",
				"Constructor",
				"Enum",
				"Function",
				"Interface",
				"Module",
				"Package",
				"Method",
				"Struct",
			},
			---@module "aerial"
			---@param bufnr integer
			---@param item aerial.Symbol
			---@param ctx {backend_name: string, lang: {name: string, parser: string}, symbols?: any, symbol?: any, syntax_tree?: any, match?: any}
			---  A record containing the following fields:
			---  * backend_name: treesitter, lsp, man...
			---  * lang: info about the language
			---  * symbols?: specific to the lsp backend
			---  * symbol?: specific to the lsp backend
			---  * syntax_tree?: specific to the treesitter backend
			---  * match?: specific to the treesitter backend, TS query match
			post_parse_symbol = function(bufnr, item, ctx)
				local file_path = vim.api.nvim_buf_get_name(bufnr)
				if (
					ctx.match ~= nil
					and (
						file_path:match("/lua/plugins/.*%.lua$")
						or file_path:match("Taskfile%.ya?ml$")
					)
				) then
					return ctx.match.custom_outline ~= nil
				end
				return true
			end,
		},
		cmd = {
			"AerialToggle",
		},
		keys = {
			{ "<F8>", "<cmd>AerialToggle!<cr>", desc = "Outline" },
			{ "[a", "<cmd>AerialPrev<cr>" },
			{ "]a", "<cmd>AerialNext<cr>" },
		},
	},

	{ 'chaoren/vim-wordmotion',
		event = "VeryLazy",
		init = function()
			vim.g.wordmotion_nomap = 1
			vim.g.wordmotion_spaces = '_-.'
		end,
		keys = {
			{ "e",  "<Plug>WordMotion_w" },
			{ "w",  "<Plug>WordMotion_e" },
			{ "b",  "<Plug>WordMotion_b" },
			-- { "b",  "<Plug>WordMotion_ge" },
			{ "e",  "<Plug>WordMotion_e", mode = { "o", "v" } },
			{ "w",  "<Plug>WordMotion_w", mode = { "o", "v" } },
			{ "b",  "<Plug>WordMotion_b", mode = { "o", "v" } },
			{ "ge", "e" },
			{ "gw", "w" },
			{ "gb", "b" },
		},
	},

	-- enhanced increment/decrement plugin for Neovim. 
	{ 'monaqa/dial.nvim',
		keys = {
			{ "<C-a>", "<Plug>(dial-increment)", mode = { "n", "v" } },
			{ "<C-x>", "<Plug>(dial-decrement)", mode = { "n", "v" } },
		},
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group{
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.bool,
					augend.constant.new {
						elements = { "True", "False" },
						word = true,
						cyclic = true,
					},
					augend.constant.new {
						elements = { "==", "!=" },
						word = true,
						cyclic = true,
					},
					augend.semver.alias.semver,
				},
			}
		end,
	},

	{ 'mfussenegger/nvim-lint',
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				python = { "mypy" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},

	-- Free, ultrafast Copilot alternative for Vim and Neovim
	{"Exafunction/windsurf.vim",
		event = 'BufEnter',
		config = function ()
			vim.g.codeium_no_map_tab = true
			vim.g.codeium_filetypes = {
				sh = false,
				dotenv = false,
				env = false,
			}
			vim.keymap.set("i", "<M-Down>", function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
			-- vim.keymap.set("i", "<C-Up>", function() return vim.fn['codeium#Complete']() end, { expr = true, silent = true })
			-- vim.keymap.set("i", "<C-f>", function() return vim.fn['codeium#AcceptNextWord']() end, { expr = true, silent = true })
			vim.keymap.set("i", "<M-f>", function() return vim.fn['codeium#AcceptNextWord']() end, { expr = true, silent = true })
			vim.keymap.set("i", "<M-n>", function() return vim.fn['codeium#AcceptNextLine']() end, { expr = true, silent = true })
			-- vim.keymap.set("i", "<C-l>", function() return vim.fn['codeium#AcceptNextLine']() end, { expr = true, silent = true })
		end,
		enabled = vim.fn.has('mac') == 0,
		cond = vim.fn.has('mac') == 0,
	},

	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"echasnovski/mini.diff",
				config = function()
					local diff = require("mini.diff")
					diff.setup({
						-- Disabled by default
						source = diff.gen_source.none(),
					})
				end,
			},
			{
				"MeanderingProgrammer/render-markdown.nvim",
				ft = { "codecompanion" }
			},
		},
		opts = {
			-- NOTE: The log_level is in `opts.opts`
			opts = {
				log_level = "DEBUG", -- or "TRACE"
			},
		},
		keys = {
			{ "<M-a><M-c>",
				function ()
					local codeCompanion = require("codecompanion")
					if vim.bo.filetype == "codecompanion" then
						codeCompanion.close_last_chat()
					elseif codeCompanion.last_chat() == nil then
						codeCompanion.chat()
					else
						codeCompanion.toggle()
					end
				end,
				mode = {"n"}
			},
			{ "<M-a><M-c>", ":CodeCompanion ", mode = {"v"} },
		}
	},
}
