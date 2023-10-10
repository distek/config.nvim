return {
	{
		"neovim/nvim-lspconfig",
		config = require("configs.lspconfig"),
	},

	{ "williamboman/mason.nvim", event = "BufReadPre" },
	{ "williamboman/mason-lspconfig.nvim", event = "BufReadPre" },

	{
		"jayp0521/mason-null-ls.nvim",
		event = "BufReadPre",
		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
		},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				disable_in_macro = true,
				enable_check_bracket_line = true,
			})
		end,
	},

	{
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
		config = require("configs.cmp"),
	},

	{ "onsails/lspkind-nvim", event = "InsertEnter" },

	{
		"simrat39/symbols-outline.nvim",
		event = "VeryLazy",
		config = function()
			require("symbols-outline").setup({
				highlight_hovered_item = true,
				show_guides = true,
				auto_preview = false,
				position = "right",
				relative_width = true,
				width = 35,
				auto_close = false,
				show_numbers = false,
				show_relative_numbers = false,
				show_symbol_details = true,
				preview_bg_highlight = "Pmenu",
				autofold_depth = nil,
				auto_unfold_hover = true,
				fold_markers = { "", "" },
				wrap = false,
				keymaps = { -- These keymaps can be a string or a table for multiple keys
					close = { "q" },
					goto_location = "<Cr>",
					focus_location = "o",
					hover_symbol = "<C-space>",
					toggle_preview = "K",
					rename_symbol = "r",
					code_actions = "a",
					fold = "zc",
					unfold = "zo",
					fold_all = "zM",
					unfold_all = "zR",
					fold_reset = "R",
				},
				lsp_blacklist = {},
				symbol_blacklist = {},
			})
		end,
	},

	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		config = function()
			require("lsp_signature").setup({
				bind = true, -- This is mandatory, otherwise border config won't get registered.
				handler_opts = {
					border = "shadow",
				},
			})
		end,
	},
}
