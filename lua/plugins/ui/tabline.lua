return {
	"nanozuki/tabby.nvim",
	--- ...
	opts = {
		line = function(line)
			return {
				require("edgy-group.stl").get_statusline("left"),
				-- ...
				line.spacer(),
				-- ...
				require("edgy-group.stl").get_statusline("right"),
			}
		end,
	},
}
