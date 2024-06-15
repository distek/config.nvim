Util.win_focus = function(dir)
	local function getStuff(d)
		if d == "left" then
			return "h", "L", "left"
		elseif d == "down" then
			return "j", "D", "bottom"
		elseif d == "up" then
			return "k", "U", "top"
		else --right
			return "l", "R", "right"
		end
	end

	local vimLetter, tmuxLetter, word = getStuff(dir)

	if vim.fn.winnr() == vim.fn.winnr(vimLetter) then
		local current = vim.api.nvim_get_current_win()

		vim.cmd("wincmd " .. vimLetter)
		if os.getenv("TMUX") ~= nil then
			vim.cmd("silent !tmux-tools focus-pane " .. word)

			return
		end

		-- wezterm if I switch from tmux again for some reason
		-- if os.getenv("TERM_PROGRAM") == "WezTerm" then
		-- 	vim.cmd("silent !wezterm cli activate-pane-direction " .. word)
		-- 	return
		-- end
	else
		vim.cmd("wincmd " .. vimLetter)
	end
end
