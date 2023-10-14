return {
	"kevinhwang91/nvim-hlslens",
	event = "VeryLazy",
	config = function()
		require("hlslens").setup()
	end,
}
