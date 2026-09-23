local last_bracket_motion = nil

--- Captures a single key after [ or ] and executes the motion
---@param dir string "[" or "]"
local function run_bracket_motion(dir)
	local ok, char_code = pcall(vim.fn.getchar)
	if not ok or not char_code then return end

	-- Ignore ESC
	if type(char_code) == "number" and char_code == 27 then return end
	local char = type(char_code) == "number" and vim.fn.nr2char(char_code) or char_code

	last_bracket_motion = { dir = dir, char = char }
	vim.cmd("normal " .. dir .. char)
end

--- Repeats either the custom bracket motion or standard f/t motion
---@param dir string "forward" or "backward"
local function repeat_motion(dir)
	if last_bracket_motion == nil then
		-- fallback clever-f
		local keys
		if dir == "forward" then
			keys = vim.api.nvim_replace_termcodes("<Plug>(clever-f-repeat-forward)", true, false, true)
		else
			keys = vim.api.nvim_replace_termcodes("<Plug>(clever-f-repeat-back)", true, false, true)
		end
		vim.api.nvim_feedkeys(keys, 'm', false)
		return
	end

	local dir_command
	if dir == "forward" then
		dir_command = last_bracket_motion.dir
	else
		dir_command = last_bracket_motion.dir == "[" and "]" or "["
	end
	vim.cmd("normal " .. dir_command .. last_bracket_motion.char)
end

-- Mappings
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "LspAttach" }, {
	group = vim.api.nvim_create_augroup("GlobalNowaitSim", { clear = true }),
	callback = function(args)
		vim.keymap.set("n", "[", function() run_bracket_motion("[") end, { buf = args.buf, nowait = true, noremap = true })
		vim.keymap.set("n", "]", function() run_bracket_motion("]") end, { buf = args.buf, nowait = true, noremap = true })
		vim.keymap.set("n", ";", function() repeat_motion("forward") end, { desc = "Repeat last motion" })
		vim.keymap.set("n", "+", function() repeat_motion("backward") end, { desc = "Repeat last motion backward" })
	end
})

return {
	clear = function()
		last_bracket_motion = nil
	end
}
