T = require("nvim-terminal")

TF = TF

TF.Height = 15

local termListWinid = nil
local termListBufid = nil

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

			if termListWinid ~= nil then
				if vim.api.nvim_win_is_valid(termListWinid) then
					vim.api.nvim_win_set_width(termListWinid, 20)
				end
			end
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
			UpdateTermList()
		else
			TF.Term[tp]:delete(lastTerm)
			vim.api.nvim_win_close(termListWinid, true)
			vim.api.nvim_buf_delete(termListBufid, { force = true, unload = true })
		end
	end,
})

local function getBufNames()
	local tp = vim.api.nvim_get_current_tabpage()

	local ret = {}

	for i, v in ipairs(TF.Term[tp].bufs) do
		if v == TF.Term[tp].bufs[TF.Term[tp].last_term] then
			ret[i] = " > " .. vim.api.nvim_buf_get_var(v, "name")
		else
			ret[i] = "   " .. vim.api.nvim_buf_get_var(v, "name")
		end
	end

	return ret
end

local function updateBufs(bufnr)
	local bufs = getBufNames()

	vim.api.nvim_buf_set_option(bufnr, "readonly", false)
	vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
	vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, {})
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, bufs)
	vim.api.nvim_buf_set_option(bufnr, "readonly", true)
	vim.api.nvim_buf_set_option(bufnr, "modifiable", false)

	if termListWinid ~= nil then
		if vim.api.nvim_win_is_valid(termListWinid) then
			vim.api.nvim_win_set_width(termListWinid, 20)
			vim.api.nvim_win_set_hl_ns(termListWinid, TerminalListNS)
		end
	end
end

local function openTermList(winid)
	if termListBufid ~= nil and vim.api.nvim_buf_is_valid(termListBufid) then
		vim.api.nvim_buf_delete(termListBufid, { force = true, unload = false })
	end
	if winid == nil then
		return
	end

	if not vim.api.nvim_win_is_valid(winid) then
		return
	end

	local bufnr = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_option(bufnr, "modifiable", true)

	updateBufs(bufnr)
	vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
	vim.api.nvim_buf_set_option(bufnr, "readonly", false)

	termListBufid = bufnr

	vim.cmd("20vsplit +buffer\\ " .. bufnr)

	vim.opt_local.filetype = "termlist"
	vim.bo[bufnr].bufhidden = true
	vim.bo[bufnr].buftype = "nofile"

	local bufs = getBufNames()

	vim.api.nvim_buf_set_name(bufnr, "termlist")
	vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, {})
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, bufs)
	vim.api.nvim_buf_set_option(bufnr, "modified", false)

	vim.api.nvim_buf_set_keymap(bufnr, "n", "<cr>", "<cmd>lua OpenTermUnderCursor()<cr>", { noremap = true })
	vim.api.nvim_buf_set_keymap(bufnr, "n", "r", "<cmd>lua TF.RenameTerm()<cr>", { noremap = true })
	vim.api.nvim_buf_set_keymap(bufnr, "n", "n", "<cmd>lua TermNew()<cr>", { noremap = true })
	vim.api.nvim_buf_set_keymap(bufnr, "n", "dd", "<cmd>lua TermDelete()<cr>", { noremap = true })

	termListWinid = vim.api.nvim_get_current_win()

	vim.opt_local.number = false
	vim.opt_local.relativenumber = false
	vim.opt_local.wrap = false
	vim.opt_local.list = false
	vim.opt_local.signcolumn = "no"
	vim.opt_local.statuscolumn = ""

	vim.api.nvim_win_set_option(termListWinid, "winbar", "Terminals")
	vim.api.nvim_win_set_hl_ns(termListWinid, TerminalListNS)

	vim.cmd("stopinsert")
	vim.cmd("wincmd p")

	vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
	vim.api.nvim_buf_set_option(bufnr, "readonly", true)
end

function OpenTermUnderCursor()
	local row, _ = unpack(vim.api.nvim_win_get_cursor(0))

	TF.Term[vim.api.nvim_get_current_tabpage()]:open(row)

	UpdateTermList()

	vim.api.nvim_win_set_cursor(0, { row, 0 })
end

function UpdateTermList()
	updateBufs(termListBufid)

	TF.UpdateWinbar()
end

function TermDelete()
	if TF.DeleteCurrentTerm() then
		vim.api.nvim_win_close(termListWinid, true)
		vim.api.nvim_buf_delete(termListBufid, { force = true, unload = true })
	end
end

function TermNew()
	local nvt = Util.is_neotree_open()
	if not TF.Term[vim.api.nvim_get_current_tabpage()].window:is_valid() then
		if nvt then
			vim.cmd("Neotree close")
		end
	end

	TF.NewTerm()

	updateBufs(termListBufid)
	if not TF.Term[vim.api.nvim_get_current_tabpage()].window:is_valid() then
		if nvt then
			vim.cmd("Neotree show")
		end
	end
end

function TermOpen()
	local nvt = Util.is_neotree_open()

	if nvt then
		vim.cmd("Neotree close")
	end

	TF.Open()

	local winid = TF.Term[vim.api.nvim_get_current_tabpage()].window.winid

	openTermList(winid)

	if vim.api.nvim_win_is_valid(winid) then
		vim.api.nvim_win_set_hl_ns(winid, TerminalNS)
	end

	if nvt then
		vim.cmd("Neotree show")
	end
end

function TermToggle()
	local nvt = Util.is_neotree_open()

	if nvt then
		vim.cmd("Neotree close")
	end

	if termListWinid ~= nil and vim.api.nvim_win_is_valid(termListWinid) then
		vim.api.nvim_win_close(termListWinid, true)
		termListWinid = nil
	end

	local winid = TF.Toggle()

	if vim.api.nvim_win_is_valid(winid) then
		vim.api.nvim_win_set_hl_ns(winid, TerminalNS)
	end

	openTermList(winid)

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
	updateBufs(termListBufid)
end
