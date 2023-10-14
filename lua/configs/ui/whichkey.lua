return function()
	require("which-key").setup({
		triggers_blacklist = {
			c = { "h" },
		},
		show_help = false,
	})
end
