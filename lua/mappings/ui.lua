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

map({ "n" }, "<leader>ad", function()
	require("edgy").toggle("left")
end, { desc = "Left panel" })

map({ "n" }, "<leader>af", function()
	require("edgy").toggle("right")
end, { desc = "Right panel" })

map({ "t", "n" }, "<A-CR>", function()
	Util.NewTerm()
end)

map("n", "<leader>z", ":ZenMode<cr>", { desc = "Zen mode" })

local termZenMode = false
local termLast = 0
map("n", "<A-f>", function()
	if
		vim.api.nvim_get_current_buf()
		== Util.Terms[Util.GetCurrentTermIdx()].Buf
	then
		if termZenMode then
			vim.bo[termLast].filetype = "toggleterm"
			termZenMode = false
		else
			termLast = Util.Terms[Util.GetCurrentTermIdx()].Buf
			vim.bo[termLast].filetype = "toggletermzen"
			termZenMode = true
		end
	end
	require("zen-mode").toggle({
		window = {
			width = 1.0,
		},
	})
end, { desc = "Fullscreen window" })

map("t", "<A-f>", function()
	-- -- Esc to tell error to close
	if
		vim.api.nvim_get_current_buf()
		== Util.Terms[Util.GetCurrentTermIdx()].Buf
	then
		if termZenMode then
			vim.bo[termLast].filetype = "toggleterm"
			termZenMode = false
		else
			termLast = Util.Terms[Util.GetCurrentTermIdx()].Buf
			vim.bo[termLast].filetype = "toggletermzen"
			termZenMode = true
		end
	end

	vim.api.nvim_feedkeys(
		vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
		"t",
		false
	)

	vim.api.nvim_feedkeys(
		vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true),
		"t",
		false
	)

	require("zen-mode").toggle({
		window = {
			width = 1,
		},
	})
end, { desc = "Fullscreen window" })

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

for i = 1, 10 do
	local n = 0
	if i == 10 then
		n = 0
	else
		n = i
	end

	map({ "t", "n" }, "<A-" .. n .. ">", function()
		Util.TermSet(i)
	end, { desc = "Focus terminal " .. i })
end
