-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

local function diagnostic()
	if #vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] }) ~= 0 then
		vim.diagnostic.open_float()
	else
		vim.lsp.buf.hover()
	end
end

local function hover()
	vim.lsp.buf.hover({ border = vim.o.winborder })
end

vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP configs',
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set('n', 'T', hover, opts)
		vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
		-- vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
		-- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
		-- vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
		-- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
		-- vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
		vim.keymap.set('n', '<F1>', diagnostic, opts)
		vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
		-- vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
		vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)


		local signs = {
			Error = "🔥",
			Warn = "⚠️",
			-- (vim.fn.has('mac') == 1 and '💬') or '🗨️',
			Hint = "🗨️",
			-- Info = " "
		}
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

	end
})
