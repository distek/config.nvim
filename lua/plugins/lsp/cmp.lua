return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-look",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-calc",
		"hrsh7th/cmp-nvim-lua",
		"uga-rosa/cmp-dictionary",
		"hrsh7th/vim-vsnip",
		"rafamadriz/friendly-snippets",
		"honza/vim-snippets",
	},
	event = { "InsertEnter", "CmdlineEnter" },
	config = require("configs.cmp.cmp"),
}
