local map = vim.keymap.set

-- focus buffers
map("n", "<Tab>", function()
	Util.skipUnwantedBuffers("next")
end)
map("n", "<S-Tab>", function()
	Util.skipUnwantedBuffers("prev")
end)

-- move buffers
map("n", "<A->>", function()
	vim.cmd("BufferMoveNext")
end)
map("n", "<A-<>", function()
	vim.cmd("BufferMovePrevious")
end)

-- Delete buffer
map("n", "<A-S-q>", function()
	local compCount, winCount = Util.compVsWinCount()

	if winCount - 1 == compCount then
		vim.notify("Cannot close last editor window")
		return
	end

	vim.cmd("wincmd c")
end)
