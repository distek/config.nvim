Util.win_resize = function(dir)
	Edge.winResized = true
	-- local bt = vim.bo[vim.api.nvim_win_get_buf(0)].filetype
	-- if bt == "toggleterm" or bt == "neo-tree" or bt == "Outline" or bt == "help" or bt == "qf" then
	-- 	return
	-- end

	local n = Util.getNeighbors()

	-- I wish lua had a switch case
	if dir == "top" then
		Edge.winResizeV = true
		-- middle split
		if n.top and n.bottom then
			vim.cmd("res +1")
			return
		end

		-- top split with bottom neighbor
		if not n.top and n.bottom then
			vim.cmd(vim.fn.winnr("j") .. "res +1")
			return
		end

		-- bottom split with top neighbor
		if n.top and not n.bottom then
			vim.cmd(vim.fn.winnr("k") .. "res -1")
			return
		end

		-- only horizontal window, attempt tmux resize
		if not n.top and not n.bottom then
			vim.cmd("silent !tmux resize-pane -U 1")
		end
	end

	if dir == "bottom" then
		Edge.winResizeV = true
		-- middle split
		if n.top and n.bottom then
			vim.cmd(vim.fn.winnr("k") .. "res +1")
			vim.cmd("res -1")
			return
		end

		-- top split with bottom neighbor
		if not n.top and n.bottom then
			vim.cmd(vim.fn.winnr("k") .. "res +1")
			return
		end

		-- bottom split with top neighbor
		if n.top and not n.bottom then
			vim.cmd(vim.fn.winnr("j") .. "res -1")
			return
		end

		-- only horizontal window, attempt tmux resize
		if not n.top and not n.bottom then
			vim.cmd("silent !tmux resize-pane -D 1")
		end
	end

	if dir == "left" then
		Edge.winResizeH = true
		if not n.left and n.right or n.left and n.right then
			vim.cmd("vert res -1")
			return
		end

		if not n.right and n.left then
			vim.cmd("vert res +1")
			return
		end

		if n.right then
			vim.cmd("vert res +1")
			return
		end

		vim.cmd("silent !tmux resize-pane -L 1")
	end

	if dir == "right" then
		Edge.winResizeH = true
		-- middle
		if n.left and n.right then
			vim.cmd("vert res +1")
			return
		end

		-- left
		if not n.left and n.right then
			vim.cmd("vert res +1")
			return
		end

		-- right
		if n.left then
			vim.cmd("vert res -1")
			return
		end

		vim.cmd("silent !tmux resize-pane -R 1")
	end
end
