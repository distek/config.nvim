-- -- Automatically format buffers
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*" },
	callback = function()
		if vim.bo[0].filetype == "go" then
			require("go.format").goimport()
		else
			vim.lsp.buf.format({
				async = false,
			})
		end
	end,
})

-- LSP - documentHighlight
-- highlight - normal
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
})

-- highlight - insert
vim.api.nvim_create_autocmd("CursorHoldI", {
	pattern = { "<buffer>" },
	callback = function()
		local clients = vim.lsp.get_active_clients()

		if not next(clients) then
			return
		end

		if clients[1].server_capabilities.documentHighlightProvider then
			vim.lsp.buf.document_highlight()
		end
	end,
})

-- highlight clear on move
vim.api.nvim_create_autocmd("CursorMoved", {
	pattern = { "<buffer>" },
	callback = function()
		vim.lsp.buf.clear_references()
	end,
})
