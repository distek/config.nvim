return function()
	require("bufferline").setup({
		animation = false,
		no_name_title = "-empty-",
		exclude_ft = {
			"toggleterm",
			"termlist",
			"qf",
		},
		focus_on_close = "left",
		insert_at_end = true,
		-- sidebar_filetypes = {
		-- 	["neo-tree"] = true,
		-- },
	})
	require("bufferline.api").set_offset(8, "Neovim")
end
