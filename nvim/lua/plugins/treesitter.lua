---@type LazySpec
return {
	{ 'nvim-treesitter/nvim-treesitter',
		build = ":TSUpdate",
		opts = {
			auto_install = true,
			ensure_installed = {
				"lua", 'luadoc', 'vim', "vimdoc",
				'json', "jsonc", 'markdown', 'yaml', 'toml',
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
		end,
	},

	{ 'HiPhish/rainbow-delimiters.nvim' },

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
