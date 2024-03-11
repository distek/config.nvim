-- Returns to previous position in file
Util.line_return = function()
	local line = vim.fn.line

	if line("'\"") > 0 and line("'\"") <= line("$") then
		vim.cmd("normal! g`\"zvzz'")
	end
end

Util.dapStart = function()
	local dapui = require("dapui")
	dapui.open({})
end

Util.dapStop = function()
	local dap = require("dap")
	local dapui = require("dapui")

	if dap.session() then
		dap.disconnect()
	end

	dap.close()
	dapui.close({})
end

local function hexToRgb(hex_str)
	if hex_str == "none" then
		return
	end

	local hex = "[abcdef0-9][abcdef0-9]"
	local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
	hex_str = string.lower(hex_str)

	assert(
		string.find(hex_str, pat) ~= nil,
		"hex_to_rgb: invalid hex_str: " .. tostring(hex_str)
	)

	local r, g, b = string.match(hex_str, pat)
	return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

local function blend(fg, bg, alpha)
	bg = hexToRgb(bg)
	fg = hexToRgb(fg)

	local blendChannel = function(i)
		local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
		return math.floor(math.min(math.max(0, ret), 255) + 0.5)
	end

	return string.format(
		"#%02X%02X%02X",
		blendChannel(1),
		blendChannel(2),
		blendChannel(3)
	)
end

Util.darken = function(hex, amount)
	return blend(hex, "#000000", math.abs(amount))
end

Util.lighten = function(hex, amount)
	return blend(hex, "#ffffff", math.abs(amount))
end

Util.getColor = function(group, attr)
	return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
end

Util.inspect = function(vars, ...)
	print(vim.inspect(vars, ...))
end

Util.getNeighbors = function()
	local ret = {
		top = false,
		bottom = false,
		left = false,
		right = false,
	}

	if #vim.api.nvim_list_wins() == 1 then
		return ret
	end

	local currentWin = vim.fn.winnr()

	if currentWin ~= vim.fn.winnr("k") then
		ret.top = true
	end

	if currentWin ~= vim.fn.winnr("j") then
		ret.bottom = true
	end

	if currentWin ~= vim.fn.winnr("h") then
		ret.left = true
	end

	if currentWin ~= vim.fn.winnr("l") then
		ret.right = true
	end

	return ret
end

Util.printAllWindowBuffers = function()
	for _, v in ipairs(vim.api.nvim_list_wins()) do
		local name = vim.fn.bufname(vim.api.nvim_win_get_buf(v))
		if name then
			print(name)
		else
			print("unnamed")
		end
	end
end

Util.printAllWindowConfigs = function()
	for _, v in ipairs(vim.api.nvim_list_wins()) do
		Util.inspect(vim.api.nvim_win_get_config(v))
	end
end

Util.printBufSettings = function()
	for k, v in pairs(vim.b[0]) do
		print(k)
		vim.print(v)
	end
end

Util.compVsWinCount = function()
	local winCount = 0
	local compCount = 0

	local compFts = {
		"neo-tree",
		"toggleterm",
		"Outline",
		"Trouble",
		"qf",
		"help",
	}

	for _, v in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(v).relative == "" then
			local ft = vim.api.nvim_win_call(v, function()
				return vim.bo.filetype
			end)

			for _, c in ipairs(compFts) do
				if c == ft then
					compCount = compCount + 1

					break
				end
			end

			winCount = winCount + 1
		end
	end
	return compCount, winCount
end

Util.ifNameExists = function(n)
	for _, v in ipairs(vim.api.nvim_list_wins()) do
		local name = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(v))
		if string.find(name, n, 1, true) then
			return true, v
		end
	end
	return false, nil
end

Util.vimCmdToBuffer = function(cmd)
	local output = vim.api.nvim_exec2(cmd, { output = true })

	vim.cmd("vnew")

	local t = {}
	for line in string.gmatch(output.output, "([^\n]+)") do
		table.insert(t, line)
	end

	vim.api.nvim_buf_set_lines(0, 0, 0, false, t)
end

Util.bdelete = function(all, force)
	local ignoreFiletypes = { "Outline", "toggleterm", "neo-tree" }
	local bufs = vim.api.nvim_list_bufs()

	if all then
		local foundBufs = {}
		for _, v in ipairs(bufs) do
			local buf = vim.fn.getbufinfo(v)[1]

			if buf == nil or #buf.windows == 0 then
				goto continue
			end

			local ft = vim.bo[v].filetype
			if buf.hidden == 1 then
				goto continue
			end

			for _, f in ipairs(ignoreFiletypes) do
				if f == ft then
					vim.api.nvim_win_close(vim.fn.bufwinid(v), false)
					goto continue
				end
			end

			table.insert(foundBufs, v)

			::continue::
		end

		for _, v in ipairs(foundBufs) do
			local forceStr = ""
			if force then
				forceStr = "!"
			end
			vim.cmd(v .. "Bdelete" .. forceStr)
		end
	else
		for _, f in ipairs(ignoreFiletypes) do
			if f == vim.bo.filetype then
				return
			end
		end

		local forceStr = ""
		if force then
			forceStr = "!"
		end
		vim.cmd("Bdelete" .. forceStr)
	end
end

Util.is_neotree_open = function()
	local exists, _ = Util.ifNameExists("neo-tree")
	return exists
end

Util.printAllTerminalColors = function()
	print("background: " .. Util.getColor("Normal", "bg"))
	print("foreground: " .. Util.getColor("Normal", "fg"))
	print("color0: " .. vim.g.terminal_color_0)
	print("color1: " .. vim.g.terminal_color_1)
	print("color2: " .. vim.g.terminal_color_2)
	print("color3: " .. vim.g.terminal_color_3)
	print("color4: " .. vim.g.terminal_color_4)
	print("color5: " .. vim.g.terminal_color_5)
	print("color6: " .. vim.g.terminal_color_6)
	print("color7: " .. vim.g.terminal_color_7)
	print("color8: " .. vim.g.terminal_color_8)
	print("color9: " .. vim.g.terminal_color_9)
	print("color10: " .. vim.g.terminal_color_10)
	print("color11: " .. vim.g.terminal_color_11)
	print("color12: " .. vim.g.terminal_color_12)
	print("color13: " .. vim.g.terminal_color_13)
	print("color14: " .. vim.g.terminal_color_14)
	print("color15: " .. vim.g.terminal_color_15)
end

Util.addToQF = function()
	-- local qfl = vim.fn.getqflist()

	local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
	local buf = vim.api.nvim_get_current_buf()

	local line = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)[1]

	vim.fn.setqflist(
		{ { lnum = row, end_lnum = row, bufnr = buf, text = line } },
		"a"
	)
end

Util.delFromQF = function()
	if vim.bo.filetype ~= "qf" then
		return
	end

	local qfl = vim.fn.getqflist()

	local row, _ = unpack(vim.api.nvim_win_get_cursor(0))

	vim.fn.setqflist({}, "r")

	local newQFList = {}
	for i, v in ipairs(qfl) do
		if i ~= row then
			table.insert(newQFList, v)
		end
	end

	vim.fn.setqflist(newQFList)
end

Util.getAllOptions = function()
	local win_number = vim.api.nvim_get_current_win()
	local v = vim.w[win_number]
	local all_options = vim.api.nvim_get_all_options_info()
	local result = ""
	for key, val in pairs(all_options) do
		if val.global_local == false and val.scope == "win" then
			result = result
				.. "|"
				.. key
				.. "="
				.. tostring(v[key] or "<not set>")
				.. "\n"
		end
	end
	print(result)
end

Util.reopenBuffer = function()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local telescopeConfig = require("telescope.config").values

	local opts = {}

	pickers
		.new(opts, {
			prompt_title = "Reopen buffer",
			finder = finders.new_table({
				results = Util.reverseTable(BufStack),
			}),
			previewer = nil,
			sorter = telescopeConfig.generic_sorter(opts),
			create_layout = TelescopeLayoutGen("select"),
		})
		:find()
end

---@param f function some function
---@param delay number delay in ms
function Util.defer(f, delay)
	vim.schedule(function()
		vim.defer_fn(f, delay)
	end)
end

function Util.reverseTable(t)
	if t == nil or next(t) ~= nil and #t == 0 then
		return {}
	end

	local ret = {}

	for i = #t, 1, -1 do
		table.insert(ret, t[i])
	end

	return ret
end

function Util.bufClose(minwid, _, _, _)
	vim.api.nvim_buf_delete(minwid, { force = false })
end

function Util.bufSelect(minwid, _, _, _)
	if vim.api.nvim_buf_is_valid(minwid) then
		vim.api.nvim_win_set_buf(0, minwid)
	else
		vim.notify("Buffer not valid: " .. minwid, vim.log.levels.ERROR)
	end
end

function Util.setTabName()
	vim.ui.input({ prompt = "Tab name: " }, function(input)
		if input == "" then
			return
		end

		vim.api.nvim_tabpage_set_var(0, "name", input)
	end)
end

function Util.getTabName(idx)
	local ok, name = pcall(vim.api.nvim_tabpage_get_var, idx, "name")
	return ok and name or nil
end

local pagerDefaultKeymaps = {
	{ "n", "q", "<cmd>q!<cr>", { buffer = true } },
	{ "n", "u", "<C-u>", { buffer = true } },
	{ "n", "d", "<C-d>", { buffer = true } },
	{ "n", "J", "<C-u>", { buffer = true } },
	{ "n", "K", "<C-d>", { buffer = true } },
}

function Util.pagerize(ft)
	local buf = vim.api.nvim_get_current_buf()
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].modifiable = false
	vim.bo[buf].bufhidden = "hide"
	vim.bo[buf].buflisted = false
	vim.bo[buf].modified = false
	vim.bo[buf].filetype = ft

	vim.o.showtabline = 0

	for _, v in ipairs(pagerDefaultKeymaps) do
		vim.keymap.set(v[1], v[2], v[3], v[4])
	end
end

local function createTerm(cmd)
	cmd = string.gsub(cmd, " ", "\\ ")
	vim.cmd("vsplit +term\\ " .. cmd)
	local hideMe = vim.api.nvim_get_current_win()

	local bufid = vim.api.nvim_get_current_buf()

	vim.bo[bufid].buflisted = false
	vim.bo[bufid].filetype = "floatterm"

	vim.api.nvim_win_hide(hideMe)

	return bufid
end

local function vsplit()
	vim.cmd("vsplit")

	return vim.api.nvim_get_current_win()
end

local function split()
	vim.cmd("split")

	return vim.api.nvim_get_current_win()
end

-- Stolen form a spudtastic potato
local function float(winid, width, height)
	-- Allow it to fail if the window can't be floated
	local api = vim.api
	if (#api.nvim_list_wins()) < 2 then
		print("Float() can only be used if there is more than one window")
		return -1
	end

	local ui = api.nvim_list_uis()[1]

	local quadBufHeight = api.nvim_buf_line_count(api.nvim_get_current_buf())
		* 4

	-- Ensure the window is not ridiculously large for the content
	if quadBufHeight < height then
		height = quadBufHeight
	end

	local opts = {
		relative = "editor",
		width = width,
		height = height,
		col = math.floor(ui.width / 2) - math.floor(width / 2),
		row = math.floor(ui.height / 2) - math.floor(height / 2),
		anchor = "NW",
		style = "minimal",
		border = "shadow",
	}

	api.nvim_win_set_config(winid, opts)
end

function Util.lazygit()
	local buf = createTerm("lazygit")

	vim.bo[buf].buflisted = false

	local winid = split()

	vim.api.nvim_win_set_buf(winid, buf)

	float(
		winid,
		math.floor(vim.api.nvim_list_uis()[1].width * 0.75),
		math.floor(vim.api.nvim_list_uis()[1].height * 0.75)
	)

	vim.cmd("startinsert")

	vim.api.nvim_create_autocmd("TermClose", {
		buffer = buf,
		callback = function()
			vim.cmd("close")
		end,
	})
end
