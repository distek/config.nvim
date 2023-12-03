-- Workaround for telescope selection opening file in inswer mode
vim.api.nvim_create_autocmd("WinLeave", {
	callback = function()
		if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
			vim.api.nvim_feedkeys(
				vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
				"i",
				false
			)
		end
	end,
})
