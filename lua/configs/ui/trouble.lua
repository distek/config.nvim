return function()
	require("trouble").setup({
		action_keys = {
			close = {},
		},
		ignored_filetypes = {
			"terminal",
			"fnote",
			"toggleterm",
			"qf",
			"help",
		},
	})
end
