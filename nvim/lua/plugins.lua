require("copies/lazynvim")
require("lazy").setup({
	-- UI Plugins
	-- ====================

	-- Color Theme
	{'sainnhe/sonokai', priority = 1000},
	{'glepnir/zephyr-nvim', priority = 1000},

	{'levouh/tint.nvim',
		config = true,
	},

	-- A fancy, configurable, notification manager for NeoVim
	{ 'rcarriga/nvim-notify',
		config = function()
			require('notify').setup({})
			vim.notify = require('notify')
		end,
	},

	-- Indent guides for Neovim
	{ "lukas-reineke/indent-blankline.nvim",
		init = function()
			vim.opt.list = true
			vim.opt.listchars = {
				-- '␣', '⍽'
				lead = '⋅',
				trail = '⋅',
				-- '│ ', '↠ ', '⇥ ', '↦ ', '⇀ ', '⇢ ',
				tab = '↦ ',
				-- nbsp = '▫',
			}
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
	{ 'rbtnn/vim-ambiwidth',
		init = function()
			vim.opt.ambiwidth = 'single'
		end,
	},

	-- Vim plugin: Make blockwise Visual mode more useful
	'kana/vim-niceblock',

	-- Configure commands not to be registered in the command-line history
	{ 'yutkat/history-ignore.nvim', },

	-- This neovim plugin creates missing folders on save.
	'jghauser/mkdir.nvim',

	{ 'embear/vim-localvimrc',
		init = function()
			vim.g.localvimrc_ask = 0
			vim.g.localvimrc_sandbox = 0
			vim.g.localvimrc_persistent = 1
		end,
	},

	{ 'vim-scripts/ShowMarks',
		init = function()
			vim.g.showmarks_include = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
		end,
	},

	{ "lewis6991/gitsigns.nvim",
		opts = {
			-- signcolumn = true
			signs = {
				add = { text = '+' },
			},
			attach_to_untracked = false,
			on_attach = require('copies/gitsigns-keymaps').on_attach,
		},
	},

	-- A snazzy bufferline for Neovim
	{ 'akinsho/bufferline.nvim',
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
	{ 'kwkarlwang/bufjump.nvim',
		opts = {
			forward = 'g<c-i>',
			backward = 'g<c-o>',
		},
	},

	-- Neovim plugin for locking a buffer to a window
	{ 'stevearc/stickybuf.nvim',
		init = function()
			vim.api.nvim_create_autocmd('FileType', {
				pattern = { 'help', 'qf', 'cheatsheet' },
				callback = function()
					local stickybuf = require("stickybuf")
					-- if not stickybuf.is_pinned() and (vim.wo.winfixwidth or vim.wo.winfixheight) then
					stickybuf.pin()
					-- end
				end
			})
		end,
		config = true,
		enabled = false,
	},

	{ 'ojroques/nvim-bufdel',
		keys = {
			{ "BD", "<cmd>:BufDel<CR>", desc = "Buffer Delete" },
			{ "BN", "<cmd>:bn<CR>",     desc = "Buffer next" },
			{ "BP", "<cmd>:bp<CR>",     desc = "Buffer previous" },
		},
	},

	-- Better quickfix window in Neovim, polish old quickfix window.
	"kevinhwang91/nvim-bqf",

	{ "folke/which-key.nvim",
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
					y = 'Yank',
					c = 'Change',
					k = 'Kill',
					['>'] = 'Indent',
					['<'] = 'Indent'
				},
				triggers_blacklist = {
				},
				triggers_nowait = {},
			})
		end,
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
			{ "ks",  "<Plug>Dsurround" },
			{ "cs",  "<Plug>Csurround" },
			{ "cS",  "<Plug>CSurround" },
			{ "ys",  "<Plug>Ysurround" },
			{ "yS",  "<Plug>YSurround" },
			{ "yss", "<Plug>Yssurround" },
			{ "ySs", "<Plug>YSsurround" },
			{ "ySS", "<Plug>YSsurround" },
			{ "S",   "<Plug>VSurround",  mode = 'x' },
			{ "gS",  "<Plug>VgSurround", mode = 'x' },
		},
	},

	-- vim-textobj-user - Create your own text objects
	{'kana/vim-textobj-user',
		init = function()
			vim.api.nvim_create_autocmd(
			'VimEnter', {
				callback = function(ev)
					-- vim.api.nvim_call_function(
					-- 	'textobj#user#plugin',
					-- 	{
					-- 		'spaces',
					-- 		-- {
					-- 		-- 	space = {
					-- 		-- 		pattern = {' ', ' '},
					-- 		-- 		['select-a'] = 'a<space>',
					-- 		-- 		['select-i'] = 'i<space>',
					-- 		-- 	},
					-- 		-- }}
					-- 		{
					-- 			['spacea'] = {
					-- 				-- pattern = '\\s*\\S+\\s*',
					-- 				pattern = ' \\S+ ',
					-- 				select = 'a<Space>',
					-- 				scan = 'cursor',
					-- 			},
					-- 			['spacei'] = {
					-- 				pattern = '[^ \t]+',
					-- 				select = 'i<Space>',
					-- 				scan = 'line',
					-- 			}
					-- 		}
					-- 	}
					-- )
					vim.cmd[[
						call textobj#user#plugin('spaces', {
							\   'space-a': {
							\     'pattern': '\s*\S\+\s*',
							\     'select': 'a<Space>',
							\     'scan': 'cursor',
							\   },
							\   'space-i': {
							\     'pattern': '[^ \t]\+',
							\     'select': 'i<Space>',
							\     'scan': 'line',
							\   }
							\ })
					]]
				end
			})
		end,
	},

	{'beloglazov/vim-textobj-quotes',
		dependencies = {
			'kana/vim-textobj-user',
		},
	},

	{"chrisgrieser/nvim-various-textobjs",
	},

	-- Neovim motions on speed!
	{ 'phaazon/hop.nvim',
		branch = 'v2',
		opts = {
			keys = 'euoai' .. 'f:l,r.c' .. ';qjkxvzwmby' .. 'dsnth',
			multi_windows = true,
			uppercase_labels = true,
		},
		keys = {
			{ '-', '<cmd>HopWord<cr>' },
		},
	},

	{ "rhysd/clever-f.vim",
		init = function()
			vim.g.clever_f_mark_direct = 1
			vim.g.clever_f_use_migemo = 1
			vim.g.clever_f_not_overwrites_standard_mappings = 1
		end,
		keys = {
			{ ";", "<Plug>(clever-f-repeat-forward)", mode = { 'n', 'v' } },
			{ "j", "<Plug>(clever-f-f)",              mode = { 'n', 'v' } },
			{ "J", "<Plug>(clever-f-F)",              mode = { 'n', 'v' } },
			{ "f", "<Plug>(clever-f-t)",              mode = { 'n', 'v' } },
			{ "F", "<Plug>(clever-f-T)",              mode = { 'n', 'v' } },
		},
	},

	{ 'jeetsukumaran/vim-indentwise',
		init = function ()
			vim.g.indentwise_skip_blanks = 1
			vim.cmd[[
				map <silent><expr> <C-t> indentwise_is_top_level() ?
					\ '{' : '<Plug>(IndentWiseBlockScopeBoundaryBegin)'
				map <silent><expr> <C-h> indentwise_is_top_level() ?
					\ "}" : '<Plug>(IndentWiseBlockScopeBoundaryEnd)'
				function! s:indentwise_is_top_level() abort
					let first_char = getline('.')[0]
					return first_char == '' || first_char =~ '\S'
				endfunction
			]]
		end,
	},

	{'kana/vim-submode',
		config = function ()
			vim.g.submode_timeoutlen = 300
			vim.api.nvim_create_autocmd('VimEnter', {
				callback = function ()
					vim.cmd[[
						let g:submode_keep_leaving_key=1
						call submode#enter_with('tab', 'n', '', 'gt', 'gt')
						call submode#enter_with('tab', 'n', '', 'gT', 'gT')
						call submode#map('tab', 'n', '', 't', 'gt')
						call submode#map('tab', 'n', '', 'T', 'gT')
						call submode#enter_with('window', 'n', '', '<c-w>-', '<c-w>-')
						call submode#enter_with('window', 'n', '', '<c-w>+', '<c-w>+')
						call submode#enter_with('window', 'n', '', '<c-w><', '<c-w><')
						call submode#enter_with('window', 'n', '', '<c-w>>', '<c-w>>')
						call submode#enter_with('window', 'n', '', '<c-w>d', '<c-w>h')
						call submode#enter_with('window', 'n', '', '<c-w>h', '<c-w>j')
						call submode#enter_with('window', 'n', '', '<c-w>t', '<c-w>k')
						call submode#enter_with('window', 'n', '', '<c-w>n', '<c-w>l')
						call submode#map('window', 'n', '', '-', '<c-w>-')
						call submode#map('window', 'n', '', '+', '<c-w>+')
						call submode#map('window', 'n', '', '<', '<c-w><')
						call submode#map('window', 'n', '', '>', '<c-w>>')
						call submode#map('window', 'n', '', 'd', '<c-w>h')
						call submode#map('window', 'n', '', 'h', '<c-w>j')
						call submode#map('window', 'n', '', 't', '<c-w>k')
						call submode#map('window', 'n', '', 'n', '<c-w>l')
						call submode#enter_with('buffer', 'n', '', 'BN', ':bn<cr>')
						call submode#enter_with('buffer', 'n', '', 'BP', ':bp<cr>')
						call submode#map('buffer', 'n', '', 'N', ':bn<cr>')
						call submode#map('buffer', 'n', '', 'P', ':bp<cr>')
					]]
				end
			})
		end,
	},

	-- Hlsearch Lens for Neovim
	{'kevinhwang91/nvim-hlslens',
		enabled = false,
		init = function()
			local kopts = { noremap = true, silent = true }

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
			vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]],
			{ noremap = false, silent = true })
			vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]],
			{ noremap = false, silent = true })
			vim.api.nvim_set_keymap('n', '<esc>', '<Cmd>noh<CR>', kopts)
		end,
		config = true,
	},

	{ "nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ '<leader>e', '<cmd>NeoTreeFocusToggle<cr>', desc = 'NeoTree' },
			-- {'t', 'move_cursor_down'},
		},
	},

	-- fzf heart lua
	{'ibhagwan/fzf-lua',
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>,", ":lua require('fzf-lua').oldfiles()<cr>",     desc = 'Oldfiles' },
			{ "<leader>p", ":lua require('fzf-lua').files()<cr>",        desc = 'Files' },
			{ "<leader>b", ":lua require('fzf-lua').buffers()<cr>",      desc = 'Buffers' },
			{ "<leader>r", ":lua require('fzf-lua').grep_project()<cr>", desc = 'Ripgrep' },
			{ "<leader>c", ":lua require('fzf-lua').commands()<cr>",     desc = 'Command Pallet' },
		},
	},

	-- A neovim lua plugin to help easily manage multiple terminal windows
	{ "akinsho/toggleterm.nvim",
		tag = 'v2.*',
		config = true,
		keys = {
			{ '<F7>', '<cmd>ToggleTerm<cr>', mode = { 'n', 't' } },
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

	-- A small automated session manager for Neovim
	{ 'rmagatti/auto-session',
		opts = {
			log_level = "error",
			auto_session_suppress_dirs = {
				"~/", "~/Projects", "~/Downloads", "/",
			},
		},
	},

	-- Vim plugin for automatic time tracking and metrics generated from your programming activity.
	{ 'wakatime/vim-wakatime',
		enabled = vim.fn.has('mac') == 0,
		cond = vim.fn.has('mac') == 0
	},

	-- Programming Plugins
	-- ======================

	-- sleuth.vim: Heuristically set buffer options
	'tpope/vim-sleuth',

	-- Comment out
	{ 'tyru/caw.vim',
		keys = {
			{ "<c-k>", "<Plug>(caw:hatpos:toggle)", mode = { "n", "v" } },
		},
		enabled = false
	},

	-- A comment toggler for Neovim, written in Lua
	{ 'terrortylor/nvim-comment',
		opts = {
			create_mappings = false,
		},
		keys = {
			{ '<c-k>', '<cmd>CommentToggle<cr>', mode = { 'n' }, silent = true },
			{ '<c-k>', ":CommentToggle<cr>",     mode = { 'v' }, silent = true},
		},
		main = 'nvim_comment',
		lazy = false,
	},

	{ 'sbdchd/vim-shebang',
		init = function()
			vim.g["shebang#shebangs"] = {
				sh = '#!/bin/bash',
				bash = '#!/bin/bash',
			}
		end,
		keys = {
			{ "<leader>#", ":ShebangInsert<CR>", desc = 'Shebang Insert' },
		},
	},

	{ 'majutsushi/tagbar',
		cond = function()
			return vim.fn.executable("ctags")
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
		lazy = false,
	},

	--  A neovim plugin for peeking at tag definitions using the `nvim_open_win` "floating window" feature.
	{ 'semanticart/tag-peek.vim',
		keys = {
			{ '<leader>t', '<cmd>call tag_peek#ShowTag()<CR>', desc = 'Peek tag definition' },
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
			{ "e",  "<Plug>WordMotion_w" },
			{ "w",  "<Plug>WordMotion_e" },
			{ "b",  "<Plug>WordMotion_b" },
			{ "e",  "<Plug>WordMotion_e", mode = { "o" } },
			{ "w",  "<Plug>WordMotion_w", mode = { "o" } },
			{ "b",  "<Plug>WordMotion_b", mode = { "o" } },
			{ "ge", "e" },
			{ "gw", "w" },
			{ "gb", "b" },
		},
		lazy = false,
	},

	-- " 🚀 Run Async Shell Commands in Vim 8.0 / NeoVim and Output to the Quickfix Window !!
	{ 'skywind3000/asyncrun.vim',
		init = function()
			vim.g.asyncrun_open = 12
			vim.g.asyncrun_bell = 1
			vim.g.asyncrun_save = 1
		end,
		keys = {
			{ "<F5>", "<cmd>AsyncRun ./%<CR>" },
		},
	},

	-- ### LSP Plugins

	-- A starting point to setup some lsp related features in neovim.
	{ 'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			'neovim/nvim-lspconfig',
			'onsails/lspkind.nvim',
			{ 'williamboman/mason.nvim',
				build = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
			},
			{ 'williamboman/mason-lspconfig',
				opts = {
					ensure_installed = {
						'lua_ls', 'vimls',
						'lemminx', 'jsonls', 'yamlls', 'taplo',
					},
				},
			},
			'jose-elias-alvarez/null-ls.nvim',
			-- Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
			'folke/neodev.nvim',
			-- Autocompletion
			'hrsh7th/nvim-cmp', -- Required by lsp-zero
			'hrsh7th/cmp-nvim-lsp', -- Required by lsp-zero
			'L3MON4D3/LuaSnip', -- Required by lsp-zero
			{'saadparwaiz1/cmp_luasnip',
				dependencies = {
					{ "L3MON4D3/LuaSnip",
						-- version = "1.*",
						-- install jsregexp (optional!).
						-- build = "make install_jsregexp"
						dependencies = {
							'rafamadriz/friendly-snippets',
							-- 'honza/vim-snippets)',
						}
					},
				},
			},
			'hrsh7th/cmp-buffer',
			'delphinus/cmp-ctags',
			'mtoohey31/cmp-fish',
		},
		config = function()
			-- LSP
			local lsp = require('lsp-zero').preset({
				manage_nvim_cmp = {
					set_basic_mappings = false,
					-- set_extra_mappings = true,
				},
			})

			lsp.on_attach(function(client, bufnr)
				lsp.default_keymaps({ buffer = bufnr })
			end)
			lsp.set_sign_icons({
				info = 'i',
			-- 	warn = '⚠️',
				error = '🔥',
				hint = (vim.fn.has('mac') and '💬') or '🗨️',
			})

			local lspconfig = require('lspconfig')
			lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
			lspconfig.yamlls.setup({
				settings = {
					yaml = {
						keyOrdering = false
					}
				}
			})

			lsp.setup()

			-- Autocompletion
			local cmp = require('cmp')
			local cmp_action = require('lsp-zero').cmp_action()
			-- load friendly snippets
			require('luasnip.loaders.from_vscode').lazy_load()
			-- load my SnipMates
			require('luasnip.loaders.from_snipmate').lazy_load()

			-- customizations
			vim.keymap.set('n', '<F1>', ':lua vim.lsp.buf.hover()<cr>')
			cmp.setup {
				sources = {
					-- basic
					{ name = 'luasnip' },
					{ name = 'buffer' },
					{ name = 'treesitter' },
					{ name = 'ctags'},
					-- nvim/lua
					{ name = 'nvim_lsp' },
					{ name = 'nvim_lua' },
					-- misc
					{ name = 'fish' },
				},
				mapping = {
					-- lsp-zero.preset.manage_nvim_cmop.set_basic_mappings
					['<C-d>'] = cmp.mapping.scroll_docs(4),
					['<C-u>'] = cmp.mapping.scroll_docs(-4),
					['<Up>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
					['<Down>'] = cmp.mapping.select_next_item({behavior = 'select'}),
					-- my custom mappings
					['<PageUp>'] = cmp.mapping.select_prev_item({behavior = 'select', count = 10}),
					['<PageDown>'] = cmp.mapping.select_next_item({behavior = 'select', count = 10}),
					['<CR>'] = cmp.mapping.confirm { select = false },
					['<Tab>'] = cmp_action.luasnip_supertab(),
					['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
					['<C-Space>'] = cmp.mapping.complete(),
					['<ESC>'] = cmp.mapping(function(fallback)
						if cmp.get_selected_entry() ~= nil then
							cmp.abort()
						else
							fallback()
						end
					end),
				},
				formatting = {
					fields = { 'kind', 'abbr', 'menu' },
					-- format = require('lspkind').cmp_format({
					-- 	mode = 'symbol', -- show only symbol annotations
					-- 	maxwidth = 80, -- prevent the popup from showing more than provided characters
					-- 	ellipsis_char = ' ⃨', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
					-- })

					-- format = function(entry, vim_item)
					-- 	if vim.tbl_contains({ 'path' }, entry.source.name) then
					-- 		local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
					-- 		if icon then
					-- 			vim_item.kind = icon
					-- 			vim_item.kind_hl_group = hl_group
					-- 			return vim_item
					-- 		end
					-- 	end
					-- 	return require('lspkind').cmp_format({ with_text = false })(entry, vim_item)
					-- end

					format = function(entry, vim_item)
						local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"
					
						return kind
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				}
			}

			-- null-ls
			local null_ls = require('null-ls')
			null_ls.setup({
				diagnostics_format = "#{m} (#{s}: #{c})",
				sources = {
					-- Replace these with the tools you have installed
					--	 null_ls.builtins.formatting.prettier,
					--	 null_ls.builtins.diagnostics.eslint,
					null_ls.builtins.formatting.stylua,
				}
			})
		end
	},

	{ 'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'HiPhish/nvim-ts-rainbow2',
		},
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"lua", 'luadoc', 'vim', "vimdoc",
				'json', 'markdown', 'yaml', 'toml',
				'bash', "fish",
				'python',
			},
			highlight = { enable = true },
		},
		config = function(lazyPlugin, opts)
			require('nvim-treesitter.configs').setup(opts)
			vim.treesitter.language.register('sql', 'hive')
			vim.treesitter.language.register('html', 'xml')

			require('nvim-treesitter.configs').setup {
			rainbow = {
				enable = true,
				-- disable = { 'jsx', 'cpp' },
				-- Which query to use for finding delimiters
				query = 'rainbow-parens',
				-- Highlight the entire buffer all at once
				strategy = require('ts-rainbow').strategy.global,
			}
			}
		end,
	},

	{ 'nvim-treesitter/nvim-treesitter-textobjects',
		dependencies = { "nvim-treesitter/nvim-treesitter" },
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

	-- A Neovim plugin to deal with treesitter units
	{ 'David-Kunz/treesitter-unit',
		config = function()
			vim.api.nvim_set_keymap('x', 'iu', ':lua require"treesitter-unit".select()<CR>',
			{ noremap = true, desc = 'Treesitter Unit' })
			vim.api.nvim_set_keymap('x', 'au', ':lua require"treesitter-unit".select(true)<CR>',
			{ noremap = true, desc = 'Treesitter unit' })
			vim.api.nvim_set_keymap('o', 'iu', ':<c-u>lua require"treesitter-unit".select()<CR>', { noremap = true })
			vim.api.nvim_set_keymap('o', 'au', ':<c-u>lua require"treesitter-unit".select(true)<CR>', { noremap = true })
		end
	},


	-- Language specific plugins
	------------------------------

	-- Vim editing support for kmonad config files
	{ 'kmonad/kmonad-vim',
		ft = 'kbd',
	},

	-- ### Linux
	-- 'wgwoods/vim-systemd-syntax',

	-- For plugins.lua (lazy.nvim)
	{ 'tyru/open-browser.vim',
		keys = {
			{
				"git",
				function()
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
})

vim.cmd[[colorscheme desert]]
vim.cmd[[highlight NonText guibg=none]]
-- vim.cmd[[colorscheme habamax]]

