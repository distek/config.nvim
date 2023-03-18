-- Return to previous line in fileauto
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = { "*" },
	callback = function()
		Util.line_return()
	end,
})

-- -- Automatically format buffers
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*" },
	callback = function()
		vim.lsp.buf.format({
			async = false,
		})
	end,
})

-- LSP - documentHighlight
-- highlight - normal
vim.api.nvim_create_autocmd("CursorHold", {
	pattern = { "<buffer>" },
	callback = function()
		local clients = vim.lsp.get_active_clients()

		if not next(clients) then
			return
		end

		if clients[1].server_capabilities.documentHighlightProvider then
			vim.lsp.buf.document_highlight()
		end
	end,
})

-- highlight - insert
vim.api.nvim_create_autocmd("CursorHoldI", {
	pattern = { "<buffer>" },
	callback = function()
		local clients = vim.lsp.get_active_clients()

		if not next(clients) then
			return
		end

		if clients[1].server_capabilities.documentHighlightProvider then
			vim.lsp.buf.document_highlight()
		end
	end,
})

-- highlight clear on move
vim.api.nvim_create_autocmd("CursorMoved", {
	pattern = { "<buffer>" },
	callback = function()
		vim.lsp.buf.clear_references()
	end,
})

-- Deal with quickfix
-- set nobuflisted and close if last window
vim.api.nvim_create_augroup("qf", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf" },
	callback = function()
		vim.o.buflisted = false
	end,
	group = "qf",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"neo-tree",
		"Outline",
	},
	callback = function(args)
		vim.defer_fn(function()
			local wid = vim.fn.bufwinid(args.buf)
			vim.api.nvim_set_option_value("statuscolumn", "", { scope = "local", win = wid })
		end, 1)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"help",
		"fugitive",
		"gitcommit",
		"qf",
	},
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.list = false
		vim.opt_local.signcolumn = "no"
		vim.opt_local.statuscolumn = ""

		vim.keymap.set("n", "q", ":close<cr>", { buffer = true, silent = true })
	end,
})

vim.api.nvim_create_autocmd("WinEnter", {
	pattern = { "*" },
	callback = function()
		if vim.fn.winnr("$") == 1 and vim.bo.buftype == "quickfix" then
			vim.cmd([[q]])
		end
	end,
	group = "qf",
})

-- Terminal
vim.api.nvim_create_augroup("Terminal", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "toggleterm" },
	callback = function()
		vim.cmd([[startinsert]])
	end,
	group = "Terminal",
})

vim.api.nvim_create_augroup("markdown", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = { "*" },
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.wrap = true
		vim.opt_local.list = false
		vim.opt_local.signcolumn = "no"
		vim.opt_local.statuscolumn = ""
		vim.cmd([[startinsert]])
	end,
	group = "Terminal",
})

vim.api.nvim_create_autocmd("WinEnter", {
	pattern = { "*" },
	callback = function(ev)
		if vim.bo[ev.buf].buftype == "terminal" then
			vim.cmd([[startinsert]])
		end
	end,
	group = "Terminal",
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.md" },
	callback = function()
		vim.cmd([[setlocal spell]])
	end,
	group = "markdown",
})

-- Remove cursorline in insert mode
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	pattern = { "*" },
	callback = function()
		vim.o.cursorline = true
	end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
	pattern = { "*" },
	callback = function()
		vim.o.cursorline = false
	end,
})

vim.api.nvim_create_autocmd({ "VimResized", "WinEnter", "WinClosed" }, {
	callback = function()
		vim.defer_fn(function()
			local panelWidth = 40

			local exists, window = Util.ifNameExists("neo-tree")
			if exists then
				vim.api.nvim_win_set_width(window, panelWidth)
			end

			if TF.Term[vim.api.nvim_get_current_tabpage()] ~= nil then
				TF.Term[vim.api.nvim_get_current_tabpage()].window.height = TF.Height
				TF.Term[vim.api.nvim_get_current_tabpage()].window:update_size()
			end
		end, 1)
	end,
})

vim.api.nvim_create_autocmd({ "WinClosed" }, {
	callback = function()
		vim.defer_fn(function()
			if
				not vim.bo.filetype == "neo-tree"
				or not vim.bo.filetype == "Outline"
				or not vim.bo.filetype == "toggleterm"
			then
				return
			end

			local winCount = 0
			local compCount = 0

			for _, v in ipairs(vim.api.nvim_list_wins()) do
				if vim.api.nvim_win_get_config(v).relative == "" then
					local ft = vim.api.nvim_win_call(v, function()
						return vim.bo.filetype
					end)

					if ft == "neo-tree" or ft == "toggleterm" or ft == "Outline" then
						compCount = compCount + 1
					end
					winCount = winCount + 1
				end
			end

			if winCount == compCount then
				vim.cmd("qa!")
			end
		end, 1)
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = {
		"*",
	},
	callback = function()
		local tp = vim.api.nvim_get_current_tabpage()
		if TF.Term[tp] ~= nil then
			if TF.Term[tp].window:is_valid() then
				if vim.api.nvim_get_current_win() == TF.Term[tp].window.winid then
					vim.defer_fn(function()
						if #TF.Term[tp].bufs > 0 then
							local nextBuf = TF.Term[tp].bufs[TF.Term[tp].last_term]
							if not nextBuf then
								nextBuf = TF.Term[tp].bufs[TF.Term[tp].last_term - 1]
								if not nextBuf then
									nextBuf = TF.Term[tp].bufs[TF.Term[tp].last_term + 1]
								end
							end
							vim.api.nvim_win_set_buf(TF.Term[tp].window.winid, TF.Term[tp].bufs[TF.Term[tp].last_term])
						end
					end, 1)
				end
			end
		end
	end,
})
