local map = vim.keymap.set

-- focus buffers
map("n", "<Tab>", "<cmd>bn<cr>")
map("n", "<S-Tab>", "<cmd>bp<cr>")

-- -- move buffers
-- map("n", "<A->>", function()
-- 	vim.cmd("BufferMoveNext")
-- end)
-- map("n", "<A-<>", function()
-- 	vim.cmd("BufferMovePrevious")
-- end)

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
map("n", "<A-q>", "<cmd>bn|bd #<cr>")
