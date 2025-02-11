---@type LazySpec
return {
	-- nvim-lspconfig is a "data only" repo, providing basic, default Nvim LSP client configurations for various LSP servers.
	'neovim/nvim-lspconfig',

	-- Neovim plugin to manage global and project-local settings 
	{ 'folke/neoconf.nvim',
		main = 'neoconf',
		opts = {},
		-- should be run before nvim-lspconfig
		priority = 100,
		lazy = false,
	},

	-- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters. 
	{ 'williamboman/mason.nvim',
		name = 'mason',
		build = function()
			pcall(vim.cmd, 'MasonUpdate')
		end,
		config = true,
		enabled = false,
	},
	{ 'williamboman/mason-lspconfig',
		opts = {
			ensure_installed = {
				'lua_ls', 'vimls',
				'lemminx', 'jsonls', 'yamlls', 'taplo',
				'bashls',
			},
			handlers = {
				function(server_name)
					require('lspconfig')[server_name].setup({})
				end,
			},
		},
		after = {
		'mason',
			'nvim-cmp',
			'hrsh7th/cmp-nvim-lsp',
		},
		enabled = false,
	},

	{
		"dundalek/lazy-lsp.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		opts = {
			prefer_local = false
		},
	},

	-- A completion plugin for neovim coded in Lua. 
	{ 'hrsh7th/nvim-cmp',
		name = 'nvim-cmp',
		dependencies = {
			'onsails/lspkind.nvim',
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
				init = function()
					require("luasnip.loaders.from_snipmate").lazy_load()
				end,
			},
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'delphinus/cmp-ctags',
			'mtoohey31/cmp-fish',
		},
		config = function()
			local cmp = require('cmp')
			local lspkind = require("lspkind")

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
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
				mapping = {
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
					-- ['<C-Space>'] = cmp.mapping.complete(),
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
				},
				formatting = {
					format = lspkind.cmp_format()
				},
			}
		end
	},

	-- 💫 Extensible UI for Neovim notifications and LSP progress messages. 
	{ "j-hui/fidget.nvim",
		opts = {}
	},

	-- LSP signature hint as you type 
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts) require'lsp_signature'.setup(opts) end
	},

	-- VSCode 💡 for neovim's built-in LSP. 
	{ "kosayoda/nvim-lightbulb",
		opts = {
			autocmd = { enabled = true }
		},
	},
}
