return {
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
}
