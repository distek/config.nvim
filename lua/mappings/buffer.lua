local map = vim.keymap.set

-- focus buffers
map("n", "<Tab>", function()
	vim.cmd("BufferLineCycleNext")
end)
map("n", "<S-Tab>", function()
	vim.cmd("BufferLineCyclePrev")
end)

map({ "t", "n" }, "<A-[>", function()
	local cb = vim.api.nvim_get_current_buf()
	if
		vim.bo[cb].filetype == "toggleterm"
		or vim.bo[cb].filetype == "termlist"
	then
		Util.TermPrev()
	else
		vim.cmd("BufferLineCyclePrev")
	end
end)

map({ "t", "n" }, "<A-{>", function()
	local cb = vim.api.nvim_get_current_buf()
	if
		vim.bo[cb].filetype == "toggleterm"
		or vim.bo[cb].filetype == "termlist"
	then
		Util.TermMovePrev()
	else
		vim.cmd("BufferLineMovePrev")
	end
end)

map({ "t", "n" }, "<A-]>", function()
	local cb = vim.api.nvim_get_current_buf()
	if
		vim.bo[cb].filetype == "toggleterm"
		or vim.bo[cb].filetype == "termlist"
	then
		Util.TermNext()
	else
		vim.cmd("BufferLineCycleNext")
	end
end)

map({ "t", "n" }, "<A-}>", function()
	local cb = vim.api.nvim_get_current_buf()
	if
		vim.bo[cb].filetype == "toggleterm"
		or vim.bo[cb].filetype == "termlist"
	then
		Util.TermMoveNext()
	else
		vim.cmd("BufferLineMoveNext")
	end
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
