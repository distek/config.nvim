---@param f function some function
---@param delay number delay in ms
function Util.defer(f, delay)
	vim.schedule(function()
		vim.defer_fn(f, delay)
	end)
end

Util.GetNormalBuffers = function()
	local buffers = vim.api.nvim_list_bufs()
	local normalBuffers = {}

	for _, buf in ipairs(buffers) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.fn.buflisted(buf) == 1 then
			table.insert(normalBuffers, buf)
		end
	end

	return normalBuffers
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

-- Function to get the visual selection
local function get_visual_selection()
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")
	local start_col = vim.fn.col("'<")
	local end_col = vim.fn.col("'>")

	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

	if #lines == 0 then
		return ""
	end

	if #lines == 1 then
		return lines[1]:sub(start_col, end_col - 1)
	else
		local first_line = lines[1]:sub(start_col)
		local last_line = lines[#lines]:sub(1, end_col - 1)
		table.remove(lines, 1)
		table.remove(lines, #lines)
		table.insert(lines, 1, first_line)
		table.insert(lines, last_line)
		return table.concat(lines, "\n")
	end
end

-- Function to add the visual selection to the quickfix list
Util.AddVisualSelectionToQuickfix = function()
	-- Get the visual selection range
	local startLine = vim.fn.line("'<")
	local endLine = vim.fn.line("'>")

	-- Get current buffer info
	local bufnr = vim.api.nvim_get_current_buf()
	local filename = vim.api.nvim_buf_get_name(bufnr)

	-- Get the selected lines
	local lines = vim.api.nvim_buf_get_lines(bufnr, startLine - 1, endLine, false)

	-- Build quickfix entries
	local qfItems = {}
	for i, line in ipairs(lines) do
		table.insert(qfItems, {
			bufnr = bufnr,
			filename = filename,
			lnum = startLine + i - 1,
			text = line,
			col = 1,
		})
	end

	-- Get existing quickfix list
	local currentQfList = vim.fn.getqflist()

	-- Append new items to existing list
	for _, item in ipairs(qfItems) do
		table.insert(currentQfList, item)
	end

	-- Set the updated quickfix list
	vim.fn.setqflist(currentQfList)

	-- -- Optional: Open quickfix window
	-- vim.cmd("copen")
end
