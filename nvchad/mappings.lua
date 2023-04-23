---@type MappingsTable
local M = {}

local defaultM = require("core/mappings")

-- TODO: not work
-- " カーソル下の単語を置換する
vim.keymap.set("n", "g*", ":%s/<<C-r><C-w>>/")
vim.keymap.set("n", "g*", "\"qy:%s~<C-r>q~~gc<left><left><left>")

-- Clipboard
vim.keymap.set("n", "<c-y>", "\"+P")
vim.keymap.set("i", "<c-y>", "<C-r>+")
vim.keymap.set("n", "<c-a-y>", "\"*P")
vim.keymap.set("n", "<c-c>", "\"+y")

M.general = {
  n = {
    ["<CR>"] = { "o<ESC>", "enter command mode", opts = { nowait = true } },
    ["<F1>"] = defaultM.lspconfig.n.K,
    ["k"] = {"k"},
    ["j"] = {"j"},
  },
}

M.telescope = nil

-- more keybinds!

return M

