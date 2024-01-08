-- Automatically format buffers
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*" },
	callback = function()
		local view = vim.fn.winsaveview()
		vim.lsp.buf.format({ async = false })
		vim.fn.winrestview(view)
	end,
})
