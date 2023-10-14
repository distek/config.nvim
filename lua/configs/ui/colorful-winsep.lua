return function()
	require("colorful-winsep").setup({
		-- symbols = { "█", "█", "█", "█", "█", "█" },
		symbols = { "━", "┃", "┏", "┓", "┗", "┛" },

		no_exec_files = { "lazy", "TelescopePrompt", "mason", "" },
		create_event = function()
			if
				vim.api.nvim_win_get_config(vim.api.nvim_get_current_win()).relative
				== "editor"
			then
				require("colorful-winsep").NvimSeparatorDel()
			end
		end,
	})
end
