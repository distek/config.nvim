vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd("set cmdheight=1")
	end,
})
