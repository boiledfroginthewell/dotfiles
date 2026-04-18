---@type LazySpec
return {
	{ 'nvim-treesitter/nvim-treesitter',
		dependencies = {
			"pnx/tree-sitter-dotenv"
		},
		build = ":TSUpdate",
		branch = "master",
		opts = {
			auto_install = true,
			ensure_installed = {
				"lua", 'luadoc', 'vim', "vimdoc",
				'markdown', "markdown_inline",
				'json', "jsonc", 'yaml', 'toml',
				'bash', "fish",
				'python',
				"sql"
			},
			highlight = { enable = true },
			indent = {
				enable = true,
				disable = { "yaml" }
			},
		},
		config = function(lazyPlugin, opts)
			require('nvim-treesitter.configs').setup(opts)
			vim.treesitter.language.register('sql', 'hive')
			vim.treesitter.language.register('html', 'xml')
			vim.treesitter.language.register('python', 'python3')

			function configureDotEnv()
				local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

				-- Tell treesitter where dotenv parser is located
				parser_config.dotenv = {
					install_info = {
						url = "https://github.com/pnx/tree-sitter-dotenv",
						branch = "main",
						files = { "src/parser.c", "src/scanner.c" },
					},
					filetype = "dotenv",
				}

				-- Associate .env files as "dotenv"
				vim.filetype.add({
					pattern = {
						['%.env'] = 'dotenv',
						['%.env%..+'] = 'dotenv',
					},
				})
			end
			configureDotEnv()

			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		end,
	},

	-- Treesitter parser manager for Neovim
	{ 'lewis6991/ts-install.nvim',
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
		},
		opts = {
			ensure_install = {
				"lua", "luadoc", "vimdoc",
				"markdown", "markdown_inline",
				"json", "jsonc", "yaml", "toml",
				"bash", "fish",
				"python",
			},
			-- ignore_install = {},
			auto_install = true
		}
	},

	{ 'HiPhish/rainbow-delimiters.nvim' },

	'JoosepAlviste/nvim-ts-context-commentstring',

	{ 'RRethy/nvim-treesitter-textsubjects',
		lazy = false,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-textsubjects").configure({
				prev_selection = ',',
				keymaps = {
					['.'] = 'textsubjects-smart',
					['a;'] = 'textsubjects-container-outer',
					['i;'] = 'textsubjects-container-inner',
				},
			})
		end
	},

}
