local function lighten(color, amount)
	color = color:gsub("^#", "")

	amount = amount or 0.1 -- default 10% lighter

	-- Convert hex to RGB
	local r = tonumber(color:sub(1, 2), 16)
	local g = tonumber(color:sub(3, 4), 16)
	local b = tonumber(color:sub(5, 6), 16)

	-- Lighten each component
	r = math.min(255, math.floor(r + (255 - r) * amount))
	g = math.min(255, math.floor(g + (255 - g) * amount))
	b = math.min(255, math.floor(b + (255 - b) * amount))

	-- Convert back to hex
	return string.format("#%02x%02x%02x", r, g, b)
end

return {
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			flavour = "frappe",
			term_colors = true,
			auto_integrations = false,
			integrations = {
				neotree = false,
			},
			custom_highlights = function(colors)
				return {
					WinSeparator = { fg = lighten(colors.base, 0.3) },
					NeoTreeNormal = { bg = colors.mantle },
					NeoTreeNormalNC = { bg = colors.mantle },
					NormalDark = { bg = colors.mantle },
					NormalDarker = { bg = colors.crust },
					SignColumn = { bg = lighten(colors.base, 0.11) },
					FoldColumn = { bg = lighten(colors.base, 0.11) },
					CursorLine = { bg = lighten(colors.base, 0.11) },
					CursorLineFold = { bg = lighten(colors.base, 0.11) },
					CursorLineSign = { bg = lighten(colors.base, 0.11) },
					LineNr = { bg = lighten(colors.base, 0.11), fg = lighten(colors.base, 0.40) },
					RenderMarkdownCode = { fg = lighten(colors.text, -0.1), bg = colors.mantle },
					RenderMarkdownCodeBorder = { bg = lighten(colors.mantle, 0.1) },
					RenderMarkdownCodeInline = { fg = colors.lavender, bg = colors.mantle },
					["@markup.heading"] = { fg = colors.rosewater, bold = true },
					["@markup.strong"] = { fg = colors.flamingo, bold = true },
					["@markup.italic"] = { fg = colors.pink, italic = true },
					["@markup.list"] = { fg = colors.green },
					["@markup.quote"] = { fg = colors.yellow, italic = true },
				}
			end,
		})

		vim.cmd.colorscheme("catppuccin")

		vim.opt.fillchars = {
			horiz = "━",
			horizup = "┻",
			horizdown = "┳",
			vert = "┃",
			vertleft = "┫",
			vertright = "┣",
			verthoriz = "╋",
			fold = "─",
			eob = " ",
		}
	end,
}
