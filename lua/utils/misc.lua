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
