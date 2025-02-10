local ftAutos = vim.api.nvim_create_augroup("filetypeAutos", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"fugitive",
		"scratch",
	},
	callback = function()
		vim.keymap.set("n", "q", ":close<cr>", { buffer = true, silent = true })
	end,
	group = ftAutos,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.md" },
	callback = function()
		vim.cmd([[setlocal spell]])
	end,
	group = ftAutos,
})
