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

	{ 'HiPhish/rainbow-delimiters.nvim' },

	-- Extend and create a/i textobjects
	{ 'nvim-mini/mini.ai',
		version = false,
		dependencies = {
			-- https://github.com/nvim-mini/mini.nvim/issues/1958
			{
				'nvim-treesitter/nvim-treesitter-textobjects',
				branch = "main",
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
					---@param ai_type `a` | `i`
					C = function(ai_type)
						---@param line integer
						local is_comment = function(line)
							local line_content = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
							if not line_content or line_content:match("^%s*$") then return false end
							local _, last_space = line_content:find("^%s*")
							local captures = vim.treesitter.get_captures_at_pos(0, line - 1, last_space)
							for _, cap in ipairs(captures) do
								if cap.capture == "comment" then return true end
							end
							return false
						end

						local cur_line = vim.api.nvim_win_get_cursor(0)[1]
						if not is_comment(cur_line) then return nil end

						local from_line, to_line = cur_line, cur_line
						while from_line > 1 and is_comment(from_line - 1) do
							from_line = from_line - 1
						end
						local buf_line_count = vim.api.nvim_buf_line_count(0)
						while to_line < buf_line_count and is_comment(to_line + 1) do
							to_line = to_line + 1
						end

						return {
							from = { line = from_line, col = 1 },
							to = { line = to_line, col = #vim.api.nvim_buf_get_lines(0, to_line - 1, to_line, true)[1] },
							vis_mode = "V",
						}
					end,
				}
			}
		end,
	},

}
