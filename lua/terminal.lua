T = require("nvim-terminal")

TF.Height = 15

-- initial tab setup
TF.Term[vim.api.nvim_get_current_tabpage()] = T.NewTerminalInstance({
	pos = "botright",
	split = "sp",
	height = TF.Height,
})

vim.api.nvim_create_autocmd({ "TabNewEntered" }, {
	pattern = "*",
	callback = function(ev)
		if TF.Term[vim.api.nvim_get_current_tabpage()] == nil then
			TF.Term[vim.api.nvim_get_current_tabpage()] = T.NewTerminalInstance({
				pos = "botright",
				split = "sp",
				height = TF.Height,
			})
		end
	end,
})

vim.api.nvim_create_autocmd("WinResized", {
	pattern = "*",
	callback = function()
		if TF.Term ~= nil then
			TF.Term[vim.api.nvim_get_current_tabpage()].window.height = TF.Height
			TF.Term[vim.api.nvim_get_current_tabpage()].window:update_size()
		end
	end,
})

vim.api.nvim_create_autocmd("TermClose", {
	callback = function()
		local tp = vim.api.nvim_get_current_tabpage()
		local lastTerm = TF.Term[tp].last_term
		if #TF.Term[tp].bufs > 1 then
			TF.NextTerm()
			TF.Term[vim.api.nvim_get_current_tabpage()]:delete(lastTerm)
			TF.UpdateWinbar()
		else
			TF.Term[tp]:delete(lastTerm)
		end
	end,
})

function TermNew()
	local nvt = Util.is_neotree_open()

	if nvt then
		vim.cmd("Neotree close")
	end

	TF.NewTerm()

	if nvt then
		vim.cmd("Neotree show")
	end
end

function TermOpen()
	local nvt = Util.is_neotree_open()

	if nvt then
		vim.cmd("Neotree close")
	end

	TF.Open()

	if nvt then
		vim.cmd("Neotree show")
	end
end

function TermToggle()
	local nvt = Util.is_neotree_open()

	if nvt then
		vim.cmd("Neotree close")
	end

	local winid = TF.Toggle()

	if vim.api.nvim_win_is_valid(winid) then
		vim.api.nvim_win_set_hl_ns(winid, PanelNS)
	end

	if nvt then
		vim.cmd("Neotree show")
	end
end

function TermPick()
	local nvt = Util.is_neotree_open()

	TF.PickTerm(function()
		if nvt then
			vim.cmd("Neotree close")
		end
	end, function()
		if nvt then
			vim.cmd("Neotree show")
		end
	end)
end
