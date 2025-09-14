---@type LazySpec
return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			input = {
				win = {
					relative = "cursor",
					title_pos = "left",
					width = 40,
					keys = {
						i_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "i", expr = true },
					}
				}
			},
			image = {},
			indent = {
				animate = {
					duration = {
						total = 200
					}
				}
			},
		},
	},

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

	{
		'rmagatti/auto-session',
		lazy = false,
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			use_git_branch = true,
			bypass_save_filetypes = { "cheetsheat", "neo-tree", "gitcommit", "gitrebase" },
			args_allow_files_auto_save = true,
			purge_after_minutes = 10 * 24 * 60,
			suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
		}
	},

	-- Better marks for Neovim 🏹📌
	{
		'2kabhishek/markit.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		opts = function()
			local opts = {
				default_mappings = true,
				mappings = {
					set = false,
					toggle_mark = "m",
					delete = false,
					delete_line = "km-",
					delete_bookmark= "km=",
					delete_buf = "km<space>",
				},
			}
			for i = 0, 9 do
				opts.mappings["delete_bookmark" .. i] = "km" .. i
				opts.mappings["toggle_bookmark" .. i] = "m" .. i
				opts["bookmark_" .. i] = { sign = tostring(i) }
			end
			return opts
		end,
		config = function(_, opts)
			require("markit").setup(opts)
			vim.api.nvim_set_hl(0, "MarkSignLineHL", { bg = "#106010" })
		end
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

	-- ⚡Fix the auto-scroll to the middle of the screen when switching between buffers in Neovim
	{ 'BranimirE/fix-auto-scroll.nvim',
		config = true,
		event = 'VeryLazy'
	},

	-- Better quickfix window in Neovim, polish old quickfix window.
	{ "kevinhwang91/nvim-bqf",
		ft = "qf",
		init = function()
			vim.api.nvim_set_hl(0, "BqfPreviewFloat", { bg = "#666666" })
		end,
		opts = {
			preview = {
				win_height = 8,
			}
		},
	},

	-- general key bindings for quickfix window
	{ "wsdjeg/quickfix.nvim",
		init = function()
			vim.g.quickfix_mapping_delete = "kk"
			vim.g.quickfix_mapping_visual_delete = "k"
		end,
	},

	-- Improved UI and workflow for the Neovim quickfix
	{
		'stevearc/quicker.nvim',
		event = "FileType qf",
		---@module "quicker"
		---@type quicker.SetupOptions
		opts = {},
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

	-- rsi.vim: Readline style insertion
	{ "tpope/vim-rsi"
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
						vim.api.nvim_call_function("textobj#user#plugin", {
							"spaces", {
								["space-a"] = {
									pattern = "\\s*\\S\\+\\s*",
									select = "a<Space>",
									scan = "cursor",
								},
								["space-i"] = {
									pattern = "[^ \\t]\\+",
									select = "i<Space>",
									scan = "line",
								}
							}
						})
					end
				}
			)
		end,
	},

	-- Extend and create a/i textobjects
	{ 'echasnovski/mini.ai',
		version = false,
		opts = function()
			local gen_spec = require('mini.ai').gen_spec
			return {
				search_method = "cover",
				custom_textobjects = {
					-- ['<space>'] = gen_spec.pair('^%s', "%s$"),
					f = false,
					-- f = gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
					-- a = gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
					-- c = gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
					-- B = gen_spec.treesitter({ a = '@block.outer', i = '@block.inner' }),
				}
			}
		end
	},

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
						["if"] = '@function.inner',
						af = '@function.outer',
						ic = '@class.inner',
						ac = '@class.outer',
						iB = '@block.inner',
						aB = '@block.outer',
					},
				},
			},
		},
	},

	-- Neovim motions on speed!
	{ 'smoka7/hop.nvim',
		version = "*",
		config = function(lazy, opts)
			require("hop").setup(opts)
			vim.api.nvim_set_hl(0, "HopNextKey2", { fg='#00c7e6', ctermfg=33, })
		end,
		opts = {
			keys = 'euoai' .. 'f:lrc' .. ';qjkxzwmby' .. 'dsnth',
			multi_windows = true,
			uppercase_labels = true,
		},
		keys = {
			{ '-', '<cmd>HopWord<cr>' },
		},
	},

	-- Navigate your code with search labels, enhanced character motions and Treesitter integration
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			modes = {
				char = {
					enabled = false,
				},
			},
			label = {
				rainbow = {
					enabled = true,
					shade = 8
				}
			},
			jump = {
				autojump = true
			}
		},
		-- stylua: ignore
		keys = {
			{ "-", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
			{ "g-", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			-- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
		},
		enabled = false
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
		enabled = false,
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

	{
		'aaronik/treewalker.nvim',
		opts = {},
		keys = {
			-- { "<C-t>", function ()
			-- 	if vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] == nil then
			-- 		vim.cmd[[normal! {]]
			-- 		return
			-- 	end
			-- 	vim.cmd[[:Treewalker Up]]
			-- end, { silent = true } },
			-- { "<C-h>", function ()
			-- 	if vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] == nil then
			-- 		vim.cmd[[normal! }]]
			-- 		return
			-- 	end
			-- 	vim.cmd[[:Treewalker Down]]
			-- end, { silent = true } },
			{ "<C-d>", "<cmd>Treewalker Left<cr>", { silent = true } },
			{ "<C-n>", "<cmd>Treewalker Right<cr>", { silent = true } },
			{ "<C-S-t>", "<cmd>keepjumps Treewalker SwapUp<cr>", { silent = true } },
			{ "<C-S-h>", "<cmd>keepjumps Treewalker SwapDown<cr>", { silent = true } },
			{ "<C-S-d>", "<cmd>Treewalker SwapLeft<cr>", { silent = true } },
			{ "<C-S-n>", "<cmd>Treewalker SwapRight<cr>", { silent = true } },
		},
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
						call submode#enter_with('tab', 'n', '', 'gl', 'gt')
						call submode#enter_with('tab', 'n', '', 'gL', 'gT')
						call submode#map('tab', 'n', '', 'l', 'gt')
						call submode#map('tab', 'n', '', 'L', 'gT')
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
		event = "VeryLazy",
		config = function(lazy, opts)
			local fzf = require('fzf-lua')
			fzf.setup(vim.tbl_deep_extend('force', {}, fzf.defaults, {
				actions = {
					files = {
						true,
						['ctrl-e'] = function (selected)
							-- copy selected to command line
							local path = require "fzf-lua.path"
							local files = path.entry_to_file(selected[1], opts).path
							vim.api.nvim_feedkeys(':e ' .. files, 'n', true)
						end,
					},
				},
			}))
			fzf.register_ui_select()
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
							layout_strategy = "vertical",
							layout_config = {
								prompt_position = "top",
								mirror = true,
								preview_cutoff = 6,
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
