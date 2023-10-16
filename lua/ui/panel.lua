---@return bufid
local function openToggleTerm()
	vim.cmd("vsplit +term\\ tmux-nest")

	local buf = vim.api.nvim_get_current_buf()

	vim.bo[buf].buflisted = false
	vim.bo[buf].filetype = "toggleterm"

	vim.api.nvim_buf_set_name(buf, "terminal")

	vim.api.nvim_create_augroup("EdgyToggleTerm", { clear = true })
	vim.api.nvim_create_autocmd({ "TermEnter", "WinEnter", "BufEnter" }, {
		group = "EdgyToggleTerm",
		callback = function()
			Util.defer(function()
				buf = vim.api.nvim_get_current_buf()
				if vim.bo[buf].filetype == "toggleterm" then
					vim.cmd("startinsert")
				end
			end, 10)
		end,
	})

	return buf
end

---@alias bufid number
---@alias winid number

---@class panel
---@field size number
---@field order string[]
---@field views table<string, view>

---@class view
---@field ft string
---@field open fun(): bufid | nil
---@field close function|boolean|nil if the command relies on a window id, use this function to close it upon navigating away
---@field wo table<string, any>

---@class edge
---@field panelCurrent string|nil
---@field winResized boolean
---@field winResizeH boolean
---@field winResizeV boolean
---@field bufs table<string,number|nil>
---@field panel panel
local M = {
	panelCurrent = nil,

	winResized = false,
	winResizeH = false,
	winResizeV = false,

	bufs = {},

	win = nil,

	winOpts = {},

	---@class config
	---@field panel panel
	config = {
		panel = {
			size = 15,
			order = {
				"Terminal",
				"Problems",
				"Quickfix",
				"Help",
			},
			views = {
				["Terminal"] = {
					ft = "toggleterm",
					open = openToggleTerm,
					close = false,
					wo = {
						winhighlight = "Normal:EdgyTermNormal",
						number = false,
						relativenumber = false,
						wrap = false,
						list = false,
						signcolumn = "no",
						statuscolumn = "",
					},
				},
				["Problems"] = {
					ft = "Trouble",
					open = function()
						require("trouble").open({ win = Panel.win })

						local bufid = vim.api.nvim_get_current_buf()

						vim.bo[bufid].buflisted = false

						return bufid
					end,
					close = function()
						Panel.winClosing = true
						require("trouble").close()
						Panel.winClosing = false
					end,
					wo = {
						winhighlight = "Normal:EdgyTermNormal",
					},
				},
				["Quickfix"] = {
					ft = "qf",
					open = function()
						vim.cmd(":copen")

						return vim.api.nvim_get_current_buf()
					end,
					close = false,
					wo = {
						winhighlight = "Normal:EdgyTermNormal",
					},
				},
				["Help"] = {
					ft = "help",
					open = function()
						-- for _, v in ipairs(vim.api.nvim_list_bufs()) do
						-- 	if vim.bo[v].filetype == "help" then
						-- 		return v
						-- 	end
						-- end

						vim.api.nvim_create_autocmd({ "FileType" }, {
							pattern = "help",
							callback = function(ev)
								vim.print(vim.bo[ev.buf].name)
							end,
						})
					end,
					close = function()
						-- for _, v in ipairs(vim.api.nvim_list_bufs()) do
						-- 	if vim.bo[v].filetype == "help" then
						-- 		vim.api.nvim_buf_delete(v, { force = true })
						-- 	end
						-- end
					end,
					wo = {
						number = false,
						relativenumber = false,
						list = false,
						signcolumn = "no",
						statuscolumn = "",
					},
				},
			},
		},
	},
}

local debounceNewClosed = false
local debounceResize = false

local function setDebounceNewClosed()
	debounceNewClosed = true

	Util.defer(function()
		debounceNewClosed = false
	end, 100)
end

local function setDebounceResize()
	debounceResize = true

	Util.defer(function()
		debounceResize = false
	end, 100)
end

local function saveDefaultWinOpts(winid)
	for _, v in pairs(M.config.panel.views) do
		for k, _ in pairs(v.wo) do
			M.winOpts[k] = vim.api.nvim_get_option_value(
				k,
				{ scope = "local", win = winid }
			)
		end
	end
end

local function restoreWinOpts(winid)
	for k, v in pairs(M.winOpts) do
		vim.wo[winid][k] = v
	end
end

local function setWinOpts(winid, opts)
	for k, v in pairs(opts) do
		vim.wo[winid][k] = v
	end
end

---@param size number
---@return winid
local function createWindow(size)
	vim.o.lazyredraw = true
	local panelWin = 0

	local group = vim.api.nvim_create_augroup("PanelWin", { clear = true })

	vim.cmd("noautocmd horizontal botright split")
	panelWin = vim.api.nvim_get_current_win()

	saveDefaultWinOpts(panelWin)

	vim.api.nvim_win_set_height(panelWin, size or 15)

	vim.api.nvim_create_autocmd({ "WinResized" }, {
		group = group,
		callback = function()
			vim.o.eventignore = "WinResized"
			if not debounceResize and not debounceNewClosed then
				if M.winResized then
					M.config.panel.size = vim.api.nvim_win_get_height(M.win)

					M.winResized = false
					setDebounceResize()
				end
			end
			vim.o.eventignore = ""
		end,
	})

	vim.api.nvim_create_autocmd({ "WinResized", "WinNew", "WinClosed" }, {
		group = group,
		callback = function()
			if not M.winResized then
				if M.isOpen() then
					M.resize()
				end
			end
		end,
	})

	vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
		group = group,
		callback = function(ev)
			Util.defer(function()
				if vim.api.nvim_get_current_win() == M.win then
					for _, v in pairs(M.bufs) do
						if ev.buf == v then
							return
						end
					end

					local buf = vim.api.nvim_win_get_buf(M.win)

					vim.api.nvim_win_set_buf(M.win, M.bufs[M.panelCurrent])

					-- get all non edgy or floating windows
					local mainWins = require("edgy.editor").list_wins().main

					-- set main to _something_
					local main = 0

					for _, v in pairs(mainWins) do
						main = v
						break
					end

					-- No main window, scary things are afoot
					if main == 0 then
						return
					end

					-- Finally, check our global winstack and if one of them is
					-- in mainWins, use it
					local revWins = Util.reverseTable(WinStack)

					if revWins == nil then
						vim.api.nvim_win_set_buf(main, buf)
						return
					end

					for _, v in ipairs(revWins) do
						if mainWins[v] ~= nil then
							vim.api.nvim_win_set_buf(main, buf)

							return
						end
					end
				end
			end, 10)
		end,
	})

	setDebounceNewClosed()

	vim.o.lazyredraw = false
	return panelWin
end

---@param panelName string
---@param view view
---@return bufid|nil
local function handleOpen(panelName, view)
	local bufid = view.open()

	if vim.api.nvim_get_current_win() ~= M.win then
		vim.api.nvim_win_hide(vim.api.nvim_get_current_win())
	end

	if bufid == nil then
		M.bufs[panelName] = nil
		return nil
	end

	M.bufs[panelName] = bufid

	vim.bo[bufid].bufhidden = "hide"
	vim.bo[bufid].buflisted = false

	return bufid
end

local function setupAutocmds()
	for k, v in pairs(M.config.panel.views) do
		local group = vim.api.nvim_create_augroup(
			"PanelAuGroup_" .. v.ft,
			{ clear = true }
		)

		vim.api.nvim_create_autocmd({ "FileType" }, {
			group = group,
			pattern = v.ft,
			callback = function(ev)
				Util.defer(function()
					local temp = vim.o.eventignore
					vim.o.eventignore = "FileType"

					M.panelCurrent = k
					M.bufs[M.panelCurrent] = ev.buf

					M.setView(k)

					for _, win in ipairs(vim.api.nvim_list_wins()) do
						if vim.api.nvim_win_get_buf(win) == ev.buf then
							if v ~= M.win then
								vim.api.nvim_win_close(win, true)
							end
						end
					end

					M.open(true)

					vim.o.eventignore = temp or ""
				end, 1)
			end,
		})
	end

	-- Create a new win if whatever command we had running closed it
	vim.api.nvim_create_autocmd({ "WinClosed" }, {
		callback = function(ev)
			vim.o.eventignore = "WinClosed"
			if not debounceNewClosed then
				Util.defer(function()
					if tonumber(ev.match) == M.win then
						if M.winClosing then
							return
						end

						M.open(true)
						vim.o.eventignore = ""
					end
				end, 10)
			end
		end,
	})
end

local function initPanel()
	-- set the panelCurrent to the first entry
	M.panelCurrent = M.config.panel.order[1]
end

---@return boolean
local function hasBufs()
	if M.bufs == nil then
		return false
	end

	for k, v in pairs(M.bufs) do
		if vim.api.nvim_buf_is_valid(v) then
			return true
		end

		M.bufs[k] = nil
	end

	return false
end

M.resize = function()
	vim.o.eventignore = "WinResized"
	vim.api.nvim_win_set_height(M.win, M.config.panel.size)
	vim.o.eventignore = ""
end

---@return boolean
M.isOpen = function()
	if M.win == nil then
		return false
	end

	if vim.api.nvim_win_is_valid(M.win) then
		return true
	end

	M.win = nil
	return false
end

M.close = function()
	if vim.api.nvim_win_is_valid(M.win) then
		M.winClosing = true
		vim.api.nvim_win_close(M.win, true)
		M.winClosing = false
	end

	M.win = nil
end

local function cleanBufs()
	for _, v in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_get_name(v) == "" then
			if #vim.fn.getbufinfo(v)[1].windows == 0 then
				vim.bo[v].bufhidden = "hide"
				vim.bo[v].buflisted = false
			end
		end
	end
end

local renderWinbar = function(winid)
	local wb = ""

	for i, v in ipairs(M.config.panel.order) do
		if v == M.panelCurrent then
			wb = wb .. "%#TabLineSel#▎"
			wb = wb .. "%#TabLineSel# "
		else
			wb = wb .. "%#TabLine#▎%#TabLine# "
		end

		wb = wb .. "%" .. i .. "@v:lua.Panel.handleClickTab@ "

		wb = wb .. v .. " %X"

		wb = wb .. " %#TabLineFill# "

		wb = wb .. "%#Normal#"
	end

	wb = wb .. "%#TabLineFill#"

	vim.wo[winid].winbar = wb

	vim.cmd("redraw")
end

---@param name string
M.setView = function(name)
	vim.o.lazyredraw = true

	if M.bufs[name] == nil or not vim.api.nvim_buf_is_valid(M.bufs[name]) then
		handleOpen(name, M.config.panel.views[name])
	end

	if M.win == nil or not vim.api.nvim_win_is_valid(M.win) then
		M.win = createWindow(M.config.panel.size)
	end

	debounceResize = true
	debounceNewClosed = true
	vim.api.nvim_win_set_height(M.win, M.config.panel.size)
	debounceResize = false
	debounceNewClosed = false

	restoreWinOpts(M.win)

	if M.panelCurrent ~= name then
		M.panelCurrent = name
	end

	vim.api.nvim_win_set_buf(M.win, M.bufs[name])

	renderWinbar(M.win)

	setWinOpts(M.win, M.config.panel.views[name].wo)

	cleanBufs()

	vim.o.lazyredraw = false
end

M.handleClickTab = function(minwid, clicks, btn, mods)
	M.panelCurrent = M.config.panel.order[minwid]

	M.setView(M.panelCurrent)
end

---@param focus boolean
M.open = function(focus)
	local curWin = 0
	if not focus then
		curWin = vim.api.nvim_get_current_win()
	end

	M.win = createWindow(M.config.panel.size)

	if
		M.bufs[M.panelCurrent] == nil
		or not vim.api.nvim_buf_is_valid(M.bufs[M.panelCurrent])
	then
		for _, v in pairs(M.config.panel.order) do
			if M.bufs[v] ~= nil and vim.api.nvim_buf_is_valid(M.bufs[v]) then
				M.panelCurrent = v
			end
		end
	end

	-- if not vim.api.nvim_buf_is_valid(M.bufs[M.panelCurrent]) then
	-- 	M.bufs[M.panelCurrent] = nil
	-- end
	M.setView(M.panelCurrent)

	if not focus then
		vim.api.nvim_set_current_win(curWin)
	end
end

M.next = function()
	local current = 0
	for i, v in ipairs(M.config.panel.order) do
		if v == M.panelCurrent then
			current = i
			break
		end
	end

	if M.config.panel.views[M.panelCurrent].close then
		M.config.panel.views[M.panelCurrent].close()
	end

	if current == #M.config.panel.order then
		current = 1
	else
		current = current + 1
	end

	M.panelCurrent = M.config.panel.order[current]

	M.setView(M.panelCurrent)
end

M.previous = function()
	local current = 0
	for i, v in ipairs(M.config.panel.order) do
		if v == M.panelCurrent then
			current = i
			break
		end
	end

	if M.config.panel.views[M.panelCurrent].close then
		M.config.panel.views[M.panelCurrent].close()
	end

	current = current - 1

	if current == 0 then
		current = #M.config.panel.order
	end

	M.panelCurrent = M.config.panel.order[current]

	M.setView(M.panelCurrent)
end

---@fun toggle
M.toggle = function()
	vim.o.lazyredraw = true
	if M.isOpen() then
		M.close()

		vim.o.lazyredraw = false

		return
	end

	if not hasBufs() then
		initPanel()
	end

	M.open(true)

	vim.api.nvim_set_current_win(M.win)
	vim.o.lazyredraw = false
end

setupAutocmds()

return M
