GitPopupThing = {}

local statusMatch = {
	[" M"] = "Red",
	["M "] = "Green",
	["T"] = "Blue",
	["A"] = "Green",
	["D"] = "LightBlack",
	["R"] = "Blue",
	["C"] = "Yellow",
	["??"] = "Red",
	["!!"] = "LightBlack",
}

local statusNames = {
	[" M"] = "Unstaged",
	["M "] = "Staged",
	["??"] = "Untracked",
	["!!"] = "Ignored",
}

local function statusName(s)
	return statusNames[s] ~= nil and statusNames[s] or "unknown"
end

local function statusColor(s)
	for k, v in pairs(statusMatch) do
		if s == k then
			return v
		end
	end

	-- Unhandled
	return "White"
end

local function stringSplit(s, delim)
	if delim == nil then
		delim = "%s"
	end

	local mode = ""
	for i = 1, #s do
		if i == 3 then
			break
		end
		mode = mode .. s:sub(i, i)
	end

	-- trim the mode
	s = s:gsub(mode, "")

	return mode, s
end

local function gitStatus()
	local f = io.popen("git status -s --porcelain", "r")

	if f == nil then
		return {}
	end

	local ret = {}

	for line in f:lines() do
		local mode, file = stringSplit(line)

		if ret[mode] == nil then
			ret[mode] = {}
		end

		table.insert(ret[mode], file)
	end

	for k in pairs(ret) do
		table.sort(ret[k], function(a, b)
			return a > b
		end)
	end

	return ret
end

-- Stolen form a spudtastic potato
local function float(width, height)
	-- Allow it to fail if the window can't be floated
	local api = vim.api
	if (#api.nvim_list_wins()) < 2 then
		print("Float() can only be used if there is more than one window")
		return -1
	end

	local ui = api.nvim_list_uis()[1]

	local quadBufHeight = api.nvim_buf_line_count(api.nvim_get_current_buf()) * 4

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

	api.nvim_win_set_config(GitPopupThing.winid, opts)
end

local function setWinOpts()
	vim.api.nvim_set_option_value("cursorline", true, { win = GitPopupThing.winid, scope = "local" })

	vim.api.nvim_set_option_value(
		"winhighlight",
		"Normal:EdgyFileTreeNormal",
		{ win = GitPopupThing.winid, scope = "local" }
	)

	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(GitPopupThing.winid, true)
	end, { buffer = GitPopupThing.buf })

	vim.keymap.set("n", "<esc>", function()
		vim.api.nvim_win_close(GitPopupThing.winid, true)
	end, { buffer = GitPopupThing.buf })

	vim.keymap.set("n", "<esc><esc>", function()
		vim.api.nvim_win_close(GitPopupThing.winid, true)
	end, { buffer = GitPopupThing.buf })

	vim.keymap.set("n", "u", function()
		local pos = vim.api.nvim_win_get_cursor(GitPopupThing.winid)
		local file = vim.trim(vim.api.nvim_buf_get_lines(GitPopupThing.buf, pos[1] - 1, pos[1], true)[1])

		vim.cmd("silent !git reset -- " .. file)

		GitPopupThing.updateUI()
	end, { buffer = GitPopupThing.buf })

	vim.keymap.set("n", "s", function()
		local pos = vim.api.nvim_win_get_cursor(GitPopupThing.winid)
		local file = vim.trim(vim.api.nvim_buf_get_lines(GitPopupThing.buf, pos[1] - 1, pos[1], true)[1])

		vim.cmd("silent !git stage " .. file)

		GitPopupThing.updateUI()
	end, { buffer = GitPopupThing.buf })

	vim.keymap.set("n", "<cr>", function()
		local pos = vim.api.nvim_win_get_cursor(GitPopupThing.winid)
		local line = vim.trim(vim.api.nvim_buf_get_lines(GitPopupThing.buf, pos[1] - 1, pos[1], true)[1])

		vim.api.nvim_win_close(GitPopupThing.winid, true)

		vim.cmd(string.format([[ edit +1 %s | Gitsigns next_hunk ]], line))
	end, { buffer = GitPopupThing.buf })
end

local function setLines(currentFile, filePos, i, t, k)
	vim.api.nvim_buf_set_lines(GitPopupThing.buf, i - 1, i - 1, true, { statusName(k) })
	vim.api.nvim_buf_add_highlight(GitPopupThing.buf, -1, statusColor(k), i - 1, 0, #statusName(k))

	for _, f in ipairs(t) do
		vim.api.nvim_buf_set_lines(GitPopupThing.buf, i, i, true, { string.format("  %s", f) })

		if vim.trim(f) == currentFile then
			filePos = { i, 0 }
		end

		i = i + 1
	end

	i = i + 1

	return filePos, i
end

local function pop(t, key)
	local new = {}
	local ret = {}

	for k, v in pairs(t) do
		if k == key then
			ret = v
		else
			new[k] = v
		end
	end

	return new, ret
end

function GitPopupThing.setBuf()
	vim.api.nvim_buf_set_option(GitPopupThing.buf, "readonly", false)
	vim.api.nvim_buf_set_option(GitPopupThing.buf, "modifiable", true)

	local currentFile = vim.fn.bufname()

	vim.api.nvim_buf_set_lines(GitPopupThing.buf, 0, -1, true, {})

	local i = 1

	local filePos = { 1, 0 }

	-- do staged, unstaged, untracked, and then remaining
	local gs = gitStatus()

	for _, k in pairs({ "M ", " M", "??" }) do
		local p = {}

		gs, p = pop(gs, k)

		filePos, i = setLines(currentFile, filePos, i, p, k)
	end

	if #gs > 0 then
		filePos, i = setLines(currentFile, filePos, i, gs)
	end

	vim.api.nvim_buf_set_option(GitPopupThing.buf, "modifiable", false)
	vim.api.nvim_buf_set_option(GitPopupThing.buf, "readonly", true)

	return filePos
end

local function split()
	vim.cmd("botright vsplit")

	GitPopupThing.winid = vim.api.nvim_get_current_win()
end

function GitPopupThing.open()
	GitPopupThing.buf = vim.api.nvim_create_buf(false, true)

	vim.bo[GitPopupThing.buf].filetype = "scratch"
	vim.bo[GitPopupThing.buf].bufhidden = "hide"
	vim.bo[GitPopupThing.buf].buftype = "nofile"

	local filePos = GitPopupThing.setBuf()

	split()

	vim.api.nvim_win_set_buf(GitPopupThing.winid, GitPopupThing.buf)

	float(50, 30)

	setWinOpts()

	vim.api.nvim_win_set_cursor(GitPopupThing.winid, filePos)
end

function GitPopupThing.updateUI()
	local pos = vim.api.nvim_win_get_cursor(GitPopupThing.winid)

	GitPopupThing.setBuf()

	setWinOpts()

	vim.api.nvim_win_set_cursor(GitPopupThing.winid, pos)
end

return GitPopupThing
