local map = vim.keymap.set

-- map("n", "<leader>as", function()
-- 	require("panel").toggle()
-- end, { desc = "Bottom panel" })

-- map("t", "<localleader>as", function()
-- 	require("panel").toggle()
-- end, { desc = "Bottom panel" })

map("n", "<leader>as", function()
	require("edgy").toggle("bottom")
end, { desc = "Bottom panel" })

map("t", "<localleader>as", function()
	require("edgy").toggle("bottom")
end, { desc = "Bottom panel" })

map({ "n", "t" }, "<leader>ad", function()
	require("edgy").toggle("left")
end, { desc = "Left panel" })

map({ "n", "t" }, "<leader>af", function()
	require("edgy").toggle("right")
end, { desc = "Right panel" })

map({ "t", "n" }, "<A-CR>", function()
	Util.NewTerm()
end)

map("n", "<leader>z", ":ZenMode<cr>", { desc = "Zen mode" })

map("n", "<A-f>", function()
	require("zen-mode").toggle({
		window = {
			width = 1.0,
		},
	})
end, { desc = "Fullscreen window" })

map("t", "<A-f>", function()
	-- Esc to tell error to close
	vim.api.nvim_feedkeys(
		vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
		"t",
		false
	)

	-- _THEN_ exit terminal mode
	vim.api.nvim_feedkeys(
		vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true),
		"t",
		false
	)

	-- _Then_ toggle zen mode?
	require("zen-mode").toggle({
		window = {
			width = 1.0,
		},
	})

	-- And everything works magically idk why
end, { desc = "Fullscreen window" })

for i = 1, 9, 1 do
	map({ "t", "v", "n" }, "<leader>" .. i, function()
		vim.api.nvim_set_current_tabpage(i)
	end, { desc = "Switch to tab index " .. i })
end

ColorSchemeIdx = 1
ColorSchemes = vim.fn.getcompletion("", "color")
map("n", "<leader>Tn", function()
	ColorSchemeIdx = ColorSchemeIdx + 1
	if ColorSchemeIdx == #ColorSchemes then
		ColorSchemeIdx = 1
	end

	vim.cmd("colorscheme " .. ColorSchemes[ColorSchemeIdx])
	print(ColorSchemes[ColorSchemeIdx])
end)

map("n", "<leader>Tp", function()
	ColorSchemeIdx = ColorSchemeIdx - 1
	if ColorSchemeIdx == 0 then
		ColorSchemeIdx = #ColorSchemes
	end

	vim.cmd("colorscheme " .. ColorSchemes[ColorSchemeIdx])
	print(ColorSchemes[ColorSchemeIdx])
end)
