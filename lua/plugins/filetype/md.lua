return {
	"MeanderingProgrammer/render-markdown.nvim",
	-- "jakewvincent/mkdnflow.nvim",
	ft = { "markdown" },
	lazy = true,
	config = function()
		require("render-markdown").setup({
			file_types = { "markdown", "md", "codecompanion" },
			render_modes = true,
			checkbox = {
				enable = true,
				position = "inline",
			},
			code = {
				sign = false,
				border = "thin",
				position = "right",
				width = "block",
				above = "▁",
				below = "▔",
				language_left = "█",
				language_right = "█",
				language_border = "▁",
				left_pad = 1,
				right_pad = 1,
			},
			heading = {
				width = "block",
				backgrounds = {
					"MiniStatusLineModeVisual",
					"MiniStatusLineModeCommand",
					"MiniStatusLineModeReplace",
					"MiniStatusLineModeNormal",
					"MiniStatusLineModeOther",
					"MiniStatusLineModeInsert",
				},
				sign = false,
				left_pad = 1,
				right_pad = 0,
				position = "right",
				icons = {
					"",
					"",
					"",
					"",
					"",
					"",
				},
			},
		})
	end,
}
