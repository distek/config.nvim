Themes = {}

Lush = {}

Themes["lush"] = function()
	local lush = require("ui.themes-lush")

	require("lush")(lush)

	-- require("tint").setup({
	-- 	window_ignore_function = function(winid)
	-- 		local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
	-- 		-- Do not tint `terminal` or floating windows, tint everything else
	-- 		return floating
	-- 	end,
	-- })
end

Themes.lush()
