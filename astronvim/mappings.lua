-- Mapping data with "desc" stored directly by vim.keymap.set().
--

-- TODO: not work
-- " カーソル下の単語を置換する
vim.keymap.set("n", "g*", ":%s/<<C-r><C-w>>/")
vim.keymap.set("n", "g*", "\"qy:%s~<C-r>q~~gc<left><left><left>")

-- Clipboard
vim.keymap.set("n", "<c-y>", "\"+P")
vim.keymap.set("i", "<c-y>", "<C-r>+")
vim.keymap.set("n", "<c-a-y>", "\"*P")
vim.keymap.set("n", "<c-c>", "\"+y")


-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return function(local_vim)
    n = {
      ["<leader>bD"] = {
        function()
          require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) require("astronvim.utils.buffer").close(bufnr) end)
        end,
        desc = "Pick to close",
      },

      ["q:"] = {"<nop>"},
      ["<S-CR>"] = {"O<esc>"},
      ["<CR>"] = {"o<esc>"},
      ["<F1>"] = local_vim.n["K"],
      ["<c-]>"] = {"g<c-]>"},
      ["g<c-]>"] = {"<c-]>"},
      ["<c-}>"] = {"C-T"},

      -- TODO: not work
      -- go to the middle of a line by gm
      -- noremap gm :call cursor(0, virtcol('$')/2)<CR>

      ["<c-u>"] = {"<c-y>"},
      ["<c-k>"] = local_vim.n["<leader>/"],

      ["<leader>,"] = local_vim.n["<leader>ff"],
      ["<leader>b"] = local_vim.n["<leader>fb"],
      ["<leader>c"] = local_vim.n["<leader>fc"],
      ["<leader>o"] = local_vim.n["<leader>fo"],
    }
	local_vim.n.k = nil
	local_vim.n.j = nil

    i = {
    }

    for k, v in pairs(n) do local_vim.n[k] = v end
    for k, v in pairs(i) do local_vim.i[k] = v end
    return local_vim
end

