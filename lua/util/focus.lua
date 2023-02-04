Util.win_focus_bottom = function()
	local currentWin = vim.fn.winnr()

	if currentWin == vim.fn.winnr("j") then
		vim.cmd("silent !tmux select-pane -D")
		return
	end

	vim.cmd("wincmd j")
end

Util.win_focus_top = function()
	local currentWin = vim.fn.winnr()

	if currentWin == vim.fn.winnr("k") then
		vim.cmd("silent !tmux select-pane -U")
		return
	end

	vim.cmd("wincmd k")
end

Util.win_focus_left = function()
	local currentWin = vim.fn.winnr()

	if currentWin == vim.fn.winnr("h") then
		vim.cmd("silent !tmux select-pane -L")
		return
	end

	vim.cmd("wincmd h")
end

Util.win_focus_right = function()
	local currentWin = vim.fn.winnr()

	if currentWin ~= vim.fn.winnr("l") then
		vim.cmd("wincmd l")
		return
	end

	vim.cmd("silent !tmux select-pane -R")
end
