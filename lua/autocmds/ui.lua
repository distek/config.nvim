local UIAutos = vim.api.nvim_create_augroup("UIAutos", { clear = true })

vim.api.nvim_create_autocmd("WinEnter", {
	group = UIAutos,
	callback = function()
		local pattern = { "neo-tree", "toggleterm", "termlist", "Outline", "neotest-summary" }

		local buf = vim.api.nvim_win_get_buf(0)
		if vim.b[buf].ministatusline_disable then
			return
		end

		local ft = vim.bo[buf].filetype
		for _, v in ipairs(pattern) do
			if ft == v then
				vim.b[buf].ministatusline_disable = true
				return
			end
		end
	end,
})
