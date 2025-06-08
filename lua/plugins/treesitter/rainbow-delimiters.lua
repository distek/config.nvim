return {
	"HiPhish/rainbow-delimiters.nvim",
	submodules = false,
	event = "VeryLazy",
	config = function()
		-- This module contains a number of default definitions
		local rainbow_delimiters = require("rainbow-delimiters")

		vim.g.rainbow_delimiters = {
			strategy = {
				[""] = rainbow_delimiters.strategy["global"],
			},
			query = {
				[""] = "rainbow-delimiters",
			},
		}
	end,
}
