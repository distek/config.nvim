---@return bufid
local function openToggleTerm()
	vim.cmd("vsplit +term\\ tmux-nest")

	local buf = vim.api.nvim_get_current_buf()

	vim.bo[buf].buflisted = false
	vim.bo[buf].filetype = "toggleterm"

	vim.api.nvim_create_augroup("EdgyToggleTerm", { clear = true })
	vim.api.nvim_create_autocmd({ "TermEnter", "WinEnter", "BufEnter" }, {
		group = "EdgyToggleTerm",
		callback = function(ev)
			vim.schedule(function()
				vim.defer_fn(function()
					buf = vim.api.nvim_get_current_buf()
					if vim.bo[buf].filetype == "toggleterm" then
						vim.cmd("startinsert")
					end
				end, 10)
			end)
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
---@field open fun(): bufid
---@field wo table<string, any>

---@class edge
---@field panelCurrent string|nil
---@field winResized boolean
---@field winResizeH boolean
---@field winResizeV boolean
---@field bufs table<string,number>
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
			},
			views = {
				["Terminal"] = {
					ft = "toggleterm",
					open = openToggleTerm,
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
						vim.cmd("Trouble")

						local bufid = vim.api.nvim_get_current_buf()

						require("trouble").view.win = Panel.win

						return bufid
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
					wo = {
						winhighlight = "Normal:EdgyTermNormal",
					},
				},
			},
		},
	},
}

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

	vim.cmd("horizontal botright split")
	panelWin = vim.api.nvim_get_current_win()

	saveDefaultWinOpts(panelWin)

	vim.api.nvim_win_set_height(panelWin, size or 15)

	local group = vim.api.nvim_create_augroup("PanelResize", { clear = true })
	vim.api.nvim_create_autocmd({ "WinResized" }, {
		group = group,
		callback = function()
			if Panel.winResized then
				Panel.config.panel.size = vim.api.nvim_win_get_height(Panel.win)

				Panel.winResized = false
			end
		end,
	})

	vim.api.nvim_create_autocmd({ "WinResized", "WinNew", "WinClosed" }, {
		group = group,
		callback = function()
			if not Panel.winResized then
				if
					Panel.win ~= nil and vim.api.nvim_win_is_valid(Panel.win)
				then
					vim.api.nvim_win_set_height(
						Panel.win,
						Panel.config.panel.size
					)
				end
			end
		end,
	})

	vim.o.lazyredraw = false
	return panelWin
end

---@param panelName string
---@param view view
---@return bufid
local function handleOpen(panelName, view)
	local bufid = view.open()

	M.bufs[panelName] = bufid

	local winid = vim.api.nvim_get_current_win()

	vim.bo[bufid].bufhidden = "hide"
	vim.bo[bufid].buflisted = false

	vim.api.nvim_win_hide(winid)

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
				if vim.api.nvim_get_current_win() == M.win then
					return
				end

				vim.schedule(function()
					vim.defer_fn(function()
						local temp = vim.o.eventignore
						vim.o.eventignore = "FileType"
						if not M.isOpen() then
							M.panelCurrent = k

							M.bufs[M.panelCurrent] = ev.buf
						else
							if M.panelCurrent == k then
								vim.o.eventignore = temp or ""
								return
							end

							M.setView(k)
						end

						for _, win in ipairs(vim.api.nvim_list_wins()) do
							if vim.api.nvim_win_get_buf(win) == ev.buf then
								if v ~= M.win then
									vim.api.nvim_win_close(win, true)
								end
							end
						end

						M.openPanel()
						vim.o.eventignore = temp or ""
					end, 1)
				end)
			end,
		})
	end

	-- Create a new win if whatever command we had running closed it
	vim.api.nvim_create_autocmd({ "WinClosed" }, {
		callback = function(ev)
			if tonumber(ev.match) == M.win then
				if M.winClosing then
					return
				end
				M.win = createWindow(M.config.panel.size)
			end
		end,
	})
end

local function initPanel()
	-- set the panelCurrent to the first entry
	M.panelCurrent = M.config.panel.order[1]

	local bufid =
		handleOpen(M.panelCurrent, M.config.panel.views[M.panelCurrent])

	M.bufs[M.panelCurrent] = bufid
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
		if #vim.fn.getbufinfo(v)[1].windows == 0 then
			vim.bo[v].bufhidden = "hide"
			vim.bo[v].buflisted = false
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
	restoreWinOpts(M.win)
	if M.bufs[name] == nil then
		M.bufs[name] = handleOpen(name, M.config.panel.views[name])
	end

	if M.panelCurrent ~= name then
		M.panelCurrent = name
	end

	vim.api.nvim_win_set_buf(M.win, M.bufs[name])

	renderWinbar(M.win)

	vim.api.nvim_win_set_height(M.win, M.config.panel.size)

	setWinOpts(M.win, M.config.panel.views[name].wo)
	cleanBufs()

	vim.o.lazyredraw = false
end

M.handleClickTab = function(minwid, clicks, btn, mods)
	local p = M.config.panel.order[minwid]

	M.panelCurrent = p

	M.setView(M.panelCurrent)
end

M.openPanel = function()
	M.win = createWindow(M.config.panel.size)

	M.setView(M.panelCurrent)
end

M.panelNext = function()
	local current = 0
	for i, v in ipairs(M.config.panel.order) do
		if v == M.panelCurrent then
			current = i
			break
		end
	end

	if current == #M.config.panel.order then
		current = 1
	else
		current = current + 1
	end

	M.panelCurrent = M.config.panel.order[current]

	M.setView(M.panelCurrent)
end

M.panelPrevious = function()
	local current = 0
	for i, v in ipairs(M.config.panel.order) do
		if v == M.panelCurrent then
			current = i
			break
		end
	end

	current = current - 1

	if current == 0 then
		current = #M.config.panel.order
	end

	M.panelCurrent = M.config.panel.order[current]

	M.setView(M.panelCurrent)
end

---@fun toggle
---@param dir string panel direction
M.toggle = function(dir)
	vim.o.lazyredraw = true
	if M.isOpen() then
		M.close()

		vim.o.lazyredraw = false

		return
	end

	if not hasBufs() then
		initPanel()
	end

	M.openPanel()

	vim.api.nvim_set_current_win(M.win)
	vim.o.lazyredraw = false
end

setupAutocmds()

return M
