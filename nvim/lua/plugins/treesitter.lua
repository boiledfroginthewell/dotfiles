---@type LazySpec
return {
	{ 'nvim-treesitter/nvim-treesitter',
		-- dependencies = {
		-- 	'HiPhish/nvim-ts-rainbow2',
		-- },
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"lua", 'luadoc', 'vim', "vimdoc",
				'json', "jsonc", 'markdown', 'yaml', 'toml',
				'bash', "fish",
				'python',
			},
			highlight = { enable = true },
		},
		config = function(lazyPlugin, opts)
			require('nvim-treesitter.configs').setup(opts)
			vim.treesitter.language.register('sql', 'hive')
			vim.treesitter.language.register('html', 'xml')
		end,
	},

	{ 'HiPhish/rainbow-delimiters.nvim' },

	{ 'nvim-treesitter/nvim-treesitter-textobjects',
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		main = 'nvim-treesitter.configs',
		opts = {
			textobjects = {
				select = {
					enable = true,
					keymaps = {
						ia = '@parameter.inner',
						aa = '@parameter.outer',
					},
				},
			},
		},
	},

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
