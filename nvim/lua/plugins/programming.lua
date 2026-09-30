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

	{ "tpope/vim-fugitive",
		event = "VeryLazy",
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
				vim.cmd.ShebangInsert()
				vim.cmd.update()
				local file = vim.api.nvim_buf_get_name(0)
				local uv = vim.uv
				local stat = uv.fs_stat(file)
				if stat then
					local new_mode = bit.bor(bit.band(stat.mode, 0xfff), 0x40)
					local chmod_ok, chmod_err = uv.fs_chmod(file, new_mode)
					if not chmod_ok then
						vim.notify("Failed to make file executable: " .. tostring(chmod_err), vim.log.levels.ERROR)
					end
				end
			end, desc = 'Shebang Insert' },
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
			local dial_config = require("dial.config")
			dial_config.augends:register_group{
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
			-- https://github.com/monaqa/dial.nvim/issues/11#issuecomment-3148778108
			dial_config.augends:on_filetype {
				markdown = {
					augend.user.new {
						find = function(line, cursor)
							if line:find "^%s*[-*] %[[ x]]" == nil then
								return
							end
							local checkbox_start = line:find "%["
							return { from = checkbox_start, to = checkbox_start + 2 }
						end,
						add = function(text, addend, cursor)
							if text == "[ ]" then
								return { text = "[x]" }
							elseif text == "[x]" then
								return { text = "[ ]" }
							end
							return {}
						end,
					},
				},
			}
		end,
	},

	{ 'mfussenegger/nvim-lint',
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				python = { "mypy" },
				javascript = { "eslint" },
				typescript = { "eslint" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					if vim.o.ft ~= "python" or not vim.fn.executable("mypy") then
						lint.try_lint()
					end
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
		  "j-hui/fidget.nvim",
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
		init = function()
			require("copies.fidget-spinner"):init()
		end,
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
