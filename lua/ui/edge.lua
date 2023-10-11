---@return bufid
local function openToggleTerm()
	vim.cmd("vsplit +term\\ tmux-nest")

	local buf = vim.api.nvim_get_current_buf()

	vim.bo[buf].buflisted = false
	vim.bo[buf].filetype = "toggleterm"

	vim.api.nvim_create_augroup("EdgyToggleTerm", { clear = true })
	vim.api.nvim_create_autocmd({ "TermEnter", "WinEnter" }, {
		group = "EdgyToggleTerm",
		callback = function(ev)
			vim.defer_fn(function()
				if vim.bo[ev.buf].filetype == "toggleterm" then
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
---@field views view[]

---@class view
---@field ft string
---@field collapsed boolean
---@field filter? fun(buf: bufid): boolean
---@field height number
---@field open fun(): bufid
---@windowOpts table

---@class edge
---@field panelCurrent string|nil
local M = {
	panelCurrent = nil,

	---@class bufs
	---@field left number[]
	---@field right number[]
	---@field bottom number[]
	bufs = {
		left = {},
		right = {},
		bottom = {},
	},

	---@class wins
	---@field left number[]
	---@field right number[]
	---@field bottom number|nil
	wins = {
		left = {},
		right = {},
		bottom = nil,
	},

	---@class config
	---@field panels panel[]
	config = {
		---@class panels
		---@field left panel
		---@field right panel
		---@field bottom panel
		panels = {
			left = {
				size = 35,
				views = {
					-- {
					-- 	title = "Buffers",
					-- 	ft = "neo-tree",
					-- 	height = 0.25,
					-- 	filter = function(buf)
					-- 		return vim.b[buf].neo_tree_source == "buffers"
					-- 	end,
					-- 	pinned = true,
					-- 	open = "Neotree position=top buffers",
					-- 	wo = {
					-- 		winbar = true,
					-- 	},
					-- },
					["Files"] = { ---@type view
						ft = "neo-tree",
						filter = function(buf)
							return vim.b[buf].neo_tree_source == "filesystem"
						end,
						open = function()
							vim.cmd("Neotree")

							return vim.api.nvim_win_get_buf(0)
						end,
						collapsed = true,
						height = 0.75,
						wo = {
							winbar = true,
						},
					},
				},
			},
			right = {
				size = 35,
				views = {
					["Outline"] = {
						ft = "Outline",
						visible = false,
						height = 0.25,
						pinned = true,
						open = "SymbolsOutlineOpen",
						wo = {
							winbar = true,
						},
					},
					-- {
					-- 	title = "Tests",
					-- 	ft = "neotest-summary",
					-- 	pinned = true,
					-- 	open = "Neotest summary",
					-- 	height = 0.75,
					-- 	wo = {
					-- 		winbar = true,
					-- 		wrap = false,
					-- 	},
					-- },
				},
			},
			bottom = {
				size = 15,
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

							return vim.api.nvim_get_current_buf()
						end,
						wo = {
							winhighlight = "Normal:EdgyTermNormal",
							statuscolumn = "",
						},
					},
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
	},
}

-- current indicates the currently focused panel item by name

local function dirError()
	vim.notify(
		"did not match dir: dir must be 'left', 'right', or 'bottom'",
		vim.log.levels.ERROR
	)
end

---@param dir string
---@param size number
---@return winid
local function createWindow(dir, size)
	local panelWin = 0

	if dir == "bottom" then
		vim.cmd("horizontal botright split")
		panelWin = vim.api.nvim_get_current_win()
	elseif dir == "left" then
		vim.cmd("vertical topleft split")
		panelWin = vim.api.nvim_get_current_win()
	elseif dir == "right" then
		vim.cmd("vertical botright split")
		panelWin = vim.api.nvim_get_current_win()
	end

	if dir == "bottom" then
		vim.api.nvim_win_set_height(panelWin, size or 15)
	else
		vim.api.nvim_win_set_width(panelWin, size or 35)
	end

	return panelWin
end

---@param dir string
---@param panel panel
local function initViews(dir, panel)
	for k, v in pairs(panel.views) do
		if
			M.bufs[dir][k] == nil
			or not vim.api.nvim_buf_is_valid(M.bufs[dir][k])
		then
			local bufid = v.open()
			if bufid ~= nil then
				M.bufs[dir][k] = bufid
				vim.bo[bufid].bufhidden = "hide"
				vim.bo[bufid].buflisted = true
			else
				vim.notify(
					string.format(
						"could not open panel item: dir=%s panel-view=%s",
						dir,
						k
					)
				)
			end
		end
	end
end

local function initPanel()
	-- set the panelCurrent to the first entry
	for k, _ in pairs(M.config.panels["bottom"].views) do
		M.panelCurrent = k

		break
	end

	local bufid = M.config.panels["bottom"].views[M.panelCurrent].open()

	M.bufs["bottom"][M.panelCurrent] = bufid

	local closeMe = vim.api.nvim_get_current_win()

	vim.bo[bufid].bufhidden = "hide"
	vim.bo[bufid].buflisted = true

	vim.api.nvim_win_close(closeMe, true)
end

---@param dir string
---@return boolean
local function validDir(dir)
	if dir ~= "right" and dir ~= "left" and dir ~= "bottom" then
		dirError()
		return false
	end

	return true
end

---@param dir string
---@return boolean
local function dirHasBufs(dir)
	if #M.bufs[dir] > 0 then
		for k, v in pairs(M.bufs[dir]) do
			if vim.api.nvim_buf_is_valid(v) then
				return true
			end
		end
	end

	return false
end

---@param dir string
M.isOpen = function(dir)
	if dir == "bottom" then
		if M.wins["bottom"] == nil then
			return false
		end

		return vim.api.nvim_win_is_valid(M.wins["bottom"])
	end

	for _, win in ipairs(vim.api.nvim_list_wins()) do
		for _, edgeWin in pairs(M.wins[dir]) do
			if win == edgeWin then
				return true
			end
		end
	end

	return false
end

---@param dir string
M.close = function(dir)
	if dir == "bottom" then
		if vim.api.nvim_win_is_valid(M.wins["bottom"]) then
			vim.api.nvim_win_close(M.wins["bottom"], true)
		end

		return
	end

	for k, v in pairs(M.wins[dir]) do
		if vim.api.nvim_win_is_valid(v) then
			vim.api.nvim_win_close(v, true)
		else
			M.wins[dir][k] = nil
			return
		end
	end
end

---@param dir string
M.openSide = function(dir)
	for k, v in ipairs(M.config.panels["bottom"].views) do
	end
end

M.handleClickTab = function(minwid, clicks, btn, mods)
	vim.print(minwid)
	vim.api.nvim_win_set_buf(M.wins["bottom"], M.bufs["bottom"][minwid])

	M.panelCurrent = minwid
end

M.handleOpenTab = function(...)
	vim.print(...)
end

M.openPanel = function()
	M.wins["bottom"] = createWindow("bottom", M.config.panels["bottom"].size)

	vim.api.nvim_win_set_buf(M.wins["bottom"], M.bufs["bottom"][M.panelCurrent])

	local wb = ""

	local list = {}

	for k, _ in pairs(M.config.panels["bottom"].views) do
		table.insert(list, k)
	end

	local count = 1
	for i, v in ipairs(list) do
		if v == M.panelCurrent then
			wb = wb .. "%#TabLineSel#▎"
			wb = wb .. "%#TabLineSel# "
		else
			wb = wb .. "%#TabLine#▎%#TabLine# "
		end

		if M.bufs["bottom"][v] ~= nil then
			wb = wb
				.. "%"
				.. M.bufs["bottom"][v]
				.. "@v:lua.Edge.handleClickTab@ "
		else
			wb = wb .. "%" .. 0 .. "@v:lua.Edge.handleOpenTab@ "
		end

		wb = wb .. v .. " %X"

		if count > 1 and i ~= count then
			wb = wb .. " %#TabLineFill# "
		else
			wb = wb .. " "
		end

		wb = wb .. "%#Normal#"

		count = count + 1
	end

	wb = wb .. "%#TabLineFill#"

	vim.wo[M.wins["bottom"]].winbar = wb

	for k, v in pairs(M.config.panels["bottom"].views[M.panelCurrent].wo) do
		vim.wo[M.wins["bottom"]][k] = v
	end

	vim.cmd("resize")
end

---@fun toggle
---@param dir string paneel direction
M.toggle = function(dir)
	if not validDir(dir) then
		return
	end

	if M.isOpen(dir) then
		M.close(dir)
		return
	end

	if dir == "bottom" then
		if not dirHasBufs("bottom") then
			initPanel()
		end

		M.openPanel()
		return
	end

	if not dirHasBufs(dir) then
		initViews(dir, M.config.panels[dir])
	end

	M.openSide(dir)
end

return M
