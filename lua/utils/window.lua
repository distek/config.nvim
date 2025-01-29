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

Util.win_resize = function(dir)
	local n = Util.getNeighbors()

	-- I wish lua had a switch case
	if dir == "top" then
		-- middle split
		if n.top and n.bottom then
			vim.cmd("res +1")
			goto ret
		end

		-- top split with bottom neighbor
		if not n.top and n.bottom then
			vim.cmd(vim.fn.winnr("j") .. "res +1")
			goto ret
		end

		-- bottom split with top neighbor
		if n.top and not n.bottom then
			vim.cmd(vim.fn.winnr("k") .. "res -1")
			goto ret
		end

		-- only horizontal window, attempt tmux resize
		if not n.top and not n.bottom then
			vim.cmd("silent !tmux resize-pane -U 1")
		end

		goto ret
	end

	if dir == "bottom" then
		-- middle split
		if n.top and n.bottom then
			vim.cmd(vim.fn.winnr("k") .. "res +1")
			vim.cmd("res -1")
			goto ret
		end

		-- top split with bottom neighbor
		if not n.top and n.bottom then
			vim.cmd(vim.fn.winnr("k") .. "res +1")
			goto ret
		end

		-- bottom split with top neighbor
		if n.top and not n.bottom then
			vim.cmd(vim.fn.winnr("j") .. "res -1")
			goto ret
		end

		-- only horizontal window, attempt tmux resize
		if not n.top and not n.bottom then
			vim.cmd("silent !tmux resize-pane -D 1")
		end

		goto ret
	end

	if dir == "left" then
		if not n.left and n.right or n.left and n.right then
			vim.cmd("vert res -1")
			goto ret
		end

		if not n.right and n.left then
			vim.cmd("vert res +1")
			goto ret
		end

		if n.right then
			vim.cmd("vert res +1")
			goto ret
		end

		vim.cmd("silent !tmux resize-pane -L 1")

		goto ret
	end

	if dir == "right" then
		-- middle
		if n.left and n.right then
			vim.cmd("vert res +1")
			goto ret
		end

		-- left
		if not n.left and n.right then
			vim.cmd("vert res +1")
			goto ret
		end

		-- right
		if n.left then
			vim.cmd("vert res -1")
			goto ret
		end

		vim.cmd("silent !tmux resize-pane -R 1")
	end

	::ret::
end
