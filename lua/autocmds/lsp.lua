local lspAutos = vim.api.nvim_create_augroup("lspAutos", { clear = true })

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
	group = lspAutos,
})

vim.api.nvim_create_autocmd("CursorHold", {
	pattern = { "<buffer>" },
	callback = function()
		local clients = vim.lsp.get_clients()

		if not next(clients) then
			return
		end

		if clients[1].server_capabilities.documentHighlightProvider then
			vim.lsp.buf.document_highlight()
		end
	end,
	group = lspAutos,
})

-- highlight - insert
vim.api.nvim_create_autocmd("CursorHoldI", {
	pattern = { "<buffer>" },
	callback = function()
		local clients = vim.lsp.get_clients()

		if not next(clients) then
			return
		end

		if clients[1].server_capabilities.signatureHelpProvider ~= nil then
			vim.lsp.buf.signature_help()
		end
	end,
	group = lspAutos,
})

-- highlight clear on move
vim.api.nvim_create_autocmd("CursorMoved", {
	pattern = { "<buffer>" },
	callback = function()
		vim.lsp.buf.clear_references()
	end,
	group = lspAutos,
})
