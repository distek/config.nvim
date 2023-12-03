vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		Util.defer(function()
			vim.cmd("set cmdheight=1")
		end, 10)
	end,
})
