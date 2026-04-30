---@type LazySpec
return {

	-- A lightweight Tree-sitter parser manager for Neovim.
	{
		"romus204/tree-sitter-manager.nvim",
		dependencies = {}, -- tree-sitter CLI must be installed system-wide
		opts = {
			auto_install = true,
			-- use_repo_queries = true,
			ensure_installed = {
				"lua", 'luadoc', 'vim', "vimdoc",
				"git_config",
				"dockerfile",
				'markdown', "markdown_inline",
				'json', 'yaml', 'toml',
				'bash', "fish",
				'python',
				"sql"
			},
			languages = {
				dotenv = {
					install_info = {
						url = "https://github.com/pnx/tree-sitter-dotenv",
					}
				}
			}
		},
	},

	-- { 'HiPhish/rainbow-delimiters.nvim' },

	-- Extend and create a/i textobjects
	{ 'nvim-mini/mini.ai',
		version = false,
		dependencies = {
			-- https://github.com/nvim-mini/mini.nvim/issues/1958
			{
				'nvim-treesitter/nvim-treesitter-textobjects',
				branch = "main",
				dependencies = {
					"nvim-treesitter/nvim-treesitter",
					branch = "main",
				},
			}
		},
		opts = function()
			local gen_spec = require('mini.ai').gen_spec
			return {
				search_method = "cover",
				custom_textobjects = {
					-- ['<space>'] = gen_spec.pair('^%s', "%s$"),
					-- f = false,
					f = gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
					a = gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
					c = gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
					B = gen_spec.treesitter({ a = '@block.outer', i = '@block.inner' }),
				}
			}
		end,
	},

}
