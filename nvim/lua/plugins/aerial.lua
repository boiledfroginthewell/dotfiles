---@param bufnr integer
---@param symbol aerial.Symbol
local function is_fastapi_route(bufnr, symbol)
	local decorated = symbol and symbol:parent()
	if not decorated or decorated:type() ~= "decorated_definition" then
		return false
	end

	for decorator in decorated:iter_children() do
		if decorator:type() == "decorator" then
			local text = vim.treesitter.get_node_text(decorator, bufnr)
			for _, method in ipairs({ "get", "post", "put", "delete", "patch", "options", "head", "trace", "api_route", "websocket" }) do
				if text:match("@[%w_%.]+%." .. method .. "%s*%(") then
					return true
				end
			end
		end
	end
	return false
end

---@type LazySpec
return {

	-- Neovim plugin for a code outline window
	{ 'stevearc/aerial.nvim',
		dependencies = {
			{
				"echasnovski/mini.icons",
				opts = {
					lsp = {
						["function"] = { glyph = '󰊕', hl = 'MiniIconsAzure' },
					},
				},
			},
		},
		lazy = false,
		opts = {
			layout = {
				placement = "edge",
				min_width = 20,
				max_width = { 40, 0.25 },
				win_opts = { fillchars = "eob: "},
			},
			show_guides = true,
			-- open_automatic = true,
			-- close_automatic_events = { "unfocus", "switch_buffer", "unsupported" },
			keymaps = {
				["l"] = false,
				["n"] = "actions.tree_open",
				["L"] = false,
				["N"] = "actions.tree_open_recursive",
				["h"] = false,
				["d"] = "actions.tree_close",
				["H"] = false,
				["D"] = "actions.tree_close_recursive",
			},
			filter_kind = {
				"Class",
				"Constructor",
				"Enum",
				"Function",
				"Interface",
				"Module",
				"Package",
				"Method",
				"Struct",
			},
			---@module "aerial"
			---@param bufnr integer
			---@param item aerial.Symbol
			---@param ctx {backend_name: string, lang: {name: string, parser: string}, symbols?: any, symbol?: any, syntax_tree?: any, match?: any}
			---  A record containing the following fields:
			---  * backend_name: treesitter, lsp, man...
			---  * lang: info about the language
			---  * symbols?: specific to the lsp backend
			---  * symbol?: specific to the lsp backend
			---  * syntax_tree?: specific to the treesitter backend
			---  * match?: specific to the treesitter backend, TS query match
			post_parse_symbol = function(bufnr, item, ctx)
				if ctx.lang == "python" and item.kind == "Function" and ctx.match then
					local symbol = ctx.match.symbol and ctx.match.symbol.node
					if is_fastapi_route(bufnr, symbol) then
						item.kind = "Event"
					end
				end
				local file_path = vim.api.nvim_buf_get_name(bufnr)
				if (
					ctx.match ~= nil
					and (
						vim.b.aerial_custom_outline
						or file_path:match("/lua/plugins/.*%.lua$")
						or file_path:match("Taskfile%.ya?ml$")
						or file_path:match(".*/screwdriver%.ya?ml$")
					)
				) then
					return ctx.match.custom_outline ~= nil
				end
				return true
			end,
		},
		cmd = {
			"AerialToggle",
		},
		keys = {
			{ "<F8>", "<cmd>AerialToggle!<cr>", desc = "Outline" },
			{ "[a", "<cmd>AerialPrev<cr>" },
			{ "]a", "<cmd>AerialNext<cr>" },
		},
	},

}
