return {
	"simrat39/rust-tools.nvim",
	ft = { "rust" },
	lazy = true,
	config = function()
		local rt = require("rust-tools")

		rt.setup({
			server = {
				on_attach = function(_, bufnr) end,
			},
		})
	end,
}
