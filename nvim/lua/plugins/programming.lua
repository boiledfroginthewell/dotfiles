---@type LazySpec
local spec = {
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
				vim.cmd(":update")
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
		cmd = {
			"TagbarToggle",
		},
		lazy = false,
	},

	-- Neovim plugin for a code outline window
	{ 'stevearc/aerial.nvim',
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons"
		},
		event = "VeryLazy",
		opts = {
			layout = { placement = "edge" },
			lsp = {
				priority = {
					ctags_lsp = 20
				}
			}
		},
		cmd = {
			"AerialToggle",
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

	{'Exafunction/codeium.vim',
		event = 'BufEnter',
		config = function ()
			vim.g.codeium_filetypes = {
				sh = false,
			}
			vim.keymap.set("i", "<C-Down>", function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
			vim.keymap.set("i", "<C-i>", function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
			vim.keymap.set("i", "<C-f>", function() return vim.fn['codeium#AcceptNextWord']() end, { expr = true, silent = true })
		end,
		enabled = vim.fn.has('mac') == 0,
		cond = vim.fn.has('mac') == 0,
	},

	{ 'pwntester/octo.nvim',
		deps = {
			'nvim-lua/plenary.nvim',
			'ibhagwan/fzf-lua',
			'nvim-tree/nvim-web-devicons',
		},
		opts = {
			github_hostname = "",
		},
	},
}

local tagbar_ft = { "sql", "hive" }
vim.keymap.set("n", "<F8>", function ()
	if vim.b[vim.api.nvim_get_current_buf()].prefer_tagbar == 1
			or vim.tbl_contains(tagbar_ft, vim.bo.filetype) then
		vim.cmd[[TagbarToggle]]
	else
		vim.cmd[[AerialToggle!]]
	end
end, {})

return spec
