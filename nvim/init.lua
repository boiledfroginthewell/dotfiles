-- Basic Configs
vim.opt.mouse = "vir"
vim.opt.number = true
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false
vim.opt.infercase = true
vim.opt.completeopt = { "menu", "preview", "longest" }
vim.opt.wildmode = "list:longest"
vim.cmd("autocmd BufEnter * set formatoptions-=o")
vim.opt.scrolloff = 0
vim.opt.foldlevelstart = 99
-- vim.opt.foldmethod = "indent"
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
vim.opt.equalalways = false
vim.opt.winborder = "rounded"
vim.opt.exrc = true

vim.opt.list = true
vim.opt.listchars = {
	-- '␣', '⍽', "⋅"
	lead = '⋅',
	trail = '⋅',
	-- "▏ ", '│ ', '↠ ', '⇥ ', '↦ ', '⇀ ', '⇢ ',
	tab = '⇢ ',
	nbsp = '▫',
}

-- filename completion for dotenv files
vim.opt.isfname:remove("=")

-- Default Indent Config
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = false
vim.opt.smartindent = true

-- Key mappings
vim.g.mapleader = ","

-- sesnible defaults
vim.keymap.set({"n", "v"}, "{", "<Cmd>keepjumps normal! {<CR>")
vim.keymap.set({"n", "v"}, "}", "<Cmd>keepjumps normal! }<CR>")

vim.keymap.set({"n", "v"}, "<c-t>", "<Cmd>keepjumps normal! {<CR>")
vim.keymap.set({"n", "v"}, "<c-h>", "<Cmd>keepjumps normal! }<CR>")
vim.keymap.set({"i", "c"}, "<c-v>", "<nop>")
vim.keymap.set({"i", "c"}, "<c-M-v>", "<c-v>", { remap = false })
vim.keymap.set("n", "q", "<nop>", { nowait = true})
vim.keymap.set("n", "Q", "q")
vim.keymap.set("n", "<s-cr>", "O<esc>")
vim.keymap.set("i", "<s-cr>", "<esc>O")
vim.keymap.set("n", "<cr>", "o<esc>")
vim.keymap.set("n", "<c-]>", "g<c-]>")
vim.keymap.set("n", "g<c-]>", "<c-]>")
vim.keymap.set("n", "g<c-}>", "<c-T>")
-- vim.keymap.set("n", "<c-u>", "<c-y>")
vim.keymap.set("n", "<c-e>", "<c-y>")
vim.keymap.set("n", "<c-u>", "<c-e>")
vim.keymap.set("n", "<c-k>", "gcc", { remap = true })
vim.keymap.set("n", "<a-k>", "vipgc", { remap = true })
vim.keymap.set({"v", "x"}, "<c-k>", "gc", { remap = true })

vim.keymap.set('n', '<leader>o', ':e <C-R>=expand("%:p:h") . "/" <CR>')
vim.keymap.set('n', '<c-s>', '<cmd>update<cr>')
vim.keymap.set('n', '<c-q>', '<cmd>qa!<cr>')

vim.keymap.set('n', ']q', ':cn<cr>')
vim.keymap.set('n', '[q', ':cp<cr>')

-- Replace the word under the cursor
vim.keymap.set("n", "g*", ":%s/<C-r><C-w>/")
vim.keymap.set("v", "g*", "\"qy:%s~<C-r>q~~gc<left><left><left>")

-- Registers
vim.keymap.set("n", "c", [["_c]])
vim.keymap.set("n", "s", [["_s]])
vim.keymap.set("n", "S", [["_S]])
vim.keymap.set("n", "r", [["_r]])
vim.keymap.set("n", "R", [["_R]])

-- Clipboard
local function paste(cmd)
	return function ()
		vim.opt.paste = true
		vim.api.nvim_feedkeys(cmd, "nt", true)
		vim.schedule(function()
			vim.opt.paste = false
		end)
	end
end

vim.keymap.set("i", "<c-h>", "<C-n>")
vim.keymap.set("i", "<c-t>", "<C-p>")

vim.keymap.set("v", "p", "\"_dP")
local ctrl_r = vim.api.nvim_replace_termcodes("<c-r>", true, true, true)
vim.keymap.set("n", "<c-y>", paste("\"+p"))
vim.keymap.set("i", "<c-y>", paste(ctrl_r .. "+"))
vim.keymap.set("v", "<c-y>", paste("\"_x\"+p"))
vim.keymap.set("i", "<a-y>", paste(ctrl_r .. "\""))
vim.keymap.set("n", "<c-s-y>", paste("\"+P"))
vim.keymap.set("n", "<c-a-y>", paste("\"*P"))
vim.keymap.set("n", "<c-c>", "\"+y")
vim.keymap.set({"n", "v"}, "<a-c>", "\"+y")
vim.keymap.set("n", "<a-v>", paste("\"+P"))
vim.keymap.set({"n", "v"}, "gY", "\"+Y")

vim.keymap.set("n", "<a-PageDown>", "<cmd>bn<cr>")
vim.keymap.set("n", "<a-PageUp>", "<cmd>bp<cr>")

-- clear search highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })

vim.keymap.set("n", "gadd", "<cmd>Git add %<CR>", {silent=true})
vim.keymap.set("n", "gcommit", "<cmd>Git commit<CR>", {silent=true})

vim.api.nvim_create_autocmd('BufEnter', {
	desc = "Close floating window by <ESC>",
	pattern = { "markdown" },
	callback = function()
		if vim.fn.win_gettype() ~= 'popup' then
			return
		end

		for key in { "<esc>", "T" } do
			vim.keymap.set('n', key, function()
				vim.api.nvim_win_close(vim.fn.win_getid(), true)
			end, { buffer = vim.api.nvim_get_current_buf() })
		end
	end,
})

vim.cmd([[
augroup myvimrc
	autocmd!
	autocmd QuickFixCmdPost [^l]* cwindow
	autocmd QuickFixCmdPost l*    lwindow

	autocmd VimEnter * silent! delmarks!
augroup END
]])

vim.opt.cursorline = true
vim.api.nvim_create_autocmd("BufLeave", {
	callback = function()
		vim.wo.cursorline = false
	end,
})
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.wo.cursorline = true
	end,
})

-- Plugins
vim.g['cheatsheet#cheat_file'] = vim.fn.stdpath('config') .. '/cheatsheet.md'
vim.g['cheatsheet#vsplit'] = 1
vim.g['cheatsheet#vsplit_width'] = 35
vim.g['cheatsheet#state_cache_seconds'] = 4 * 60 * 60
vim.keymap.set('n', '<leader>?', ':Cheat<CR>')

require('vim._core.ui2').enable()

require("ft-detect")
require("lsp")
require("copies/lazynvim")
require("wezterm-integration")
local ok, localPlugins = pcall(require, 'local')

-- vim.cmd[[highlight NonText guibg=none]]
-- vim.cmd[[colorscheme slate]]
-- vim.cmd[[hi Comment guifg=#90FFaF]]
-- vim.cmd[[colorscheme zephyr]]
vim.cmd[[colorscheme cyberdream]]
-- vim.cmd[[colorscheme bamboo]]
-- vim.cmd[[colorscheme vscode]]
-- vim.cmd.colorscheme "catppuccin-mocha"
