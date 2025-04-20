local function sequence_set_user_var(var, value)
	return string.format("\027]1337;SetUserVar=%s=%s\a", var, value)
end

-- Notify WezTerm that nvim is started.
-- https://www.reddit.com/r/neovim/comments/1fqjltg/change_wezterm_font_when_entering_and_exiting/
local wezterm_group = vim.api.nvim_create_augroup('wezterm', {clear = true})

vim.api.nvim_create_autocmd(
	{ "VimEnter", "VimResume" }, {
		group = wezterm_group,
		callback = function()
			io.write("\027]1337;SetUserVar=WEZTERM_PROG=bnZpbQ==\a")
		end,
})
vim.api.nvim_create_autocmd(
	{ "VimLeave", "VimSuspend" }, {
		group = wezterm_group,
		callback = function()
			io.write("\027]1337;SetUserVar=WEZTERM_PROG=\a")
		end,
	}
)

local bit = require("plenary.bit")
local BASE64_1 = "MQ=="

local function splitWezRun()
	vim.cmd[[:update]]
	local paneId = io.popen("wezterm cli get-pane-direction next"):read()
	if paneId == vim.env.WEZTERM_PANE then
		paneId = nil
	end
	local command = vim.b.splitWezRun_command
	local fileName = vim.fn.expand("%")

	if not paneId then
		paneId = io.popen("wezterm cli split-pane --bottom --percent 30"):read()
		if not command then
			if bit.band(vim.uv.fs_stat(fileName).mode, 64) == 0  then
				return
			end
			vim.cmd[[sleep 200m]]
			command = "./'%'"
		end
	end

	io.write(sequence_set_user_var("EXEC_LAST", BASE64_1))
	-- if command then
	-- 	command = command:gsub("%%", vim.fn.expand("%")) -- :gsub("'", "\\'")
	-- else
	-- 	command = "!!"
	-- end
	-- local echo_message = sequence_set_user_var("RESET_SCROLL", BASE64_1) .. "\\x15" .. command .. "\\r\\n"
	-- io.popen("echo -e '" .. echo_message .. "' | wezterm cli send-text --no-paste --pane-id " .. paneId)
end
vim.keymap.set("n", "<F5>", splitWezRun)
