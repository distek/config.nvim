vim.api.nvim_create_augroup("markdown", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.md" },
	callback = function()
		vim.cmd([[setlocal spell]])
	end,
	group = "markdown",
})

-- make `q` close the window for these + other ui options
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"help",
		"fugitive",
		"toggleterm",
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
