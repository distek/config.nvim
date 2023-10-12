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
			vim.defer_fn(function()
				if vim.bo[ev.buf].filetype == "toggleterm" then
					vim.cmd("startinsert")
				end
			end, 10)
		end,
	})

	vim.api.nvim_win_close(vim.api.nvim_get_current_win(), false)

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
---@field bufs table<number,view>
---@field panel panel
local M = {
	panelCurrent = nil,

	winResized = false,
	winResizeH = false,
	winResizeV = false,

	bufs = {},

	win = nil,

	---@class config
	---@field panel panel
	config = {
		panel = {
			size = 15,
			order = {
				"Terminal",
				-- "Problems",
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
				-- ["Problems"] = {
				-- 	ft = "Trouble",
				-- 	open = function()
				-- 		vim.cmd("Trouble")

				-- 		local bufid = vim.api.nvim_get_current_buf()

				-- 		vim.api.nvim_create_augroup(
				-- 			"EdgyTrouble",
				-- 			{ clear = true }
				-- 		)
				-- 		vim.api.nvim_create_autocmd(
				-- 			{ "WinEnter", "BufEnter" },
				-- 			{
				-- 				group = "EdgyTrouble",
				-- 				callback = function()
				-- 					require("trouble").view.win =
				-- 						Edge.wins.bottom

				-- 					if
				-- 						vim.api.nvim_get_current_buf()
				-- 						== bufid
				-- 					then
				-- 						vim.cmd("stopinsert")
				-- 					end
				-- 				end,
				-- 			}
				-- 		)

				-- 		return bufid
				-- 	end,
				-- 	wo = {
				-- 		winhighlight = "Normal:EdgyTermNormal",
				-- 		statuscolumn = "",
				-- 	},
				-- },
				["Quickfix"] = {
					ft = "qf",
					open = function()
						vim.cmd(":copen")

						return vim.api.nvim_get_current_buf()
					end,
					wo = {
						winhighlight = "Normal:EdgyQuickfixNormal",
					},
				},
			},
		},
	},
}

---@param size number
---@return winid
local function createWindow(size)
	local panelWin = 0

	vim.cmd("horizontal botright split")
	panelWin = vim.api.nvim_get_current_win()

	vim.api.nvim_win_set_height(panelWin, size or 15)

	vim.api.nvim_create_augroup("EdgeResize", { clear = true })
	vim.api.nvim_create_autocmd({ "WinResized" }, {
		group = "EdgeResize",
		callback = function()
			if Edge.winResized then
				Edge.config.panel.size = vim.api.nvim_win_get_height(Edge.win)

				Edge.winResized = false
			end
		end,
	})

	vim.api.nvim_create_autocmd({ "WinResized", "WinNew", "WinClosed" }, {
		group = "EdgeResize",
		callback = function()
			if not Edge.winResized then
				if Edge.win ~= nil and vim.api.nvim_win_is_valid(Edge.win) then
					vim.api.nvim_win_set_height(
						Edge.win,
						Edge.config.panel.size
					)
				end
			end
		end,
	})

	return panelWin
end

---@param panelName string
---@param view view
---@return bufid,winid
local function handleOpen(panelName, view)
	local bufid = view.open()

	M.bufs[panelName] = bufid

	local winid = vim.api.nvim_get_current_win()

	vim.bo[bufid].bufhidden = "hide"
	vim.bo[bufid].buflisted = false

	return bufid, winid
end

-----@param dir string
-----@param panel panel
--local function initViews(dir, panel)
--	for k, v in pairs(panel.views) do
--		if
--			M.bufs[dir][k] == nil
--			or not vim.api.nvim_buf_is_valid(M.bufs[dir][k])
--		then
--			M.bufs[dir][k] = handleOpen(dir, k, v)
--		end
--	end
--end

local function initPanel()
	-- set the panelCurrent to the first entry
	M.panelCurrent = M.config.panel.order[1]

	local bufid, _ =
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
		vim.api.nvim_win_close(M.win, true)
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

		wb = wb .. "%" .. i .. "@v:lua.Edge.handleClickTab@ "

		wb = wb .. v .. " %X"

		wb = wb .. " %#TabLineFill# "

		wb = wb .. "%#Normal#"
	end

	wb = wb .. "%#TabLineFill#"

	vim.wo[winid].winbar = wb

	for k, v in pairs(M.config.panel.views[M.panelCurrent].wo) do
		vim.wo[winid][k] = v
	end

	vim.cmd("redraw")
end

M.handleClickTab = function(minwid, clicks, btn, mods)
	local p = M.config.panel.order[minwid]

	M.panelCurrent = p

	if M.bufs[p] == nil then
		handleOpen(p, M.config.panel.views[p])
	end

	vim.api.nvim_win_set_buf(M.win, M.bufs[p])

	vim.api.nvim_win_set_height(M.win, M.config.panel.size)

	renderWinbar(M.win)
end

---@param name string
M.setView = function(name)
	if M.bufs[name] == nil then
		M.bufs[name], _ = handleOpen(name, M.config.panel.views[name])
	end

	M.panelCurrent = name

	vim.api.nvim_win_set_buf(M.win, M.bufs[M.panelCurrent])

	renderWinbar(M.win)

	vim.api.nvim_win_set_height(M.win, M.config.panel.size)

	cleanBufs()
end

M.openPanel = function()
	M.win = createWindow(M.config.panel.size)

	vim.api.nvim_win_set_buf(M.win, M.bufs[M.panelCurrent])

	renderWinbar(M.win)

	vim.api.nvim_win_set_height(M.win, M.config.panel.size)

	cleanBufs()
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

	if M.bufs[M.panelCurrent] == nil then
		local bufid, winid =
			handleOpen(M.panelCurrent, M.config.panel.views[M.panelCurrent])

		M.bufs[M.panelCurrent] = bufid

		vim.api.nvim_win_close(winid, true)
	end

	vim.api.nvim_win_set_buf(M.win, M.bufs[M.panelCurrent])

	vim.api.nvim_win_set_height(M.win, M.config.panel.size)

	renderWinbar(M.win)
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

	vim.api.nvim_win_set_buf(M.win, M.bufs[M.panelCurrent])

	vim.api.nvim_win_set_height(M.win, M.config.panel.size)

	renderWinbar(M.win)
end

---@fun toggle
---@param dir string paneel direction
M.toggle = function(dir)
	if M.isOpen() then
		M.close()
		return
	end

	if not hasBufs() then
		initPanel()
	end

	M.openPanel()

	vim.api.nvim_set_current_win(M.win)
end

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(ev)
		for k, v in pairs(Edge.config.panel.views) do
			if vim.bo[ev.buf].filetype == v.ft then
				if not Edge.isOpen() then
					initPanel()

					Edge.panelCurrent = k

					Edge.openPanel()
				else
					Edge.setView(k)
				end
			end
		end
	end,
})

return M
