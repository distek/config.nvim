function len(t)
	local count = 0
	for _ in pairs(t) do
		count = count + 1
	end
	return count
end

-- Returns to previous position in file
Util.line_return = function()
	local line = vim.fn.line

	if line("'\"") > 0 and line("'\"") <= line("$") then
		vim.cmd("normal! g`\"zvzz'")
	end
end

-- Skips over quickfix buf when tabbing through buffers
-- Reason: QF appears to overwrite the <Tab> mappings
Util.skipUnwantedBuffers = function(dir)
	-- Util.bufFocus(dir)
	if dir == "next" then
		-- require('tabline').buffer_next()
		require("bufferline").cycle(1)
	else
		-- require('tabline').buffer_previous()
		require("bufferline").cycle(-1)
	end

	local buftype = vim.api.nvim_buf_get_option(0, "buftype")

	if buftype == "quickfix" or buftype == "terminal" then
		if buftype == "terminal" then
			-- if the terminal is not open elsewhere
			if len(vim.fn.win_findbuf(vim.fn.bufnr("%"))) == 1 then
				return
			end

			vim.cmd([[stopinsert]])

			return
		end

		Util.skipUnwantedBuffers(dir)
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

	assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

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

	return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
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

	if len(vim.api.nvim_list_wins()) == 1 then
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

Util.compVsWinCount = function()
	local winCount = 0
	local compCount = 0

	for _, v in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(v).relative == "" then
			local ft = vim.api.nvim_win_call(v, function()
				return vim.bo.filetype
			end)

			if ft == "NvimTree" or ft == "toggleterm" or ft == "Outline" then
				compCount = compCount + 1
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
	local output = vim.api.nvim_command_output(cmd)

	vim.cmd("vnew")

	for line in string.gmatch(output, "([^\n]+)") do
		vim.api.nvim_buf_set_lines(0, 0, 0, false, { line })
	end
end

Util.bdelete = function(all, force)
	local ignoreFiletypes = { "Outline", "toggleterm", "NvimTree" }
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
			vim.cmd(v .. "Bdelete")
		end
	else
		for _, f in ipairs(ignoreFiletypes) do
			if f == vim.bo.filetype then
				return
			end
		end

		if force then
			vim.cmd("Bdelete!")
		else
			vim.cmd("Bdelete")
		end
	end
end
