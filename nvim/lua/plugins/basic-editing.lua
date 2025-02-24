---@type LazySpec
return {
	-- This plugin provides a set of setcellwidths() for Vim that the ambiwidth is single.
	{ 'rbtnn/vim-ambiwidth',
		init = function()
			vim.opt.ambiwidth = 'single'
		end,
	},

	-- Vim plugin: Make blockwise Visual mode more useful
	{ 'kana/vim-niceblock',
		event = "VeryLazy",
	},

	-- Handles bracketed-paste-mode in vim (aka. automatic `:set paste`)
	'ConradIrwin/vim-bracketed-paste',

	-- Configure commands not to be registered in the command-line history
	{ 'yutkat/history-ignore.nvim', },

	-- This neovim plugin creates missing folders on save.
	'jghauser/mkdir.nvim',

	{ 'embear/vim-localvimrc',
		init = function()
			vim.g.localvimrc_ask = 0
			vim.g.localvimrc_sandbox = 0
			vim.g.localvimrc_persistent = 1
		end,
	},

	{ 'vim-scripts/ShowMarks',
		init = function()
			vim.g.showmarks_include = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
		end,
		enabled = false,
	},

	-- A better user experience for viewing and interacting with Vim marks. 
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {
			default_mappings = false
		},
		-- enabled = false,
	},

	-- A vim plugin to perform diffs on blocks of code
	{ 'AndrewRadev/linediff.vim',
		lazy = false,
	},

	{ "lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			-- signcolumn = true
			signs = {
				add = { text = '+' },
			},
			attach_to_untracked = false,
			on_attach = require('copies/gitsigns-keymaps').on_attach,
		},
	},

	-- A snazzy bufferline for Neovim
	{ 'akinsho/bufferline.nvim',
		dependencies = 'nvim-tree/nvim-web-devicons',
		opts = {
			options = {
				buffer_close_icon = '',
				-- separator_style = 'slant',
				custom_filter = function(buf_number, buf_numbers)
					-- filter out filetypes you don't want to see
					if vim.bo[buf_number].filetype ~= "qf" then
						return true
					end
				end,
			},
		},
	},

	{
		'stevearc/oil.nvim',
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			win_options = {
				-- for oil-git-status
				signcolumn = "yes:2"
			},
			keymaps = {
				['<BS>'] = { "actions.parent", mode = "n" },
				['<C-s>'] = { ":w<CR>", mode = "n" },
				['_'] = { "$", mode = "n" },
			},
		},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		lazy = false,
	},

	{ "refractalize/oil-git-status.nvim",
		dependencies = {
			"stevearc/oil.nvim",
		},
		config = true,
	},

	-- A neovim plugin that jump to previous and next buffer of the jumplist.
	{ 'kwkarlwang/bufjump.nvim',
		event = "VeryLazy",
		opts = {
			forward = 'g<c-i>',
			backward = 'g<c-o>',
		},
	},

	-- A Neovim plugin to improve buffer deletion
	{ 'ojroques/nvim-bufdel',
		keys = {
			{ "BD", "<cmd>:BufDel<CR>", desc = "Buffer Delete" },
			{ "<a-w>", "<cmd>:BufDel<CR>", desc = "Buffer Delete" },
		},
	},

	-- Better quickfix window in Neovim, polish old quickfix window.
	{ "kevinhwang91/nvim-bqf",
		ft = "qf",
	},

	-- Improved vim spelling plugin (with camel case support)!
	{ 'kamykn/spelunker.vim',
		init = function()
			vim.g.enable_spelunker_vim_on_readonly = 1
			vim.g.spelunker_target_min_char_len = 3
			vim.g.spelunker_check_type = 2
		end,
	},

	{'windwp/nvim-autopairs',
		opts = {
			-- ignored_next_char = 
		},
		enabled = false,
	},

	-- Add/change/delete surrounding delimiter pairs with ease. Written with heart in Lua.
	{ "kylechui/nvim-surround",
		event = "VeryLazy",
		opts = {
			keymaps = {
				delete = 'ks'
			}
		},
	},

	-- vim-textobj-user - Create your own text objects
	{'kana/vim-textobj-user',
		init = function()
			vim.api.nvim_create_autocmd(
			'VimEnter', {
				callback = function(ev)
					-- vim.api.nvim_call_function(
					-- 	'textobj#user#plugin',
					-- 	{
					-- 		'spaces',
					-- 		-- {
					-- 		-- 	space = {
					-- 		-- 		pattern = {' ', ' '},
					-- 		-- 		['select-a'] = 'a<space>',
					-- 		-- 		['select-i'] = 'i<space>',
					-- 		-- 	},
					-- 		-- }}
					-- 		{
					-- 			['spacea'] = {
					-- 				-- pattern = '\\s*\\S+\\s*',
					-- 				pattern = ' \\S+ ',
					-- 				select = 'a<Space>',
					-- 				scan = 'cursor',
					-- 			},
					-- 			['spacei'] = {
					-- 				pattern = '[^ \t]+',
					-- 				select = 'i<Space>',
					-- 				scan = 'line',
					-- 			}
					-- 		}
					-- 	}
					-- )
					vim.cmd[[
						call textobj#user#plugin('spaces', {
							\   'space-a': {
							\     'pattern': '\s*\S\+\s*',
							\     'select': 'a<Space>',
							\     'scan': 'cursor',
							\   },
							\   'space-i': {
							\     'pattern': '[^ \t]\+',
							\     'select': 'i<Space>',
							\     'scan': 'line',
							\   }
							\ })
						call textobj#user#plugin('bigwords', {
							\   'big-words': {
							\     'pattern': '[a-zA-Z0-9_-]\+',
							\     'select': ['aW', 'iW'],
							\     'scan': 'cursor',
							\   }
							\ })
					]]
				end
			})
		end,
	},

	{"chrisgrieser/nvim-various-textobjs",
		event = "VeryLazy",
		lazy = false,
		config = function ()
			require("various-textobjs").setup {
				keymaps = {
					useDefaults = true,
				},
			}

			vim.keymap.set(
				{ "o", "x" },
				"i<Tab>",
				'<cmd>lua require("various-textobjs").indentation("inner", "inner")<CR>'
			)
			vim.keymap.set(
				{ "o", "x" },
				"a<Tab>",
				'<cmd>lua require("various-textobjs").indentation("outer", "inner")<CR>'
			)
		end
	},

	-- Neovim motions on speed!
	{ 'smoka7/hop.nvim',
		version = "*",
		config = function()
			require("hop").setup()
			vim.api.nvim_set_hl(0, "HopNextKey2", { fg='#00c7e6', ctermfg=33, })
		end,
		opts = {
			keys = 'euoai' .. 'f:l,r.c' .. ';qjkxvzwmby' .. 'dsnth',
			multi_windows = true,
			uppercase_labels = true,
		},
		keys = {
			{ '-', '<cmd>HopWord<cr>' },
		},
		enabled = false,
	},

	{ "ggandor/leap.nvim",
		config = function(opts)
			require("leap").setup(opts)
			-- vim.api.nvim_set_hl(0, "LeapBackdrop", { fg='#FFc7e6', })
			vim.api.nvim_set_hl(0, "LeapBackdrop", { })
		end,
		opts = {},
		keys = {
			{ '-', '<plug>(leap)', mode = { 'n', 'v' } },
		},
	},

	{ "rhysd/clever-f.vim",
		init = function()
			vim.g.clever_f_mark_direct = 1
			vim.g.clever_f_use_migemo = 1
			vim.g.clever_f_not_overwrites_standard_mappings = 1
			vim.g.clever_f_across_no_line = 1
			-- vim.g.clever_f_smart_case = 1
		end,
		keys = {
			{ ";", "<Plug>(clever-f-repeat-forward)", mode = { 'n', 'v', 'o' } },
			{ "j", "<Plug>(clever-f-f)",              mode = { 'n', 'v', 'o' } },
			{ "J", "<Plug>(clever-f-F)",              mode = { 'n', 'v', 'o' } },
			{ "f", "<Plug>(clever-f-t)",              mode = { 'n', 'v', 'o' } },
			{ "F", "<Plug>(clever-f-T)",              mode = { 'n', 'v', 'o' } },
		},
	},

	-- A Vim plugin for indent-level based motion.
	{ 'jeetsukumaran/vim-indentwise',
		config = function(lazy, opts)
			vim.g.indentwise_skip_blanks = 1
			local function indentwise_is_top_level()
				local first_char = string.sub(vim.fn.getline('.'), 0, 1)
				return first_char == '' or string.match(first_char, '\\S')
			end
			vim.keymap.set(
				{'n', 'i', 'v'},
				'<c-t>',
				function()
					return indentwise_is_top_level() and '{' or  '<Plug>(IndentWiseBlockScopeBoundaryBegin)'
				end,
				{silent = true, expr = true}
			)
			vim.keymap.set(
				{'n', 'i', 'v'},
				'<c-h>',
				function()
					return indentwise_is_top_level() and '}' or  '<Plug>(IndentWiseBlockScopeBoundaryEnd)'
				end,
				{silent = true, expr = true}
			)
		end,
		-- enabled = false,
	},

	-- Fast vertical navigation in Neovim using folds
	{
		"domharries/foldnav.nvim",
		version = "*",
		config = function()
			vim.g.foldnav = {
				flash = {
					enabled = true,
				},
			}
		end,
		keys = {
			{ "<C-d>", function() require("foldnav").goto_start() end },
			{ "<C-h>", function() require("foldnav").goto_next() end },
			{ "<C-t>", function() require("foldnav").goto_prev_start() end },
			-- { "<C-k>", function() require("foldnav").goto_prev_end() end },
			{ "<C-n>", function() require("foldnav").goto_end() end },
		},
		enabled = false,
	},

	-- Smart, seamless, directional navigation and resizing of Neovim + terminal multiplexer splits. Supports tmux, Wezterm, and Kitty. Think about splits in terms of "up/down/left/right".
	{'mrjones2014/smart-splits.nvim',
		keys = {
			{ '<A-Left>', function() require("smart-splits").move_cursor_left() end },
			{ '<A-Down>', function() require("smart-splits").move_cursor_down() end },
			{ '<A-Up>', function() require("smart-splits").move_cursor_up() end },
			{ '<A-Right>', function() require("smart-splits").move_cursor_right() end },
		},
	},

	{'kana/vim-submode',
		config = function ()
			vim.g.submode_timeoutlen = 500
			vim.api.nvim_create_autocmd('VimEnter', {
				callback = function ()
					vim.cmd[[
						let g:submode_keep_leaving_key=1
						call submode#enter_with('tab', 'n', '', 'gt', 'gt')
						call submode#enter_with('tab', 'n', '', 'gT', 'gT')
						call submode#map('tab', 'n', '', 't', 'gt')
						call submode#map('tab', 'n', '', 'T', 'gT')
						call submode#enter_with('window', 'n', '', '<c-w>-', '<c-w>-')
						call submode#enter_with('window', 'n', '', '<c-w>+', '<c-w>+')
						call submode#enter_with('window', 'n', '', '<c-w><', '<c-w><')
						call submode#enter_with('window', 'n', '', '<c-w>>', '<c-w>>')
						call submode#map('window', 'n', '', '-', '<c-w>-')
						call submode#map('window', 'n', '', '+', '<c-w>+')
						call submode#map('window', 'n', '', '<', '<c-w><')
						call submode#map('window', 'n', '', '>', '<c-w>>')
						; call submode#enter_with('buffer', 'n', '', 'BN', ':bn<cr>')
						; call submode#enter_with('buffer', 'n', '', 'BP', ':bp<cr>')
						; call submode#map('buffer', 'n', '', 'N', ':bn<cr>')
						; call submode#map('buffer', 'n', '', 'P', ':bp<cr>')
					]]
				end
			})
		end,
	},

	{ "nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			use_libuv_file_watcher = true,
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
			window = {
				mappings = {
					["t"] = false,
				},
			},
		},
		keys = {
			{ '<c-b>', '<cmd>NeoTreeRevealToggle<cr>', desc = 'NeoTree' },
			{ '<leader>e', '<cmd>NeoTreeRevealToggle<cr>', desc = 'NeoTree' },
		},
	},

	-- fzf heart lua
	{'ibhagwan/fzf-lua',
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function(lazy, opts)
			local fzf = require('fzf-lua')
			fzf.setup(vim.tbl_deep_extend('force', {}, fzf.defaults, {
				actions = {
					files = {
						['ctrl-e'] = function (selected)
							-- copy selected to command line
							local path = require "fzf-lua.path"
							local files = path.entry_to_file(selected[1], opts).path
							vim.api.nvim_feedkeys(':e ' .. files, 'n', true)
						end,
					},
				},
			}))
		end,
		keys = {
			-- {
			-- 	"<leader>,",
			-- 	function()
			-- 		local fzf = require('fzf-lua')
			-- 		local files = {}
			-- 		for _, v in ipairs(vim.v.oldfiles) do
			-- 			if not string.find(v, '^term://') and not string.find(v, '^/tmp/') then
			-- 				table.insert(files, v)
			-- 			end
			-- 		end
			-- 		return fzf.files({ cmd = '( echo -e "' .. table.concat(files, '\n') .. '"; fzf-default-command | grep -Ev "/\\$") | awk "!x[\\$0]++" ' })
			-- 	end,
			-- 	desc = 'Any Files'
			-- },
			{ "<leader>p", ":lua require('fzf-lua').files()<cr>",        desc = 'Files' },
			{ "<leader>b", ":lua require('fzf-lua').buffers()<cr>",      desc = 'Buffers' },
			{ "<leader>r", ":lua require('fzf-lua').grep_project()<cr>", desc = 'Ripgrep' },
			{ "<leader>c", ":lua require('fzf-lua').commands()<cr>",     desc = 'Command Pallet' },
		},
		cmd = {
			"FzfLua",
		},
		-- config = function(lazy, opts)
		-- 	local fzf = require('fzf-lua').setup(opts)
		--
		-- 	-- opts = fzf.config.normalize_opts(fzf.config.globals.git)
		--
		-- 	-- opts.cmd = fzf.path.git_cwd('git worktree list', opts)
		-- 	local actionOpts
		--
		-- 	local action = fzf.core.fzf_wrap(actionOpts, actionOpts.cmd, function(selected)
		-- 		if not selected then return end
		-- 		fzf.actions.act(opts.actions, selected, opts)
		-- 	end)()
		-- 	vim.keymap.set('n', '<leader>,', action)
		-- end,
	},

	{
		"danielfalk/smart-open.nvim",
		branch = "0.3.x",
		config = function()
			require("smart-open").setup({
				match_algorithm = "fzf",
				mappings = {
					i = {
						["<C-u>"] = function()
							vim.api.nvim_input("<C-S-u>")
						end,
						-- ["<C-k>"] = function()
						-- 	vim.api.nvim_input("<C-S-k>")
						-- end,
					}
				},
			})
			require("telescope").load_extension("smart_open")
		end,
		dependencies = {
			{
				"nvim-telescope/telescope.nvim",
				branch = "0.1.x",
				dependencies = { "nvim-lua/plenary.nvim" },
				config = function()
					local actions = require("telescope.actions")
					require("telescope").setup{
						defaults = {
							sorting_strategy = "ascending",
							layout_strategy = "horizontal",
							layout_config = {
								prompt_position = "top",
							},
							mappings = {
								i = {
									['<esc>'] = actions.close
								}
							}
						}
					}
				end,
			},
			"kkharji/sqlite.lua",
			"nvim-telescope/telescope-fzf-native.nvim",
			-- Only required if using match_algorithm fzf
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			-- Optional.  If installed, native fzy will be used when match_algorithm is fzy
			-- { "nvim-telescope/telescope-fzy-native.nvim" },
		},
		keys = {
			{ "<leader>,", "<cmd>Telescope smart_open<cr>", desc = "Smart Open" },
		},
	},

	-- Vim plugin for automatic time tracking and metrics generated from your programming activity.
	{ 'wakatime/vim-wakatime',
		enabled = vim.fn.has('mac') == 0,
		cond = vim.fn.has('mac') == 0,
		lazy = false,
	},

	-- Minimal plugin allow you to open url under cursor in neovim without netrw with default browser of your system and highlight url
	{
		"sontungexpt/url-open",
		cmd = "URLOpenUnderCursor",
		config = function()
			local status_ok, url_open = pcall(require, "url-open")
			if not status_ok then
				return
			end
			url_open.setup ({})
		end,
		keys = {
			{ "gx", "<cmd>URLOpenUnderCursor<cr>", desc = "Open URL under cursor" },
		},
	},

	-- Not UFO in the sky, but an ultra fold in Neovim.
	{ "kevinhwang91/nvim-ufo",
		event = "VeryLazy",
	}
}
