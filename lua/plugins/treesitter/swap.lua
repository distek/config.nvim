return {
	"Wansmer/sibling-swap.nvim",
	config = function()
		require("sibling-swap").setup({
			use_default_keymaps = false,
		})
	end,
}
