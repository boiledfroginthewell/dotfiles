-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

vim.g.mapleader = ","

vim.cmd("source ".. vim.env.XDG_CONFIG_HOME .."/astronvim/dvorak_op.vim")

