return function()
	require("zen-mode").setup({
		window = {
			backdrop = 0.75,
			width = 120,
			height = 1, -- >1 dictates height of the actual window
		},
		plugins = {
			options = {
				enabled = true,
				ruler = true,
				showcmd = true,
			},
			twilight = { enabled = false },
			gitsigns = { enabled = true },
			tmux = { enabled = false },
		},
	})
end
