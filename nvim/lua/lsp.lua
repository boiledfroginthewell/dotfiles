require("copies/lsp")

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(event)
		local keymapOpts = { buffer = event.buf }

		local diagnostic = function()
			if #vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] }) ~= 0 then
				vim.diagnostic.open_float()
			else
				vim.lsp.buf.hover()
			end
		end
		vim.keymap.set('n', '<F1>', diagnostic, keymapOpts)

		-- vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, keymapOpts)

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

		-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
		local border = {
			{ "🭽", "FloatBorder" },
			{ "▔", "FloatBorder" },
			{ "🭾", "FloatBorder" },
			{ "▕", "FloatBorder" },
			{ "🭿", "FloatBorder" },
			{ "▁", "FloatBorder" },
			{ "🭼", "FloatBorder" },
			{ "▏", "FloatBorder" },
		}
		local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or border
			return orig_util_open_floating_preview(contents, syntax, opts, ...)
		end

		vim.keymap.set('n', 'T', '<cmd>lua vim.lsp.buf.hover()<cr>', keymapOpts)

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
			vim.lsp.handlers.hover, { focusable = false }
		)
	end
})
