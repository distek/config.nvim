vim.opt_local.keywordprg = ":vert Man"

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "*.c", "*.h", "*.cpp", "*.hpp" },
	callback = function()
		vim.opt_local.filetype = "c.doxygen"
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.expandtab = false
	end,
})
