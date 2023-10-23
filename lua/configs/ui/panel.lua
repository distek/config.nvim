return function()
	local function openToggleTerm()
		vim.cmd("vsplit +term\\ tmux-nest")
		local hideMe = vim.api.nvim_get_current_win()

		local buf = vim.api.nvim_get_current_buf()

		vim.bo[buf].buflisted = false
		vim.bo[buf].filetype = "toggleterm"

		vim.api.nvim_buf_set_name(buf, "terminal")

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
		views = {
			{
				name = "Terminal",
				ft = "toggleterm",
				open = openToggleTerm,
				close = false,
				wo = {
					winhighlight = "Normal:EdgyTermNormal",
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
						win = require("panel").win,
					})

					local bufid = vim.api.nvim_get_current_buf()

					vim.bo[bufid].buflisted = false

					vim.api.nvim_create_autocmd({
						"BufEnter",
					}, {
						callback = function(ev)
							if string.match(ev.match, "Trouble") then
								require("trouble").set_win(require("panel").win)
							end
						end,
					})

					return bufid
				end,
				close = false,
				wo = {
					winhighlight = "Normal:EdgyTermNormal",
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
					winhighlight = "Normal:EdgyTermNormal",
				},
			},
			{
				name = "Help",
				ft = "help",
				open = function()
					local bufid = 0
					for _, v in ipairs(vim.api.nvim_list_bufs()) do
						if vim.bo[v].filetype == "help" then
							bufid = v
							for _, win in vim.api.nvim_list_wins() do
								if vim.api.nvim_win_get_buf(win) == bufid then
									vim.api.nvim_win_hide(win)
									break
								end
							end
							break
						end
					end

					if bufid == 0 then
						vim.cmd("help help")
						bufid = vim.api.nvim_get_current_buf()
						vim.api.nvim_win_hide(vim.api.nvim_get_current_win())
					end

					return bufid
				end,
				close = false,
				wo = {
					number = false,
					relativenumber = false,
					list = false,
					signcolumn = "no",
					statuscolumn = "",
					winhighlight = "Normal:EdgyTermNormal",
				},
			},
			{
				name = "Notes",
				ft = "notes",
				open = function()
					require("fnote").new()

					return require("fnote").bufid
				end,
				close = false,
				wo = {
					winhighlight = "Normal:EdgyTermNormal",
				},
			},
		},
	})
end
