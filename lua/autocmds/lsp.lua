-- Automatically format buffers
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*" },
	callback = function()
		if vim.bo[0].filetype == "typescript" or vim.bo[0].filetype == "typescriptreact" then
			return
		end
		local view = vim.fn.winsaveview()
		vim.lsp.buf.format({ async = false })
		vim.fn.winrestview(view)
	end,
})
