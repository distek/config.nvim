return {
	"folke/trouble.nvim",
	-- branch = "set-win",
	-- dir = "~/git-clones/trouble.nvim",
	cmd = "Trouble",
	config = function()
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
	end,
}
