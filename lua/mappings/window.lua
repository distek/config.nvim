local map = vim.keymap.set

-- Window/buffer stuff
map("n", "<leader>ss", "<cmd>split<cr>", { desc = "Split horizontal" })
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split Vertical" })

-- Close window(split)
map("n", "<A-q>", "<cmd>bn|bd #<cr>")

-- Window movement
map("n", "<A-S-h>", "<cmd>WinShift left<cr>")
map("n", "<A-S-j>", "<cmd>WinShift down<cr>")
map("n", "<A-S-k>", "<cmd>WinShift up<cr>")
map("n", "<A-S-l>", "<cmd>WinShift right<cr>")

-- Navigate windows/panes incl. tmux
map("n", "<A-j>", function()
	Util.win_focus("down")
end)
map("n", "<A-k>", function()
	Util.win_focus("up")
end)
map("n", "<A-l>", function()
	Util.win_focus("right")
end)
map("n", "<A-h>", function()
	Util.win_focus("left")
end)

map("v", "<A-j>", function()
	Util.win_focus("down")
end)
map("v", "<A-k>", function()
	Util.win_focus("up")
end)
map("v", "<A-l>", function()
	Util.win_focus("right")
end)
map("v", "<A-h>", function()
	Util.win_focus("left")
end)

map("t", "<A-j>", function()
	Util.win_focus("down")
end)
map("t", "<A-k>", function()
	Util.win_focus("up")
end)
map("t", "<A-l>", function()
	Util.win_focus("right")
end)
map("t", "<A-h>", function()
	Util.win_focus("left")
end)

map("n", "<A-C-j>", function()
	Util.win_resize("bottom")
end)
map("n", "<M-NL>", function()
	Util.win_resize("bottom")
end)
map("n", "<A-C-k>", function()
	Util.win_resize("top")
end)
map("n", "<M-C-K>", function()
	Util.win_resize("top")
end)
map("n", "<A-C-l>", function()
	Util.win_resize("right")
end)
map("n", "<A-C-h>", function()
	Util.win_resize("left")
end)

map("v", "<A-C-j>", function()
	Util.win_resize("bottom")
end)
map("v", "<A-C-k>", function()
	Util.win_resize("top")
end)
map("v", "<A-C-l>", function()
	Util.win_resize("right")
end)
map("v", "<A-C-h>", function()
	Util.win_resize("left")
end)

map("t", "<A-C-j>", function()
	Util.win_resize("bottom")
end)
map("t", "<A-C-k>", function()
	Util.win_resize("top")
end)
map("t", "<A-C-l>", function()
	Util.win_resize("right")
end)
map("t", "<A-C-h>", function()
	Util.win_resize("left")
end)

map({ "t", "n" }, "<A-[>", function()
	require("panel").previous()
end)

map({ "t", "n" }, "<A-]>", function()
	require("panel").next()
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
