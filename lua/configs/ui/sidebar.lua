return function()
	local defaultKeys = {
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
	}

	local defaultWinOpts = {
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
	}

	require("sidebar").setup({
		defaultLayout = "normal",
		layouts = {
			["normal"] = {
				options = {
					left = { size = 35 },
					top = { size = 15 },
					bottom = { size = 15 },
					right = { size = 35 },
				},
				exit_when_last = false,
				wo = {
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
				keys = defaultKeys,
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
			["second"] = {
				options = {
					left = { size = 35 },
					top = { size = 15 },
					bottom = { size = 15 },
					right = { size = 35 },
				},
				exit_when_last = false,
				wo = defaultWinOpts,
				keys = defaultKeys,
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
				},
				fix_win_height = vim.fn.has("nvim-0.10.0") == 0,
			},
			["debug"] = {
				options = {
					left = { size = 35 },
					top = { size = 15 },
					bottom = { size = 15 },
					right = { size = 35 },
				},
				exit_when_last = false,
				wo = defaultWinOpts,
				keys = defaultKeys,
				animate = {
					enabled = false,
				},
				top = {
					{
						title = "DAP Repl",
						ft = "dap-repl",
						size = { height = 0.25 },
						open = function()
							require("dapui").elements["repl"].render()
							vim.api.nvim_win_set_buf(
								vim.api.nvim_get_current_win(),
								require("dapui").elements["repl"].buffer()
							)
						end,
						pinned = true,
						wo = {
							winbar = true,
						},
					},
				},
				left = {
					{
						title = "Scopes",
						ft = "dapui_scopes",
						size = { height = 0.25 },
						open = function()
							require("dapui").elements["scopes"].render()
							vim.api.nvim_win_set_buf(
								vim.api.nvim_get_current_win(),
								require("dapui").elements["scopes"].buffer()
							)
						end,
						pinned = true,
						wo = {
							winbar = true,
						},
					},
					{
						title = "Breakpoints",
						ft = "dapui_breakpoints",
						size = { height = 0.25 },
						open = function()
							require("dapui").elements["breakpoints"].render()
							vim.api.nvim_win_set_buf(
								vim.api.nvim_get_current_win(),
								require("dapui").elements["breakpoints"].buffer()
							)
						end,
						pinned = true,
						wo = {
							winbar = true,
						},
					},
					{
						title = "Stacks",
						ft = "dapui_stacks",
						size = { height = 0.25 },
						open = function()
							local bufid =
								require("dapui").elements["stacks"].buffer()
							require("dapui").elements["stacks"].render()
							vim.api.nvim_win_set_buf(
								vim.api.nvim_get_current_win(),
								bufid
							)
						end,
						pinned = true,
						wo = {
							winbar = true,
						},
					},
					{
						title = "Watches",
						ft = "dapui_watches",
						size = { height = 0.25 },
						open = function()
							require("dapui").elements["watches"].render()
							vim.api.nvim_win_set_buf(
								vim.api.nvim_get_current_win(),
								require("dapui").elements["watches"].buffer()
							)
						end,
						pinned = true,
						wo = {
							winbar = true,
						},
					},
				},
				right = {
					{
						title = "Console",
						ft = "dapui_console",
						size = { height = 3 },
						open = function()
							vim.cmd("split")
							vim.api.nvim_win_set_buf(
								vim.api.nvim_get_current_win(),
								require("dapui").elements["console"].buffer()
							)
						end,
						pinned = true,
						wo = {
							winbar = true,
						},
					},
				},
				fix_win_height = vim.fn.has("nvim-0.10.0") == 0,
			},
		},
	})
end
