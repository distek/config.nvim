local function baseCwd()
	local cwd = vim.loop.cwd()

	local split = string.split(cwd, "/")

	return split[#split]
end

Util.win_focus = function(dir)
	local function getStuff(d)
		if d == "left" then
			return "h", "left", "left"
		elseif d == "down" then
			return "j", "bottom", "down"
		elseif d == "up" then
			return "k", "top", "up"
		else --right
			return "l", "right", "right"
		end
	end

	local vimLetter, tmuxWord, word = getStuff(dir)
	if vim.bo[0].filetype == "toggleterm" then
		vim.cmd(
			"silent !$HOME/.local/bin/tmux-tools "
				.. "-S $HOME/.cache/tmux-tools/nested/"
				.. baseCwd()
				.. "/socket focus-pane "
				.. tmuxWord
		)
		if vim.v.shell_error == 0 then
			return
		end
	end

	if vim.fn.winnr() == vim.fn.winnr(vimLetter) then
		-- Try tmux-nested first
		if vim.bo[0].filetype == "toggleterm" then
			vim.cmd(
				"silent !$HOME/.local/bin/tmux-tools "
					.. "-S $HOME/.cache/tmux-tools/nested/"
					.. baseCwd()
					.. "/socket focus-pane "
					.. tmuxWord
			)
			-- vim.print(suc)
			-- vim.print(exitcode)
			-- vim.print(code)
			-- if suc then
			-- 	return
			-- end
		end
		if os.getenv("TMUX") ~= nil then
			os.execute("~/.local/bin/tmux-tools focus-pane " .. tmuxWord)
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
