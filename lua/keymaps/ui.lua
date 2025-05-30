local map = vim.keymap.set

-- Window/buffer stuff
map("n", "<leader>ss", "<cmd>split<cr>", { desc = "Split horizontal" })
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split Vertical" })

map("n", "<Tab>", function()
	vim.cmd("BufferLineCycleNext")
end)
map("n", "<S-Tab>", function()
	vim.cmd("BufferLineCyclePrev")
end)

map("n", "<A-]>", function()
	vim.cmd("BufferLineCycleNext")
end)
map("n", "<A-[>", function()
	vim.cmd("BufferLineCyclePrev")
end)

map("n", "<A-f>", function()
	require("mini.misc").zoom(0, {
		height = vim.o.lines - vim.o.cmdheight - 1,
	})
end, { desc = "Zoom pane" })

map("t", "<A-f>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, true, true), "n", false)
	Util.defer(function()
		require("mini.misc").zoom(0, {
			height = vim.o.lines - vim.o.cmdheight - 1,
		})
		vim.cmd("silent startinsert!")
	end, 1)
end, { desc = "Zoom pane" })

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

-- Close split
map("n", "<A-S-q>", function()
	--	local compCount, winCount = Util.compVsWinCount()
	--
	--	if winCount - 1 == compCount then
	--		vim.notify("Cannot close last editor window")
	--		return
	--	end

	vim.cmd("wincmd c")
end)

-- Delete buffer
map("n", "<A-q>", function()
	if #Util.GetNormalBuffers() > 1 then
		vim.cmd("bp")
		vim.cmd("bd #")
	else
		if #Util.GetNormalBuffers() == 1 then
			if vim.api.nvim_buf_get_name(0) and vim.bo[0].filetype == "" then
				return
			end
		end

		vim.cmd("enew")
		vim.cmd("bd #")
	end
end)

map("n", "<Esc><Esc>", function()
	if vim.bo[0].filetype == "harpoon" then
		require("harpoon").ui:close_menu()
	end
	vim.cmd("nohl")
end, { silent = true })

map("n", "<leader>as", function()
	require("edgy-group").open_group_index("bottom", 1)
end, { desc = "Bottom panel" })

map("t", "<localleader>as", function()
	require("edgy-group").open_group_index("bottom", 1)
end, { desc = "Bottom panel" })

map({ "n" }, "<leader>ad", function()
	require("edgy-group").open_group_index("left", 1)
end, { desc = "Left panel" })

map({ "n" }, "<leader>af", function()
	require("edgy-group").open_group_index("right", 1)
end, { desc = "Right panel" })

map({ "t", "n" }, "<A-CR>", function()
	Util.NewTerm()
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
