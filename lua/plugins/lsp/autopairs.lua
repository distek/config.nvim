return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		require("nvim-autopairs").setup({
			disable_in_macro = true,
			enable_check_bracket_line = true,
		})
	end,
}
