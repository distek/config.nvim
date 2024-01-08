local map = vim.keymap.set

map("n", "<leader>as", function()
	require("panel").toggle()
end, { desc = "Bottom panel" })

map("t", "<localleader>as", function()
	require("panel").toggle()
end, { desc = "Bottom panel" })

map({ "n", "t" }, "<leader>ad", function()
	require("edgy").toggle("left")
end, { desc = "Left panel" })

map({ "n", "t" }, "<leader>af", function()
	require("edgy").toggle("right")
end, { desc = "Right panel" })

map({ "t", "n" }, "<A-[>", function()
	-- Ignore autos unless we're going into Terminal ("so the auto-insert auto still works")
	-- This mitigates issues with trouble.nvim
	if require("panel").getPrevious() == "Terminal" then
		require("panel").previous()
	else
		vim.cmd("noautocmd lua require('panel').previous()")
	end
end)

map({ "t", "n" }, "<A-]>", function()
	if require("panel").getNext() == "Terminal" then
		require("panel").next()
	else
		vim.cmd("noautocmd lua require('panel').next()")
	end
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
