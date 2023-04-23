return {

	-- A neovim plugin that jump to previous and next buffer of the jumplist. 
	{ 'kwkarlwang/bufjump.nvim' },

	-- Improved vim spelling plugin (with camel case support)! 
	{ 'kamykn/spelunker.vim',
		config = function()
			vim.g.enable_spelunker_vim_on_readonly = 1
			vim.g.spelunker_target_min_char_len = 3
		end
	},

	-- quoting/parenthesizing made simple
	{ 'tpope/vim-surround',
		init = function() 
			vim.g.surround_no_mappings = 1
		end,
		keys = {
			{"ks", "<Plug>Dsurround" },
			{"cs", "<Plug>Csurround" },
			{"cS", "<Plug>CSurround" },
			{"ys", "<Plug>Ysurround" },
			{"yS", "<Plug>YSurround" },
			{"yss", "<Plug>Yssurround" },
			{"ySs", "<Plug>YSsurround" },
			{"ySS", "<Plug>YSsurround" },
			{"S", "<Plug>VSurround" },
			{"gS", "<Plug>VgSurround" },
		},
	},

	-- vim-textobj-user - Create your own text objects
	{ 'kana/vim-textobj-user' },
	{ 'inkarkat/argtextobj.vim' },
	{ 'thalesmello/vim-textobj-methodcall' },

	-- Vim motions on speed!
	{ 'easymotion/vim-easymotion',
		init = function()
			vim.g.EasyMotion_do_mapping = 0
			vim.g.EasyMotion_use_upper = 1
			vim.g.EasyMotion_keys =
				'EUOAI' ..
				'F:L,R.C' ..
				'234789' ..
				';QJKXVZWMBY' ..
				'DSNTH'
			vim.g.EasyMotion_enter_jump_first = 1
			vim.g.EasyMotion_add_search_history = 0
			vim.g.EasyMotion_off_screen_search = 0
			if has('mac')
				nmap - <Plug>(easymotion-bd-w)
			else
				nmap - <Plug>(easymotion-overwin-w)
			endif
		end
	},

	-- Find, Filter, Preview, Pick. All lua, all the time. 
	{
	    'nvim-telescope/telescope.nvim',
	    tag = '0.1.1',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = function()
			return {
				defaults = {
					mappings = {
						i = {
							["<esc>"] = actions.close,
							["<C-u>"] = false,
						},
					}
				},
				pickers = {
					buffers = {
						mappings = {

						i = {
							["<c-d>"] = actions.delete_buffer + actions.move_to_top,
						}
					},
				},
			}
		end
	}
}
