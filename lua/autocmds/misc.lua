-- Return to previous line in fileauto
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = { "*" },
	callback = function()
		Util.line_return()
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

vim.api.nvim_create_autocmd("WinEnter", {
	pattern = { "*" },
	callback = function()
		if vim.fn.winnr("$") == 1 and vim.bo.buftype == "quickfix" then
			vim.cmd([[q]])
		end
	end,
	group = "qf",
})

-- make `q` close the window for these + other ui options
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
