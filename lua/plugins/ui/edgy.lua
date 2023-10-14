return {
	"folke/edgy.nvim",
	event = "VeryLazy",
	opts = {
		options = {
			left = { size = 35 },
			top = { size = 15 },
			bottom = { size = 15 },
			right = { size = 35 },
		},
		exit_when_last = false,
		wo = {
			-- Setting to `true`, will add an edgy winbar.
			-- Setting to `false`, won't set any winbar.
			-- Setting to a string, will set the winbar to that string.
			winbar = false,
			winfixwidth = true,
			winfixheight = true,
			winhighlight = "WinBar:EdgyWinBar",
			spell = false,
			signcolumn = "no",
			statuscolumn = "",
			number = false,
			relativenumber = false,
		},
		keys = {
			["q"] = function(win)
				win:hide()
			end,
			["<c-q>"] = false,
			["Q"] = false,
			["]w"] = false,
			["[w"] = false,
			["]W"] = false,
			["[W"] = false,
			["<c-w>>"] = false,
			["<c-w><lt>"] = false,
			["<c-w>+"] = false,
			["<c-w>-"] = false,
			["<c-w>"] = false,
			["<A-C-j>"] = function(win)
				win:resize("height", 1)
			end,
			["<A-C-k>"] = function(win)
				win:resize("height", -2)
			end,
			["<A-C-h>"] = function(win)
				win:resize("width", 2)
			end,
			-- decrease width
			["<A-C-l>"] = function(win)
				win:resize("width", -2)
			end,
		},
		animate = {
			enabled = false,
		},
		top = {},
		left = {
			{
				title = "Buffers",
				ft = "neo-tree",
				size = { height = 0.25 },
				filter = function(buf)
					return vim.b[buf].neo_tree_source == "buffers"
				end,
				pinned = true,
				open = "Neotree position=top buffers",
				wo = {
					winbar = true,
				},
			},
			{
				title = "Files",
				ft = "neo-tree",
				filter = function(buf)
					return vim.b[buf].neo_tree_source == "filesystem"
				end,
				open = "Neotree",
				pinned = true,
				size = { height = 0.75 },
				wo = {
					winbar = true,
				},
			},
		},
		right = {
			{
				ft = "Outline",
				visible = false,
				size = { height = 0.25 },
				pinned = true,
				open = "SymbolsOutlineOpen",
				wo = {
					winbar = true,
				},
			},
			-- {
			-- 	ft = "help",
			-- 	size = { width = 79 },
			-- 	filter = function(buf)
			-- 		return vim.bo[buf].buftype == "help"
			-- 	end,
			-- 	wo = {
			-- 		winbar = true,
			-- 		winhighlight = "Normal:EdgyHelpNormal",
			-- 	},
			-- },
			{
				title = "Tests",
				ft = "neotest-summary",
				pinned = true,
				open = "Neotest summary",
				size = { width = 30 },
				wo = {
					winbar = true,
					wrap = false,
				},
			},
		},
		fix_win_height = vim.fn.has("nvim-0.10.0") == 0,
	},
}
