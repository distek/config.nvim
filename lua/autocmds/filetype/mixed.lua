vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = {
		"fugitive",
		"gitcommit",
		"scratch",
		"starter",
	},
	callback = function(ev)
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.list = false
		vim.opt_local.signcolumn = "no"
		vim.opt_local.statuscolumn = ""
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"help",
		"fugitive",
		"gitcommit",
		"scratch",
	},
	callback = function()
		vim.keymap.set("n", "q", ":close<cr>", { buffer = true, silent = true })
	end,
})
