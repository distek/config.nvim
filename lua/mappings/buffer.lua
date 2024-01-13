local map = vim.keymap.set

-- focus buffers
map("n", "<Tab>", function()
	vim.cmd("BufferLineCycleNext")
end)
map("n", "<S-Tab>", function()
	vim.cmd("BufferLineCyclePrev")
end)

-- move buffers
map("n", "<A->>", function()
	vim.cmd("BufferLineMoveNext")
end)
map("n", "<A-<>", function()
	vim.cmd("BufferLineMovePrev")
end)

-- Close split
map("n", "<A-S-q>", function()
	local compCount, winCount = Util.compVsWinCount()

	if winCount - 1 == compCount then
		vim.notify("Cannot close last editor window")
		return
	end

	vim.cmd("wincmd c")
end)

-- Delete buffer
map("n", "<A-q>", function()
	require("bufdelete").bufwipeout(0, false)
end)
