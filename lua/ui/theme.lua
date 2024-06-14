local theme = require("ui.lush")

require("lush")(theme)
local bufferlineConfig = require("ui.bufferline")

local curLineNrHi = vim.api.nvim_get_hl(0, { name = "CursorLineNr" })
local tabLineHi = vim.api.nvim_get_hl(0, { name = "TabLineFill" })
local red = vim.api.nvim_get_hl(0, { name = "Todo" })
local yellow = vim.api.nvim_get_hl(0, { name = "Directory" })
local green = vim.api.nvim_get_hl(0, { name = "String" })
local popup = vim.api.nvim_get_hl(0, { name = "PMenu" })

vim.api.nvim_set_hl(0, "StatusColSep", {
	fg = curLineNrHi.fg,
	bg = tabLineHi.bg,
})

vim.api.nvim_set_hl(0, "CursorLineNr", {
	fg = curLineNrHi.fg,
	bg = tabLineHi.bg,
})

vim.api.nvim_set_hl(0, "CursorLineSign", {
	bg = tabLineHi.bg,
})

vim.api.nvim_set_hl(0, "FoldColumn", {
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

-- vim.api.nvim_set_hl(0, "NormalFloat", {
-- 	bg = popup.bg,
-- })

vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = red.fg, bg = tabLineHi.bg })
vim.api.nvim_set_hl(0, "DapLogPoint", { fg = yellow.fg, bg = tabLineHi.bg })
vim.api.nvim_set_hl(0, "DapStopped", { fg = green.fg, bg = tabLineHi.bg })

bufferlineConfig.highlights = {
	fill = {
		bg = tabLineHi.bg,
	},
}

require("lush")(theme)
require("bufferline").setup(bufferlineConfig)
