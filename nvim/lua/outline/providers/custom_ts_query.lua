local M = {
  name = "lazy_plugins",
}

local function is_plugins_file(bufnr, config)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local pattern = config and config.path_pattern or "/lua/plugins/.*%.lua$"
  return filename:match(pattern) ~= nil
end


---@param bufnr integer
---@param config table?
---@return boolean
function M.supports_buffer(bufnr, config)
	return (
		is_plugins_file(bufnr, config)
		and vim.treesitter.get_parser(bufnr) ~= nil
	)
end

local lazy_plugins_query = (function()
	local lazy_spec_query = [[
		(expression_list
			(table_constructor
				(field value: [
					(table_constructor
						(field
							!name
							value: (string content: (string_content) @plugin_name)
						)
					)
					(string content: (string_content) @plugin_name)
				])
			)
		)
	]]
	return vim.treesitter.query.parse("lua", ([[
	[
		(chunk
			local_declaration: (variable_declaration
				(assignment_statement
					(variable_list
						name: (_) @name (#eq? @name "spec")
					)
					%s
				)
			)
		)
		(chunk
			(return_statement %s)
		)
	]
	]]):format(lazy_spec_query, lazy_spec_query))
end)()

---@param on_symbols fun(symbols?: outline.ProviderSymbol[], opts?: table)
---@param opts table?
function M.request_symbols(on_symbols, opts)
	local bufnr = 0
	local tree = vim.treesitter.get_parser():parse()[1]
	if tree == nil then
		return {}
	end
	local symbols = {}
	for id, node, metadata in lazy_plugins_query:iter_captures(tree:root(), bufnr) do
		if lazy_plugins_query.captures[id] == "plugin_name" then
			local start_row, start_column, end_row, end_column = node:range()
			local range = {
				start = { line = start_row, character = start_column },
				["end"] = { line = end_row, character = end_column },
			}
			local line = vim.api.nvim_buf_get_lines(bufnr, start_row, end_row + 1, false)[1]
			local plugin_name = string.sub(line, start_column + 1, end_column)
			table.insert(symbols, {
				kind = "Package",
				name = plugin_name,
				selectionRange = range,
				range = range,
				children = {},
			})
		end
	end
	on_symbols(symbols, opts)
end

return M
