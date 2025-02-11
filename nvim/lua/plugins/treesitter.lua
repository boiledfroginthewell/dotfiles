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

}
