-- https://github.com/neovim/nvim-lspconfig/issues/3144#issuecomment-2102626442
vim.filetype.add({
  extension = {
    env = "dotenv",
		sh = "bash",
		bashrc = "bash",
		profile = "bash",
  },
	pattern = {
		["%.env%..+"] = "dotenv",
	},
})

-- git
vim.filetype.add({
  extension = {
		gitconfig = "git_config",
  },
	pattern = {
		[".*/git/config"] = "git_config",
		[".*/git/ignore"] = "gitignore",
		[".*/git/attributes"] = "gitattributes",
	},
})

