local ftAutos = vim.api.nvim_create_augroup("filetypeAutos", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"fugitive",
		"scratch",
		"help",
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

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help" },
	callback = function()
		vim.keymap.set("n", "<CR>", "<C-]>", { silent = true, buffer = true })
	end,
	group = ftAutos,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {"gdscript"},
	callback = function()
		require("filetypes.gdscript"):StartGodotLSP()
	end,
	group = ftAutos
})
