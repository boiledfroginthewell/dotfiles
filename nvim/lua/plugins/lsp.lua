---@type LazySpec
return {
	-- nvim-lspconfig is a "data only" repo, providing basic, default Nvim LSP client configurations for various LSP servers.
	{ 'neovim/nvim-lspconfig',
    dependencies = {
			"netmute/ctags-lsp.nvim",
			build = "go install github.com/netmute/ctags-lsp@latest"
		},
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.ctags_lsp.setup({
				filetypes = { "sql", "yaml" }
			})
		end,
	},

	-- Neovim plugin to manage global and project-local settings
	{ 'folke/neoconf.nvim',
		main = 'neoconf',
		opts = {},
		-- should be run before nvim-lspconfig
		priority = 100,
		lazy = false,
	},

	{
		"dundalek/lazy-lsp.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		opts = {
			excluded_servers = {},
			preferred_servers = {
				gitcommit = {},
				markdown = {},
				text = {},
				html = { "html" },
				python = { "basedpyright", "ruff" },
			},
			-- prefer_local = false
			prefer_local = true
		},
	},

	-- Performant, batteries-included completion plugin for Neovim
	{'saghen/blink.cmp',
		version = '1.*',
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				build = "make install_jsregexp",
				dependencies = {
					'honza/vim-snippets',
				},
				init = function()
					require("luasnip.loaders.from_snipmate").lazy_load()
				end,
			},
		},
		after = { 'neovim/nvim-lspconfig' },
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = 'super-tab' },
			completion = { documentation = { auto_show = true } },
			signature = { enabled = true },
			snippets = { preset = "luasnip" },
			cmdline = {
				completion = {
					menu = {
						auto_show = true
					},
					list = {
						selection = {
							preselect = false,
						}
					},
				},
				keymap = {
					preset = "super-tab",
					["<Up>"] = { "select_prev", "fallback" },
					["<Down>"] = { "select_next", "fallback" },
					["<C-d>"] = { "snippet_backward", "fallback" },
					["<C-n>"] = { "snippet_forward", "fallback" },
				}
			}
		},
		opts_extend = { "sources.default" },
		config = function(_, opts)
			local blink = require("blink.cmp")
			blink.setup(opts)
			local lspconfig_defaults = require('lspconfig').util.default_config
			lspconfig_defaults.capabilities = blink.get_lsp_capabilities(lspconfig_defaults.capabilities)
		end,
	},

	-- 💫 Extensible UI for Neovim notifications and LSP progress messages.
	{ "j-hui/fidget.nvim",
		event = "LspAttach",
		opts = {}
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

	{
		'stevearc/conform.nvim',
		opts = {
			formatters_by_ft = {
				python = {
					"ruff_fix", "ruff_format", -- "ruff_organize_import"
				},
			},
			format_on_save = function(bufnr)
				if vim.b[bufnr].conform_enable_autoformat == 1
					or (
						vim.b[bufnr].conform_enable_autoformat ~= 0
						and vim.g.conform_enable_autoformat == 1
					) then
					return { timeout_ms = 500, lsp_format = "fallback", formatters_by_ft ={
						python = { "ruff_fix", "ruff_format" }
					}}
				end
			end,
		},
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				desc = "Format File",
			},
			{
				"g=",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				desc = "Format File",
			},
		},
	},

	-- LSP diagnostics in virtual text at the top right of your screen
	{ "dgagn/diagflow.nvim",
		event = "LspAttach",
		opts = {
			severity_colors = {  -- The highlight groups to use for each diagnostic severity level
				error = "DiagnosticFloatingError",
				warning = "DiagnosticFloatingWarn",
				info = "DiagnosticFloatingInfo",
				hint = "DiagnosticFloatingHint",
			},
			show_sign = true,
			show_borders = true,
			padding_right = 1,
			max_height = 12,
			scope = "line",
			render_event = { "DiagnosticChanged", "CursorMoved", "WinScrolled" },
			format = function(diagnostic)
				return string.format("%s [%s] #%s", diagnostic.message, diagnostic.code, diagnostic.source)
			end,
		},
	},

	{
		'lafarr/hierarchy.nvim',
		opts = {},
		cmd = {
			"FunctionReferences",
		},
		keys = {
			{
				"<leader>H",
				":FunctionReferences<cr>",
				desc = "Hierarchy",
			},
		},
	},

	-- 🚦 A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
	{
		"folke/trouble.nvim",
		opts = {
			modes = {
				lsp_document_symbols = {
					-- https://github.com/folke/trouble.nvim/issues/446
					title = "{hl:Title}Symbols{hl} {count}",
					groups = {},
				}
			},
		},
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
