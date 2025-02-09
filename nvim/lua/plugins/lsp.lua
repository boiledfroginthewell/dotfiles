---@type LazySpec
return {
	-- Neovim plugin to manage global and project-local settings 
	{ 'folke/neoconf.nvim',
		main = 'neoconf',
		opts = {},
		-- should be run before nvim-lspconfig
		priority = 100,
		lazy = false,
	},

	-- A starting point to setup some lsp related features in neovim.
	{ 'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			'neovim/nvim-lspconfig',
			'onsails/lspkind.nvim',
			{ 'williamboman/mason.nvim',
				name = 'mason',
				build = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
				config = true,
			},
			{ 'williamboman/mason-lspconfig',
				opts = {
					ensure_installed = {
						'lua_ls', 'vimls',
						'lemminx', 'jsonls', 'yamlls', 'taplo',
						'bashls',
					},
				},
				after = { 'mason' },
			},

			-- Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
			'folke/neodev.nvim',
			-- Autocompletion
			'hrsh7th/nvim-cmp', -- Required by lsp-zero
			'hrsh7th/cmp-nvim-lsp', -- Required by lsp-zero
			'L3MON4D3/LuaSnip', -- Required by lsp-zero
			{'saadparwaiz1/cmp_luasnip',
				dependencies = {
					{ "L3MON4D3/LuaSnip",
						version = "v2.*",
						-- install jsregexp (optional!).
						-- build = "make install_jsregexp"
						dependencies = {
							'honza/vim-snippets',
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
				hint = (vim.fn.has('mac') == 1 and '💬') or '🗨️',
			})

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
			  vim.lsp.handlers.hover, { focusable = false }
			)

			local lspconfig = require('lspconfig')
			lspconfig.lua_ls.setup(lsp.nvim_lua_ls({
				settings = {
					Lua = {
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
						},
					},
				},
			}))

			lsp.setup()

			-- Autocompletion
			-- load my SnipMates
			require('luasnip.loaders.from_snipmate').lazy_load()

			-- customizations
			local cmp = require('cmp')
			local cmp_action = require('lsp-zero').cmp_action()
			local diagnostic = function()
				if #vim.diagnostic.get(0, {lnum=vim.api.nvim_win_get_cursor(0)[1]}) ~= 0 then
					vim.diagnostic.open_float()
				else
					vim.lsp.buf.hover()
				end
			end
			vim.keymap.set('n', '<F1>', diagnostic)
			vim.api.nvim_create_autocmd("CursorHold", { callback = function() vim.diagnostic.open_float() end})
			cmp.setup {
				sources = {
					-- nvim/lua
					{ name = 'nvim_lsp' },
					{ name = 'nvim_lua' },
					-- misc
					{ name = 'fish' },
					-- basic
					{ name = 'luasnip' },
					{ name = 'treesitter' },
					{ name = 'buffer' },
					{ name = 'ctags'},
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
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.get_selected_entry() ~= nil then
							cmp.confirm()
						elseif cmp.visible() then
							cmp.select_next_item()
							cmp.confirm()
						else
							fallback()
						end
					end),
					-- ['<Tab>'] = cmp_action.luasnip_supertab(),
					-- ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
					['<C-Space>'] = cmp.mapping.complete(),
					['<ESC>'] = cmp.mapping(function(fallback)
						if cmp.get_selected_entry() ~= nil then
							cmp.confirm()
							fallback()
						else
							fallback()
						end
					end),
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				}
			}
		end
	},
	
	{ 'nvim-treesitter/nvim-treesitter',
		-- dependencies = {
		-- 	'HiPhish/nvim-ts-rainbow2',
		-- },
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

			-- require('nvim-treesitter.configs').setup {
			-- 	rainbow = {
			-- 		enable = true,
			-- 		-- disable = { 'jsx', 'cpp' },
			-- 		-- Which query to use for finding delimiters
			-- 		query = 'rainbow-parens',
			-- 		-- Highlight the entire buffer all at once
			-- 		-- strategy = require('ts-rainbow').strategy.global,
			-- 	}
			-- }
		end,
	},

	{ 'HiPhish/rainbow-delimiters.nvim' },

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

	-- A Neovim plugin that provides a simple way to run and visualize code actions with Telescope.
	{
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			{"nvim-lua/plenary.nvim"},
			{"nvim-telescope/telescope.nvim"},
		},
		event = "LspAttach",
		config = function()
			require('tiny-code-action').setup()
		end,
		keys = {
			{ "<leader>a", "<cmd>lua require('tiny-code-action').code_action()<cr>", desc = "Code Action" },
			{ "<F4>", "<cmd>lua require('tiny-code-action').code_action()<cr>", desc = "Code Action" },
		},
	},
}
