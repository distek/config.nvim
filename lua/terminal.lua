T = require("nvim-terminal")

-- initial tab setup
TF.Term[vim.api.nvim_get_current_tabpage()] = T.NewTerminalInstance({
	pos = "botright",
	split = "sp",
	height = 15,
})

vim.api.nvim_create_autocmd({ "TabNewEntered" }, {
	pattern = "*",
	callback = function(ev)
		if TF.Term[vim.api.nvim_get_current_tabpage()] == nil then
			TF.Term[vim.api.nvim_get_current_tabpage()] = T.NewTerminalInstance({
				pos = "botright",
				split = "sp",
				height = 15,
			})
		end
	end,
})

vim.api.nvim_create_autocmd("WinResized", {
	pattern = "*",
	callback = function()
		if TF.Term ~= nil then
			TF.Term[vim.api.nvim_get_current_tabpage()].window:update_size()
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
