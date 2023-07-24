-- Terminal
vim.api.nvim_create_augroup("Terminal", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "toggleterm" },
	callback = function()
		vim.cmd([[startinsert]])
	end,
	group = "Terminal",
})
