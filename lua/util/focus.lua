Util.win_focus = function(dir)
	local function getStuff(d)
		if d == "left" then
			return "h", "L", "left"
		elseif d == "down" then
			return "j", "D", "down"
		elseif d == "up" then
			return "k", "U", "up"
		else --right
			return "l", "R", "right"
		end
	end

	local currentWin = vim.fn.winnr()
	local vimLetter, tmuxLetter, weztermWord = getStuff(dir)

	if currentWin == vim.fn.winnr(vimLetter) then
		if os.getenv("TMUX") ~= nil then
			print("here")
			vim.cmd("silent !tmux select-pane -" .. tmuxLetter)
			return
		end

		if os.getenv("TERM_PROGRAM") == "WezTerm" then
			print("here2")
			vim.cmd("silent !wezterm cli activate-pane-direction " .. weztermWord)
			return
		end
	end
end
