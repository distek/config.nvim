return {
	"Shatur/neovim-ayu",
	config = function()
		require("ayu").setup({
			mirage = true,
			overrides = {}, -- A dictionary of group names, each
			-- associated with a dictionary of parameters (`bg`,
			-- `fg`, `sp` and `style`) and colors in hex.
		})

		vim.cmd.colorscheme("ayu")

		local curLineNrHi = vim.api.nvim_get_hl(0, { name = "CursorLineNr" })
		local tabLineHi = vim.api.nvim_get_hl(0, { name = "TabLineFill" })
		local red = vim.api.nvim_get_hl(0, { name = "Todo" })
		local yellow = vim.api.nvim_get_hl(0, { name = "Directory" })
		local green = vim.api.nvim_get_hl(0, { name = "String" })

		vim.api.nvim_set_hl(0, "StatusColSep", {
			fg = curLineNrHi.fg,
			bg = tabLineHi.bg,
		})

		vim.api.nvim_set_hl(0, "CursorLineNr", {
			fg = curLineNrHi.fg,
			bg = tabLineHi.bg,
		})

		vim.api.nvim_set_hl(0, "SignColumn", {
			fg = tabLineHi.fg,
			bg = tabLineHi.bg,
		})

		vim.api.nvim_set_hl(0, "LineNr", {
			fg = tabLineHi.fg,
			bg = tabLineHi.bg,
		})

		vim.api.nvim_set_hl(
			0,
			"DapBreakpoint",
			{ fg = red.fg, bg = tabLineHi.bg }
		)
		vim.api.nvim_set_hl(
			0,
			"DapLogPoint",
			{ fg = yellow.fg, bg = tabLineHi.bg }
		)
		vim.api.nvim_set_hl(
			0,
			"DapStopped",
			{ fg = green.fg, bg = tabLineHi.bg }
		)
	end,
}
