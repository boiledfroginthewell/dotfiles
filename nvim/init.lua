-- Basic Configs
vim.opt.number = true
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false
vim.opt.infercase = true
vim.opt.completeopt = { "menu", "preview", "longest" }
vim.opt.wildmode = "list:longest"
vim.cmd("autocmd BufEnter * set formatoptions-=o")
vim.opt.scrolloff = 0
vim.opt.foldlevelstart = 99
vim.opt.equalalways = false

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
vim.keymap.set("n", "U", "<c-R>")
vim.keymap.set({"n", "v"}, "{", "<Cmd>keepjumps normal! {<CR>")
vim.keymap.set({"n", "v"}, "}", "<Cmd>keepjumps normal! }<CR>")

vim.keymap.set("n", "q:", "<nop>")
vim.keymap.set("n", "q", "<nop>", { nowait = true})
vim.keymap.set("n", "<s-cr>", "O<esc>")
vim.keymap.set("n", "<cr>", "o<esc>")
vim.keymap.set("n", "<c-]>", "g<c-]>")
vim.keymap.set("n", "g<c-]>", "<c-]>")
vim.keymap.set("n", "g<c-}>", "<c-T>")
-- vim.keymap.set("n", "<c-u>", "<c-y>")
vim.keymap.set("n", "<c-e>", "<c-y>")
vim.keymap.set("n", "<c-u>", "<c-e>")
vim.keymap.set("n", "<c-k>", "gcc", { remap = true })
vim.keymap.set({"v", "x"}, "<c-k>", "gc", { remap = true })

vim.keymap.set('n', '<leader>o', ':e <C-R>=expand("%:p:h") . "/" <CR>')
vim.keymap.set('n', '<c-s>', '<cmd>update<cr>')
vim.keymap.set('n', 'QQ', '<cmd>q<cr>')
vim.keymap.set('n', 'QA', '<cmd>qa!<cr>')

-- カーソル下の単語を置換する
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

local ctrl_r = vim.api.nvim_replace_termcodes("<c-r>", true, true, true)
vim.keymap.set("n", "<c-y>", paste("\"+P"))
vim.keymap.set("i", "<c-y>", paste(ctrl_r .. "+"))
vim.keymap.set("i", "<a-v>", paste(ctrl_r .. "+"))
vim.keymap.set("n", "<c-s-y>", paste("\"+p"))
vim.keymap.set("n", "<c-a-y>", paste("\"*P"))
vim.keymap.set("n", "<c-c>", "\"+y")
vim.keymap.set({"n", "v"}, "<a-c>", "\"+y")
vim.keymap.set("n", "<a-v>", paste("\"+P"))

vim.keymap.set("n", "<a-PageDown>", ":bn<cr>")
vim.keymap.set("n", "<a-PageUp>", ":bp<cr>")

-- 検索ハイライトクリア
vim.keymap.set("n", "<Esc>", ":<C-u>nohlsearch<CR>", { silent = true })

vim.keymap.set("n", "gadd", ":!git add %<CR>", {silent=true})
vim.keymap.set("n", "gcommit", ":!Git commit<CR>", {silent=true})

vim.cmd([[
augroup myvimrc
	autocmd!
	autocmd QuickFixCmdPost [^l]* cwindow
	autocmd QuickFixCmdPost l*    lwindow

	autocmd VimEnter * silent! delmarks!
augroup END
]])

-- https://github.com/neovim/nvim-lspconfig/issues/3144#issuecomment-2102626442
vim.filetype.add({
  extension = {
    env = 'env',
  },
})

-- Plugins
vim.g['cheatsheet#cheat_file'] = vim.fn.stdpath('config') .. '/cheatsheet.md'
vim.g['cheatsheet#vsplit'] = 1
vim.g['cheatsheet#vsplit_width'] = 35
vim.g['cheatsheet#state_cache_seconds'] = 4 * 60 * 60
vim.keymap.set('n', '<leader>?', ':Cheat<CR>')

require("lsp")
require("copies/lazynvim")
require("wezterm-integration")

-- vim.cmd[[highlight NonText guibg=none]]
-- vim.cmd[[colorscheme slate]]
-- vim.cmd[[hi Comment guifg=#90FFaF]]
-- vim.cmd[[colorscheme zephyr]]
vim.cmd[[colorscheme cyberdream]]
-- vim.cmd[[colorscheme bamboo]]

