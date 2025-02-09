-- Language specific plugins

---@type LazySpec
return {
	-- Vim editing support for kmonad config files
	{ 'kmonad/kmonad-vim',
		ft = 'kbd',
	},

	-- ### YAML
	{ 'pedrohdz/vim-yaml-folds', ft="yaml" },

	-- ### Linux
	-- 'wgwoods/vim-systemd-syntax',
}

