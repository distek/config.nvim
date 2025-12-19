return {
	-- "rktjmp/lush.nvim",
	-- config = function()
	--     require("lush")(require("ui.term"))
	-- end,
	-- "rebelot/kanagawa.nvim",
	-- config = function()
	-- 	-- Default options:
	-- 	require("kanagawa").setup({
	-- 		compile = false, -- enable compiling the colorscheme
	-- 		undercurl = true, -- enable undercurls
	-- 		commentStyle = { italic = true },
	-- 		functionStyle = {},
	-- 		keywordStyle = { italic = true },
	-- 		statementStyle = { bold = true },
	-- 		typeStyle = {},
	-- 		transparent = false, -- do not set background color
	-- 		dimInactive = false, -- dim inactive window `:h hl-NormalNC`
	-- 		terminalColors = true, -- define vim.g.terminal_color_{0,17}
	-- 		colors = { -- add/modify theme and palette colors
	-- 			palette = {},
	-- 			theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
	-- 		},
	-- 		overrides = function(colors) -- add/modify highlights
	-- 			local theme = colors.theme
	-- 			return {
	-- 				LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
	-- 				NormalDarker = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
	-- 				NormalDark = { bg = theme.ui.bg_m2, fg = theme.ui.fg_dim },
	-- 			}
	-- 		end,
	-- 		theme = "dragon", -- Load "wave" theme when 'background' option is not set
	-- 		background = { -- map the value of 'background' option to a theme
	-- 			dark = "dragon", -- try "dragon" !
	-- 			light = "lotus",
	-- 		},
	-- 	})

	-- 	-- setup must be called before loading
	-- 	vim.cmd("colorscheme kanagawa")
	-- end,
	"Shatur/neovim-ayu",
	config = function()
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

		require("ayu.colors").generate(true)

		local colors = require("ayu.colors")

		require("ayu").setup({
			mirage = true,
			overrides = {
				WinSeparator = { fg = lighten(colors.bg, 0.3) },
				-- Normal = { bg = lighten(colors.bg, 0.01) },
				-- NormalNC = { bg = colors.bg },
				NormalFloat = { bg = lighten(colors.bg, -0.04) },
				SignColumn = { bg = lighten(colors.bg, 0.11) },
				FoldColumn = { bg = lighten(colors.bg, 0.11) },
				CursorLine = { bg = lighten(colors.bg, 0.11) },
				CursorLineFold = { bg = lighten(colors.bg, 0.11) },
				CursorLineSign = { bg = lighten(colors.bg, 0.11) },
				Visual = { bg = lighten(colors.bg, 0.20) },
				LineNr = { bg = lighten(colors.bg, 0.11), fg = lighten(colors.bg, 0.40) },
				RenderMarkdownCode = { fg = lighten(colors.fg, -0.1), bg = colors.panel_bg },
				RenderMarkdownCodeBorder = { bg = lighten(colors.panel_bg, 0.1) },
				RenderMarkdownCodeInline = { fg = colors.constant, },
				["@markup.heading"] = { fg = colors.keyword, bold = true },
				["@markup.strong"] = { fg = colors.keyword, bold = true },
				["@markup.italic"] = { fg = colors.keyword, italic = true },
				["@markup.list"] = { fg = colors.vcs_added },
				-- ["@markup.raw"] = { fg = colors.tag, bg = colors.selection_inactive },
				["@markup.quote"] = { fg = colors.constant, italic = true },
			},
		})

		vim.cmd("colorscheme ayu")
		-- lualine also has a config item for ayu
		-- lua/plugins/ui/statusline.lua
	end,
}
