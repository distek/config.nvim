return {
	"sirtaj/vim-openscad",
	ft = { "openscad" },
	config = function()
		Util.defer(function()
			vim.cmd("set commentstring=//\\ %s")
			vim.keymap.set("v", "<leader>cm", ":Commentary<cr>")
		end, 50)
	end,
	lazy = true,
}
