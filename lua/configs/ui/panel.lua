return function()
	local function openToggleTerm()
		vim.cmd(
			"vsplit +term\\ tmux-tools\\ nest\\ --tmux-config\\ ~/.config/tmux/nested.conf"
		)
		local hideMe = vim.api.nvim_get_current_win()

		local buf = vim.api.nvim_get_current_buf()

		vim.bo[buf].buflisted = false
		vim.bo[buf].filetype = "toggleterm"

		vim.api.nvim_buf_set_name(
			buf,
			"terminal" .. vim.api.nvim_get_current_tabpage()
		)

		vim.o.mousemoveevent = true

		-- Strictly for if we want to click on a panel tab (can't click in insert mode apparently)
		vim.keymap.set("i", "<MouseMove>", function()
			buf = vim.api.nvim_get_current_buf()
			if vim.bo[buf].filetype == "toggleterm" then
				vim.cmd("stopinsert")
			end
		end, { silent = true })

		vim.api.nvim_create_augroup("PanelToggleTerm", { clear = true })
		vim.api.nvim_create_autocmd({ "TermEnter", "WinEnter", "BufEnter" }, {
			group = "PanelToggleTerm",
			callback = function()
				Util.defer(function()
					buf = vim.api.nvim_get_current_buf()
					if vim.bo[buf].filetype == "toggleterm" then
						vim.cmd("startinsert")
					end
				end, 10)
			end,
		})

		vim.api.nvim_win_hide(hideMe)

		return buf
	end

	require("panel").setup({
		size = 15,
		tabScoped = true,
		extPanels = {
			"neo-tree",
			"Outline",
			"neotest-summary",
		},
		views = {
			{
				name = "Terminal",
				ft = "toggleterm",
				open = openToggleTerm,
				close = false,
				wo = {
					winhighlight = "Normal:PanelNormal",
					number = false,
					relativenumber = false,
					wrap = false,
					list = false,
					signcolumn = "no",
					statuscolumn = "",
				},
			},
			{
				name = "Problems",
				ft = "Trouble",
				open = function()
					require("trouble").open({
						win = require("panel").getWin(),
					})

					local bufid = vim.api.nvim_get_current_buf()

					vim.bo[bufid].buflisted = false

					return bufid
				end,
				close = function()
					require("trouble").close(false)
				end,
				wo = {
					winhighlight = "Normal:PanelNormal",
				},
			},
			{
				name = "Quickfix",
				ft = "qf",
				open = function()
					vim.cmd(":copen")
					local bufid = vim.api.nvim_get_current_buf()

					vim.api.nvim_win_hide(vim.api.nvim_get_current_win())

					return bufid
				end,
				close = false,
				wo = {
					winhighlight = "Normal:PanelNormal",
				},
			},
			-- {
			-- 	name = "Help",
			-- 	ft = "help",
			-- 	open = function()
			-- 		-- just open `:help help` by default
			-- 		vim.cmd("help help")
			-- 		local bufid = vim.api.nvim_get_current_buf()
			-- 		vim.api.nvim_win_hide(vim.api.nvim_get_current_win())

			-- 		return bufid
			-- 	end,
			-- 	close = false,
			-- 	wo = {
			-- 		number = false,
			-- 		relativenumber = false,
			-- 		list = false,
			-- 		signcolumn = "no",
			-- 		statuscolumn = "",
			-- 		winhighlight = "Normal:PanelNormal",
			-- 	},
			-- },
			{
				name = "Notes",
				ft = "fnote",
				open = function()
					require("fnote").open(false)

					return require("fnote").bufid
				end,
				close = false,
				wo = {
					winhighlight = "Normal:PanelNormal",
				},
			},
		},
	})
end
