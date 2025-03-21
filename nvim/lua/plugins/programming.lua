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
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
		}
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
				vim.cmd(":ShebangInsert")
				vim.cmd(":! chmod u+x %")
			end, desc = 'Shebang Insert' },
		},
	},

	{ 'majutsushi/tagbar',
		cond = function()
			return vim.fn.executable("ctags") == 1
		end,
		init = function()
			vim.g.tagbar_width = 30
			vim.g.tagbar_compact = 1
			vim.g.tagbar_iconchars = { '>', 'V' }
			-- sort by file order
			vim.g.tagbar_sort = 0
		end,
		keys = {
			{ "<F8>", ":TagbarToggle<CR>" },
		},
	},

	--  A neovim plugin for peeking at tag definitions using the `nvim_open_win` "floating window" feature.
	{ 'semanticart/tag-peek.vim',
		keys = {
			{ '<leader>t', '<cmd>call tag_peek#ShowTag()<CR>', desc = 'Peek tag definition' },
		},
	},

	-- automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
	"RRethy/vim-illuminate",

	{'haringsrob/nvim_context_vt',
		init = function ()
			vim.cmd[[autocmd ColorScheme * highlight ContextVt guifg='#707070']]
		end,
		opts = {
				prefix = '󰨿',
				disable_ft = {'python', 'yaml', 'md', 'markdown'},
				-- highlight = 'SpecialKey',
		},
		enabled = false,
	},

	-- Use the w, e, b motions like a spider. Move by subwords and skip insignificant punctuation.
	{ "chrisgrieser/nvim-spider",
		keys = {
			{ "e", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "x" } },
			{ "w", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "x" } },
			{ "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "x" } },
			{ "e",
				"<cmd>lua require('spider').motion('w', { skipInsignificantPunctuation = false })<CR>",
				mode = { "o" }
			},
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
					augend.semver.alias.semver,
				},
			}
		end,
	},

	{'Exafunction/codeium.vim',
		event = 'BufEnter',
		config = function ()
			vim.g.codeium_filetypes = {
				sh = false,
			}
			vim.keymap.set("i", "<C-Down>", function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
			vim.keymap.set("i", "<C-i>", function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
		end,
		enabled = vim.fn.has('mac') == 0,
		cond = vim.fn.has('mac') == 0,
	},
}
