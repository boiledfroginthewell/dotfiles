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
			excluded_servers = {},
			preferred_servers = {
				html = { "html" },
				python = { "basedpyright", "ruff" },
			},
			-- prefer_local = false
			prefer_local = true
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
		event = "LspAttach",
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

	-- Display references, definitions and implementations of document symbols
	{ "Wansmer/symbol-usage.nvim",
		event = "LspAttach",
		-- config = true,
		opts = function ()
			local SymbolKind = vim.lsp.protocol.SymbolKind
			---@type UserOpts
			return {
				hl = { link = "LspCodeLens" },
				vt_position = "end_of_line",
				kinds = {
					SymbolKind.Class,
					SymbolKind.Method,
					SymbolKind.Field,
					SymbolKind.Enum,
					SymbolKind.Interface,
					SymbolKind.Function,
					SymbolKind.Constant,
				},
				request_pending_text = "󱤤",
				text_format = function(symbol)
					local fragments = {}

					-- Indicator that shows if there are any other symbols in the same line
					local stacked_functions = symbol.stacked_count > 0
							and (' | +%s'):format(symbol.stacked_count)
							or ''

					if symbol.references then
						table.insert(fragments, '' .. symbol.references)
					end

					return table.concat(fragments, ' ') .. stacked_functions
				end
			}
		end
	},

	-- 🚦 A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
}
