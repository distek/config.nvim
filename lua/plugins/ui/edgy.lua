return {
	"folke/edgy.nvim",
	event = "VeryLazy",
	config = function()
		require("edgy").setup({
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
				winbar = true,
				winfixwidth = true,
				winfixheight = true,
				winhighlight = "WinBar:EdgyWinBar",
				spell = false,
				-- statuscolumn = "",
				-- signcolumn = "number",
				-- number = true,
				-- numberwidth = 4,
				-- relativenumber = true,
			},
			keys = {
				["q"] = false,
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
					title = "Files",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "filesystem"
					end,
					size = { height = 0.75 },
					open = "Neotree position=left filesystem",
					wo = {
						winbar = " Files",
					},
				},
				{
					ft = "dapui_scopes",
					title = "Scopes",
					wo = { winbar = " Scopes" },
					open = function()
						require("dapui").open()
					end,
				},
				{
					ft = "dapui_breakpoints",
					title = "Breakpoints",
					wo = { winbar = " Breakpoints" },
					open = function()
						require("dapui").open()
					end,
				},
				{
					ft = "dapui_stacks",
					title = "Stacks",
					wo = { winbar = " Stacks" },
					open = function()
						require("dapui").open()
					end,
				},
				{
					ft = "dapui_watches",
					title = "Watches",
					wo = { winbar = " Watches" },
					open = function()
						require("dapui").open()
					end,
				},
			},
			right = {
				{
					title = "Outline",
					ft = "Outline",
					visible = false,
					size = { height = 0.75 },
					open = "SymbolsOutlineOpen",
					wo = {
						winhighlight = "Normal:NormalDark",
						winbar = true,
					},
				},
				{
					title = "Tests",
					ft = "neotest-summary",
					open = "Neotest summary",
					size = { width = 30 },
					wo = {
						winhighlight = "Normal:NormalDark",
						winbar = true,
						wrap = false,
					},
				},
			},
			bottom = {
				{
					title = "Terminal",
					ft = "toggleterm",
					open = function()
						Util.OpenTerm()
						-- require("panel").open({
						-- 	name = "Terminal",
						-- 	focus = false,
						-- })
					end,
					wo = {
						winhighlight = "Normal:NormalDarker",
						number = false,
						relativenumber = false,
						wrap = false,
						list = false,
						signcolumn = "no",
						statuscolumn = "",
						-- wo = {
						-- 	winbar = false,
						-- },
					},
				},
				{
					title = "List",
					ft = "termlist",
					size = { width = 20 },
					wo = {
						winhighlight = "Normal:NormalDark",
						winbar = true,
						wrap = false,
					},
				},
				{
					ft = "dapui_console",
					title = "Debug Console",
					wo = { winbar = " Debug Console" },
					open = function()
						require("dapui").open()
					end,
				},
				{
					ft = "dap-repl",
					title = "Debug REPL",
					wo = { winbar = false, statuscolumn = "" },
					open = function()
						require("dapui").open()
					end,
				},
			},
			fix_win_height = vim.fn.has("nvim-0.10.0") == 0,
		})
	end,
}
