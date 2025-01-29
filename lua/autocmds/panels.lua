-- Remove cursorline in insert mode
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	pattern = { "*" },
	callback = function(ev)
		local fts = { "qf", "neo-tree", "neotest-summary", "Outline", "Trouble" }
		for _, v in ipairs(fts) do
			if vim.bo[ev.buf].filetype == v then
				return
			end
		end
		vim.o.cursorline = true
	end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
	pattern = { "*" },
	callback = function(ev)
		local fts = { "qf", "neo-tree", "neotest-summary", "Outline", "Trouble" }
		for _, v in ipairs(fts) do
			if vim.bo[ev.buf].filetype == v then
				return
			end
		end
		vim.o.cursorline = false
	end,
})
