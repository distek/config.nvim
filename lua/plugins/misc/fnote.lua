return {
	"distek/fnote.nvim",
	-- dir = "~/git-clones/fnote.nvim",
	config = function()
		require("fnote").setup({
			anchor = "NE",
			window = {
				offset = {
					x = 4,
					y = 2,
				},
			},

			-- border = "shadow",
		})
	end,
}
