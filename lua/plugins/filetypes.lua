return {
	{ "chrisbra/csv.vim", ft = { "csv" }, lazy = true },

	{
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
	},
	{ "sirtaj/vim-openscad", ft = { "openscad" }, lazy = true },

	{
		"ray-x/go.nvim",
		ft = { "go" },
		lazy = true,
		config = function()
			require("go").setup()
		end,
	},
}
