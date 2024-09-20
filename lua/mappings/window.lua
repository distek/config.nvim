local map = vim.keymap.set

-- Window/buffer stuff
map("n", "<leader>ss", "<cmd>split<cr>", { desc = "Split horizontal" })
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split Vertical" })

-- Window movement
map("n", "<A-S-h>", "<cmd>WinShift left<cr>")
map("n", "<A-S-j>", "<cmd>WinShift down<cr>")
map("n", "<A-S-k>", "<cmd>WinShift up<cr>")
map("n", "<A-S-l>", "<cmd>WinShift right<cr>")

-- Navigate windows/panes incl. tmux
map({ "n", "v", "t" }, "<A-j>", function()
	Util.win_focus("down")
end)
map({ "n", "v", "t" }, "<A-k>", function()
	Util.win_focus("up")
end)
map({ "n", "v", "t" }, "<A-l>", function()
	Util.win_focus("right")
end)
map({ "n", "v", "t" }, "<A-h>", function()
	Util.win_focus("left")
end)

map({ "n", "v" }, "<A-C-j>", function()
	Util.win_resize("bottom")
end)
map({ "n", "v" }, "<M-NL>", function()
	Util.win_resize("bottom")
end)
map({ "n", "v" }, "<A-C-k>", function()
	Util.win_resize("top")
end)
map({ "n", "v" }, "<M-C-K>", function()
	Util.win_resize("top")
end)
map({ "n", "v" }, "<A-C-l>", function()
	Util.win_resize("right")
end)
map({ "n", "v" }, "<A-C-h>", function()
	Util.win_resize("left")
end)
