require("opt/lazynvim")
require("lazy").setup({
	-- UI Plugins
	-- ====================

	-- Color Theme
	{'folke/tokyonight.nvim',
		priority = 1000,
		config = function()
			vim.cmd[[colorscheme tokyonight-moon]]
		end,
		opts = {
			terminal_colors = false,
		},
	},

	-- A fancy, configurable, notification manager for NeoVim 
	{'rcarriga/nvim-notify',
		config = function()
			require('notify').setup({})
			vim.notify = require('notify')
		end,
	},

	-- Indent guides for Neovim 
	{"lukas-reineke/indent-blankline.nvim",
		config = function()
			vim.opt.list = true
			vim.opt.listchars:append('space:⋅')
		end,
		opts = {
			space_char_blankline = " ",
			show_current_context = true,
			show_current_context_start = true,
		},
	},

	-- Basic Editing Plugins
	-- =========================

	 -- This plugin provides a set of setcellwidths() for Vim that the ambiwidth is single. 
	 {'rbtnn/vim-ambiwidth',
		init = function ()
			vim.opt.ambiwidth = 'single'
		end,
	},

	-- Vim plugin: Make blockwise Visual mode more useful
	'kana/vim-niceblock',

	-- Configure commands not to be registered in the command-line history
	{'yutkat/history-ignore.nvim', },

	-- This neovim plugin creates missing folders on save.
	'jghauser/mkdir.nvim',

	{'vim-scripts/ShowMarks',
		init = function()
			vim.g.showmarks_include = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
		end,
	},

	{ "lewis6991/gitsigns.nvim",
		opts = {
			-- signcolumn = true
		},
	},

	-- Extensible Neovim Scrollbar
	"petertriho/nvim-scrollbar",

	-- A snazzy bufferline for Neovim
	{'akinsho/bufferline.nvim',
		version = "v3.*",
		dependencies = 'nvim-tree/nvim-web-devicons',
		opts = {
			options = {
				buffer_close_icon = '',
				-- separator_style = 'slant',
			},
		},
	},

	-- A neovim plugin that jump to previous and next buffer of the jumplist.
	{'kwkarlwang/bufjump.nvim',
		opts = {
			forward = 'g<c-o>',
			backward = 'g<c-i>',
		},
	},

	-- Keep buffer dimensions in proportion when terminal window is resized
	"kwkarlwang/bufresize.nvim",

	-- Neovim plugin for locking a buffer to a window 
	{'stevearc/stickybuf.nvim',
		init = function()
			vim.api.nvim_create_autocmd('FileType', {
				pattern = {'help', 'qf', 'cheatsheet'},
				callback = function()
					local stickybuf = require("stickybuf")
					-- if not stickybuf.is_pinned() and (vim.wo.winfixwidth or vim.wo.winfixheight) then
						stickybuf.pin()
					-- end
				end
			})
		end,
		config = true,
	},

	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
			require("which-key").setup({
				plugins = {
					presets = {
						motions = false,
						operators = false,
					},
				},
				operators = {
					y='Yank', c='Change', k='Kill',
					['>']='Indent', ['<']='Indent'
				},
				triggers_blacklist = {
				},
				triggers_nowait = {},
			})
		end,
	},

	{ "nvim-neo-tree/neo-tree.nvim",
			branch = "v2.x",
			dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		}
	},

	-- Improved vim spelling plugin (with camel case support)! 
	{ 'kamykn/spelunker.vim',
		init = function()
			vim.g.enable_spelunker_vim_on_readonly = 1
			vim.g.spelunker_target_min_char_len = 3
		end,
	},

	-- quoting/parenthesizing made simple
	{ 'tpope/vim-surround',
		init = function()
			vim.g.surround_no_mappings = 1
		end,
		keys = {
			{"ks", "<Plug>Dsurround" },
			{"cs", "<Plug>Csurround" },
			{"cS", "<Plug>CSurround" },
			{"ys", "<Plug>Ysurround" },
			{"yS", "<Plug>YSurround" },
			{"yss", "<Plug>Yssurround" },
			{"ySs", "<Plug>YSsurround" },
			{"ySS", "<Plug>YSsurround" },
			{"S", "<Plug>VSurround", mode = 'x' },
			{"gS", "<Plug>VgSurround", mode = 'x' },
		},
	},

	-- vim-textobj-user - Create your own text objects
	-- 'kana/vim-textobj-user',
	-- 'inkarkat/argtextobj.vim',
	-- 'thalesmello/vim-textobj-methodcall',

	-- Vim motions on speed!
	{ 'easymotion/vim-easymotion',
		init = function()
			vim.g.EasyMotion_do_mapping = 0
			vim.g.EasyMotion_use_upper = 1
			vim.g.EasyMotion_keys =
				'EUOAI' ..
				'F:L,R.C' ..
				'234789' ..
				';QJKXVZWMBY' ..
				'DSNTH'
			vim.g.EasyMotion_enter_jump_first = 1
			vim.g.EasyMotion_add_search_history = 0
			vim.g.EasyMotion_off_screen_search = 0
			-- if has('mac')
				-- nmap - <Plug>(easymotion-bd-w)
			-- else
				-- nmap - <Plug>(easymotion-overwin-w)
			-- endif
		end,
		keys = {
			{ "-", "<Plug>(easymotion-overwin-w)" },
		},
	},

	-- Hlsearch Lens for Neovim
	{'kevinhwang91/nvim-hlslens',
		enabled = false,
		init = function()
			local kopts = {noremap = true, silent = true}

			vim.api.nvim_set_keymap(
				'n', 'l',
					[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts
			)
			vim.api.nvim_set_keymap(
				'n', 'L',
				[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts
			)
			vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], {noremap = false, silent = true})
			vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], {noremap = false, silent = true})
			vim.api.nvim_set_keymap('n', '<esc>', '<Cmd>noh<CR>', kopts)
		end,
		config = true,
	},

	-- fzf heart lua
	{'ibhagwan/fzf-lua',
		dependencies = {"nvim-tree/nvim-web-devicons"},
		keys = {
			{"<leader>,", ":lua require('fzf-lua').files()<cr>", desc='Files'},
			{"<leader>o", ":lua require('fzf-lua').oldfiles()<cr>", desc='Oldfiles'},
			{"<leader>b", ":lua require('fzf-lua').buffers()<cr>", desc='Buffers'},
			{"<leader>r", ":lua require('fzf-lua').grep_project()<cr>", desc='Ripgrep'},
			{"<leader>c", ":lua require('fzf-lua').commands()<cr>", desc='Command Pallet'},
		},
	},

	-- A neovim lua plugin to help easily manage multiple terminal windows 
	{ "akinsho/toggleterm.nvim",
		tag = 'v2.*',
		config = true,
		keys = {
			{'<F7>', '<cmd>ToggleTerm<cr>', mode = {'n', 't'}},
		},
		opts = {
			size = 10,
			open_mapping = nil,
			shading_factor = 2,
			direction = "float",
			float_opts = {
			border = "curved",
			highlights = { border = "Normal", background = "Normal" },
			},
		},
	},

	-- A Vim plugin for more pleasant editing on commit messages 
	"rhysd/committia.vim",


	-- Programming Plugins
	-- ======================

	-- A small automated session manager for Neovim 
	{'rmagatti/auto-session',
		opts = {
			log_level = "error",
			auto_session_suppress_dirs = {
				"~/", "~/Projects", "~/Downloads", "/",
			},
		},
	},

	-- sleuth.vim: Heuristically set buffer options
	'tpope/vim-sleuth',

	-- A starting point to setup some lsp related features in neovim. 
	{ 'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			{'neovim/nvim-lspconfig'},
			{ 'williamboman/mason.nvim',
				build = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
			},
			{'williamboman/mason-lspconfig',
				opts = {
					ensure_installed = {
						'lua_ls',
					},
				},
			},
			-- Autocompletion
			{'hrsh7th/nvim-cmp'},		-- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},		-- Required
		},
		config = function()
			local lsp = require('lsp-zero').preset({})

			lsp.on_attach(function(client, bufnr)
				lsp.default_keymaps({buffer = bufnr})
			end)

			-- (Optional) Configure lua language server for neovim
			require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

			lsp.setup()

			-- customizations
			vim.keymap.set('n', '<F1>', ':lua vim.lsp.buf.hover()<cr>')
		end
	},

	{ 'nvim-treesitter/nvim-treesitter',
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"lua", 'luadoc', 'vim', "vimdoc",
				'json', 'markdown', 'yaml', 'toml', 'xml', 
				'bash', "fish",
				'python',
			},
			highlight = {enable = true },
		},
	},

	{'nvim-treesitter/nvim-treesitter-textobjects',
		dependencies = {"nvim-treesitter/nvim-treesitter"},
		main = 'nvim-treesitter.configs',
		opts = {
			textobjects = {
				select = {
					enable = true,
					keymaps = {
						ia = '@parameter.inner',
						aa = '@parameter.inner',
					},
				},
			},
		},
	},

	-- Comment out
	{ 'tyru/caw.vim',
		keys = {
			{ "<c-k>", "<Plug>(caw:hatpos:toggle)", mode = {"n", "v"}},
		},
	},

	{ 'sbdchd/vim-shebang',
		init = function()
			vim.g["shebang#shebangs"] = {
				sh='#!/bin/bash',
				bash='#!/bin/bash',
			}
		end,
		keys = {
			{"<leader>#", ":ShebangInsert<CR>", desc='Shebang Insert'},
		},
	},

	{'majutsushi/tagbar',
		cond = function()
			return vim.fn.executable("ctags")
		end,
		init = function()
			vim.g.tagbar_width = 30
			vim.g.tagbar_compact = 1
			vim.g.tagbar_iconchars = {'>', 'V'}
			-- sort by file order
			vim.g.tagbar_sort = 0
		end,
		keys = {
			{"<F8>", ":TagbarToggle<CR>"},
		},
	},

	-- automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching. 
	"RRethy/vim-illuminate",

	{ 'chaoren/vim-wordmotion',
		init = function()
			vim.g.wordmotion_nomap = 1
			vim.g.wordmotion_spaces = '_-.'
		end,
		keys = {
			{ "e", "<Plug>WordMotion_w" },
			{ "w", "<Plug>WordMotion_e" },
			{ "b", "<Plug>WordMotion_b" },
			{ "e", "<Plug>WordMotion_e", mode = {"o"} },
			{ "w", "<Plug>WordMotion_w", mode = {"o"} },
			{ "b", "<Plug>WordMotion_b", mode = {"o"} },
			{ "ge", "e" },
			{ "gw", "w" },
			{ "gb", "b" },
		},
		lazy = false,
	},

	{"rhysd/clever-f.vim",
		init = function()
			vim.g.clever_f_mark_direct = 1
			vim.g.clever_f_use_migemo = 1
			vim.g.clever_f_not_overwrites_standard_mappings = 1
		end,
		keys = {
			{";", "<Plug>(clever-f-repeat-forward)" },
			-- {",", "<Plug>(clever-f-repeat-back)" },
			{"j", "<Plug>(clever-f-f)" },
			{"J", "<Plug>(clever-f-F)" },
			{"f", "<Plug>(clever-f-t)" },
			{"F", "<Plug>(clever-f-T)" },
		},
	},

	-- " 🚀 Run Async Shell Commands in Vim 8.0 / NeoVim and Output to the Quickfix Window !!
	{'skywind3000/asyncrun.vim',
		init = function()
			vim.g.asyncrun_open = 12
			vim.g.asyncrun_bell = 1
			vim.g.asyncrun_save = 1
		end,
		keys = {
			{"<F5>", ":AsyncRun ./%<CR>"},
		},
	},

	-- Language specific plugins
	------------------------------

	{'kmonad/kmonad-vim',
		ft = 'kbd',
	},

	-- For neovim
	{'tyru/open-browser.vim',
		keys = {
			{
				"git",
				function ()
					local line = vim.fn.getline('.')
					local projectName = string.gsub(line, '["\'{}, \t]', '')
					vim.notify(
						"Opening \"" .. projectName .. "\"",
						vim.log.levels.INFO,
						{ title = 'open-browser.vim' }
					)
					vim.cmd.OpenBrowser("https://github.com/" .. projectName)
				end,
				desc = 'Open browser for vim plugin under cursor.'
			}
		},
	},

-- }, {
	-- defaults = {
	--	lazy = true
	-- },
})
