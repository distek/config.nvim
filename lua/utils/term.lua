local edgy = require("edgy")
---@class Term
---@field Buf number
---@field ID number
---@field Name string

---@type Term[]
Util.Terms = {}

Util.CurrentTerm = 0
Util.TermWin = 0

local termListBufid = nil

Util.TermSessionID = os.time(os.date("!*t"))

vim.cmd("silent exec '!" .. vim.fn.expand("~") .. "/.config/tmux/minimal.sh " .. Util.TermSessionID .. "'")

local function newTerm(id)
	if Util.TermWin > 0 and vim.api.nvim_win_is_valid(Util.TermWin) then
		vim.api.nvim_set_current_win(Util.TermWin)
		vim.cmd("term " .. vim.fn.expand("~") .. "/.config/tmux/minimal-neww.sh " .. Util.TermSessionID)
	else
		vim.cmd("vsplit +term\\ " .. vim.fn.expand("~") .. "/.config/tmux/minimal-neww.sh\\ " .. Util.TermSessionID)
	end

	local buf = vim.api.nvim_get_current_buf()

	vim.bo[buf].buflisted = false
	vim.bo[buf].filetype = "toggleterm"

	-- vim.o.mousemoveevent = true

	table.insert(Util.Terms, { Buf = buf, ID = id, Name = "" })

	Util.TermWin = vim.api.nvim_get_current_win()
end

local function cleanUpTerms()
	local new = {}
	for _, v in ipairs(Util.Terms) do
		if vim.api.nvim_buf_is_valid(v.Buf) then
			table.insert(new, v)
		end
	end

	Util.Terms = new
end

local function idOrName(i, t)
	if t.Name ~= nil and t.Name ~= "" then
		return i .. ": " .. t.Name
	end

	return i
end

local function getBufNames()
	local ret = {}

	-- for i, v in ipairs(Util.Terms) do
	-- 	if v.ID == Util.CurrentTerm then
	-- 		ret[i] = " > " .. getBufCommand(v.Buf)
	-- 	else
	-- 		ret[i] = "   " .. getBufCommand(v.Buf)
	-- 	end
	-- end

	for i, v in ipairs(Util.Terms) do
		if v.ID == Util.CurrentTerm then
			ret[i] = " > " .. idOrName(i, v)
		else
			ret[i] = "   " .. idOrName(i, v)
		end
	end

	return ret
end

---@return Term | nil
local function getNextPrev(nextPrev)
	if nextPrev == "next" then
		for i, v in ipairs(Util.Terms) do
			if v.ID == Util.CurrentTerm then
				if #Util.Terms == 0 then
					return nil
				end

				local next = Util.Terms[i + 1]

				if next == nil then
					next = Util.Terms[1]
				end

				return next
			end
		end
	elseif nextPrev == "prev" then
		for i, v in ipairs(Util.Terms) do
			if v.ID == Util.CurrentTerm then
				if #Util.Terms == 0 then
					return nil
				end

				local prev
				if i - 1 == 0 then
					prev = Util.Terms[#Util.Terms]
				else
					prev = Util.Terms[i - 1]
				end

				return prev
			end
		end
	end
end

local function updateBufs()
	if termListBufid == nil or not vim.api.nvim_buf_is_valid(termListBufid) then
		Util.OpenTermList(Util.TermWin)
	end

	cleanUpTerms()

	local bufs = getBufNames()

	vim.api.nvim_buf_set_option(termListBufid, "readonly", false)
	vim.api.nvim_buf_set_option(termListBufid, "modifiable", true)
	vim.api.nvim_buf_set_lines(termListBufid, 0, -1, false, {})
	vim.api.nvim_buf_set_lines(termListBufid, 0, #Util.Terms, false, bufs)
	vim.api.nvim_buf_set_option(termListBufid, "readonly", true)
	vim.api.nvim_buf_set_option(termListBufid, "modifiable", false)
end

function Util.TermMoveNext()
	if #Util.Terms <= 1 then
		return
	end

	if Util.GetCurrentTermIdx() == #Util.Terms then
		return
	end

	local temp = {}
	local oldPos = 0
	local current
	for i, v in ipairs(Util.Terms) do
		if v.ID == Util.CurrentTerm then
			oldPos = i
			current = v
			goto continue
		end
		table.insert(temp, v)
		::continue::
	end

	table.insert(temp, oldPos + 1, current)

	Util.Terms = temp

	updateBufs()
end

function Util.TermMovePrev()
	if #Util.Terms <= 1 then
		return
	end

	if Util.GetCurrentTermIdx() == 1 then
		return
	end

	local temp = {}
	local oldPos = 0
	local current
	for i, v in ipairs(Util.Terms) do
		if v.ID == Util.CurrentTerm then
			oldPos = i
			current = v
			goto continue
		end
		table.insert(temp, v)
		::continue::
	end

	table.insert(temp, oldPos - 1, current)

	Util.Terms = temp

	updateBufs()
end

function Util.TermSet(idx)
	if Util.Terms[idx] == nil then
		return
	end

	vim.api.nvim_win_set_buf(Util.TermWin, Util.Terms[idx].Buf)

	Util.CurrentTerm = Util.Terms[idx].ID

	updateBufs()
end

function Util.TermNext()
	if Util.CurrentTerm == 0 then
		newTerm(1)

		Util.CurrentTerm = 1

		return
	end

	local next = getNextPrev("next")
	if next == nil then
		vim.notify("couldn't find the next terminal")
		return
	end

	vim.api.nvim_win_set_buf(Util.TermWin, next.Buf)

	Util.CurrentTerm = next.ID
end

function Util.TermPrev()
	if Util.CurrentTerm == 0 then
		newTerm(1)

		Util.CurrentTerm = 1

		return
	end

	local prev = getNextPrev("prev")
	if prev == nil then
		vim.notify("couldn't find the previous terminal")
		return
	end

	vim.api.nvim_win_set_buf(Util.TermWin, prev.Buf)

	Util.CurrentTerm = prev.ID
end

function Util.OpenTerm()
	if Util.TermWin ~= 0 and vim.api.nvim_win_is_valid(Util.TermWin) then
		vim.api.nvim_set_current_win(Util.TermWin)

		return
	elseif Util.TermWin ~= 0 and not vim.api.nvim_win_is_valid(Util.TermWin) then
		vim.cmd("vsplit")
		Util.TermWin = vim.api.nvim_get_current_win()
		vim.api.nvim_win_set_buf(Util.TermWin, Util.Terms[Util.CurrentTerm].Buf)
		Util.OpenTermList(Util.TermWin)

		return
	end

	newTerm(1)
	Util.CurrentTerm = 1

	Util.OpenTermList(Util.TermWin)
end

function Util.NewTerm()
	if vim.bo[vim.api.nvim_win_get_buf(0)].filetype == "termlist" then
		vim.api.nvim_set_current_win(Util.TermWin)
	end

	newTerm(Util.CurrentTerm + 1)
	Util.CurrentTerm = Util.CurrentTerm + 1
end

local function getBufCommand(bufnr)
	local job_pid = vim.api.nvim_buf_get_var(bufnr, "terminal_job_pid")
	local cmd = vim.fn.system({ "ps", "-p", tostring(job_pid), "-o", "args=" })

	vim.print(vim.fn.system({ "ps", "-p", tostring(job_pid) }))

	return vim.fn.trim(cmd)
end

function Util.OpenTermList(winid)
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

	vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
	vim.api.nvim_buf_set_option(bufnr, "readonly", false)

	termListBufid = bufnr

	vim.cmd("20vsplit +buffer\\ " .. bufnr)

	vim.opt_local.filetype = "termlist"
	vim.bo[bufnr].buflisted = false
	vim.bo[bufnr].buftype = "nofile"

	local bufs = getBufNames()

	vim.api.nvim_buf_set_name(bufnr, "Termlist")
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, bufs)
	vim.api.nvim_buf_set_option(bufnr, "modified", false)

	vim.api.nvim_buf_set_keymap(bufnr, "n", "<cr>", "<cmd>lua Util.UpdateTerm()<cr>", { noremap = true })

	vim.api.nvim_buf_set_keymap(bufnr, "n", "n", "<cmd>lua Util.RenameTerm()<cr>", { noremap = true })

	-- termListWinid = vim.api.nvim_get_current_win()

	vim.opt_local.number = false
	vim.opt_local.relativenumber = false
	vim.opt_local.wrap = false
	vim.opt_local.list = false
	vim.opt_local.signcolumn = "no"
	vim.opt_local.statuscolumn = ""

	vim.cmd("stopinsert")
	-- vim.cmd("wincmd p")

	vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
	vim.api.nvim_buf_set_option(bufnr, "readonly", true)
	vim.api.nvim_set_current_win(Util.TermWin)
	-- vim.bo[lastTerm].modfiable = false
end

function Util.UpdateTerm()
	if Util.TermWin == nil or vim.api.nvim_win_is_valid(Util.TermWin) then
		Util.OpenTerm()
	end

	local row = vim.api.nvim__buf_stats(termListBufid).current_lnum

	vim.api.nvim_win_set_buf(Util.TermWin, Util.Terms[row].Buf)

	Util.CurrentTerm = Util.Terms[row].ID

	updateBufs()
end

function Util.GetCurrentTermIdx()
	for i, v in ipairs(Util.Terms) do
		if v.ID == Util.CurrentTerm then
			return i
		end
	end

	return nil
end

function Util.RenameTerm()
	local id = vim.api.nvim__buf_stats(termListBufid).current_lnum

	if Util.Terms[id] == nil then
		return
	end

	vim.ui.input({ prompt = "New Name:", default = Util.Terms[id].Name }, function(input)
		if input == nil then
			return
		end

		Util.Terms[id].Name = vim.fn.trim(input)
	end)

	updateBufs()
end

vim.api.nvim_create_augroup("PanelToggleTerm", { clear = true })

vim.api.nvim_create_autocmd({ "TermEnter", "WinEnter", "BufEnter" }, {
	group = "PanelToggleTerm",
	callback = function()
		Util.defer(function()
			local buf = vim.api.nvim_get_current_buf()
			if vim.bo[buf].filetype == "toggleterm" then
				vim.cmd("startinsert")
				updateBufs()
			end
			if vim.bo[buf].filetype == "termlist" then
				local cur = Util.GetCurrentTermIdx()
				if cur == nil then
					return
				end
				vim.api.nvim_win_set_cursor(0, { cur, 0 })
			end
		end, 10)
	end,
})

vim.api.nvim_create_autocmd({ "TermClose" }, {
	callback = function(e)
		if #Util.Terms == 1 then
			Util.Terms = {}
			Util.TermWin = 0
			edgy.close("bottom")
			return
		end

		local t = getNextPrev("next")

		if t == nil then
			Util.Terms = {}
			edgy.close("bottom")
			return
		end

		Util.CurrentTerm = t.ID

		vim.cmd("vsplit")

		Util.TermWin = vim.api.nvim_get_current_win()

		local cur = Util.GetCurrentTermIdx()

		if cur == nil then
			return
		end

		vim.api.nvim_win_set_buf(Util.TermWin, Util.Terms[cur].Buf)

		vim.api.nvim_buf_delete(e.buf, {})

		cleanUpTerms()

		updateBufs()
	end,
})

vim.api.nvim_create_autocmd({ "VimLeave" }, {
	group = "PanelToggleTerm",
	callback = function()
		vim.api.nvim_exec2("!tmux -S " .. "/tmp/tmux-vim_" .. Util.TermSessionID .. " kill-server", {})
		vim.api.nvim_exec2("!rm -f " .. "/tmp/tmux-vim_" .. Util.TermSessionID, {})
	end,
})
