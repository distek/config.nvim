return {
	"akinsho/bufferline.nvim",
	opts = {
		options = {
			offsets = {
				{
					filetype = "neo-tree",
					text = "Neovim",
					text_align = "center",
					separator = " ",
				},
				{
					filetype = "Outline",
					text = "",
					text_align = "center",
					separator = " ",
				},
				{
					filetype = "edgy",
					text = "",
					text_align = "center",
					separator = " ",
				},
			},
			custom_areas = {
				left = function()
					return vim.tbl_map(function(item)
						return { text = item }
					end, require("edgy-group.stl").get_statusline("left"))
				end,
			},
		},
	},
}
