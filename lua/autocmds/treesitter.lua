-- Add this to your init.lua if you aren't using the nvim-treesitter plugin
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("AutoTreesitterStart", { clear = true }),
	callback = function()
		pcall(vim.treesitter.start)
	end,
})
