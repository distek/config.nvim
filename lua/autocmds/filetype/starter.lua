vim.api.nvim_create_autocmd({ "VimEnter", "FileType" }, {
	callback = function(ev)
		if vim.bo[ev.buf].filetype == "starter" then
			vim.opt_local.number = false
			vim.opt_local.relativenumber = false
			vim.opt_local.list = false
			vim.opt_local.signcolumn = "no"
			vim.opt_local.statuscolumn = ""
		end
	end,
})
