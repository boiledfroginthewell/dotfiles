-- Basic Configs
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false
vim.opt.termencoding = 'utf-8'
vim.opt.infercase = true
vim.opt.autochdir = true
vim.opt.completeopt = { "menu", "preview", "longest" }
vim.opt.wildmode = "list:longest"
vim.cmd("autocmd BufEnter * set formatoptions-=o")

-- Default Indent Config
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = false
vim.opt.smartindent = true

-- Key mappings
vim.g.mapleader = ","

vim.keymap.set("n", "q:", "<nop>")
vim.keymap.set("n", "q", "<nop><nowait>")
vim.keymap.set("n", "<s-cr>", "O<esc>")
vim.keymap.set("n", "<cr>", "o<esc>")
vim.keymap.set("n", "<c-]>", "g<c-]>")
vim.keymap.set("n", "g<c-]>", "<c-]>")
vim.keymap.set("n", "g<c-}>", "<c-T>")
vim.keymap.set("n", "<c-u>", "<c-y>")

-- TODO: not work
-- " カーソル下の単語を置換する
vim.keymap.set("n", "g*", ":%s/<<C-r><C-w>>/")
vim.keymap.set("n", "g*", "\"qy:%s~<C-r>q~~gc<left><left><left>")

-- Clipboard
vim.keymap.set("n", "<c-y>", "\"+P")
vim.keymap.set("i", "<c-y>", "<C-r>+")
vim.keymap.set("n", "<c-a-y>", "\"*P")
vim.keymap.set("n", "<c-c>", "\"+y")

-- 検索ハイライトクリア
vim.keymap.set("n", "<Esc>", ":<C-u>nohlsearch<CR>")

vim.keymap.set("n", "<c-w>t", "<c-w>k")
vim.keymap.set("n", "<c-w>h", "<c-w>j")

-- Plugins
vim.g['cheatsheet#cheat_file'] = vim.fn.stdpath('config') .. '/cheatsheet.md'
vim.g['cheatsheet#vsplit'] = 1
vim.g['cheatsheet#vsplit_width'] = 35
vim.g['cheatsheet#state_cache_seconds'] = 4 * 60 * 60
vim.keymap.set('n', '<leader>?', ':Cheat<CR>')

vim.cmd("source " .. vim.fn.stdpath("config") .. "/vim/plugin/dvorak_op.vim")

require("plugins")
