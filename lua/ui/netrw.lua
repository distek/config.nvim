local map = vim.keymap.set

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_keepdir = 0
vim.g.netrw_hide = 0
vim.g.netrw_use_errorwindow = 1

vim.g.netrwWin = nil

if vim.g.scratchAUGroup == nil then
	vim.g.scratchAUGroup =
		vim.api.nvim_create_augroup("ScratchAutos", { clear = true })
end

vim.api.nvim_clear_autocmds({ group = "ScratchAutos" })

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = "ScratchAutos",
	callback = function(ev)
		if vim.bo[ev.buf].filetype == "netrw" then
			if vim.g.netrwWin == nil then
				return
			end

			if
				vim.api.nvim_win_is_valid(vim.g.netrwWin)
				and vim.api.nvim_win_get_buf(vim.g.netrwWin) ~= ev.buf
			then
				Util.defer(function()
					vim.cmd("b#")
					-- vim.api.nvim_buf_delete(
					-- 	ev.buf,
					-- 	{ force = true, unload = false }
					-- )
				end, 10)
			end
		end
	end,
})

vim.api.nvim_create_autocmd("WinEnter", {
	group = "ScratchAutos",
	callback = function()
		if
			vim.g.netrwWin == nil
			or not vim.api.nvim_win_is_valid(vim.g.netrwWin)
		then
			return
		end

		local height = vim.api.nvim_win_get_height(vim.g.netrwWin)

		local vimHeight = vim.o.lines - 3 -- tabline, statusline, and cmdline

		if vimHeight ~= height then
			Util.netrwToggle()
			Util.netrwToggle()
		end
	end,
})

function Util.netrwToggle()
	if vim.g.netrwWin ~= nil and vim.api.nvim_win_is_valid(vim.g.netrwWin) then
		if
			vim.bo[vim.api.nvim_win_get_buf(vim.g.netrwWin)].filetype == "netrw"
		then
			vim.cmd("Lexplore")
			vim.g.netrwWin = nil
			return
		end
	end

	local initBufs = {}
	for _, v in ipairs(vim.api.nvim_list_bufs()) do
		table.insert(initBufs, v)
	end

	vim.cmd("Lexplore")
	vim.api.nvim_win_set_width(0, 35)
	vim.g.netrwWin = vim.api.nvim_get_current_win()

	for _, v in ipairs(vim.api.nvim_list_bufs()) do
		if initBufs[v] == nil then
			if vim.bo[v].filetype == "" then
				vim.api.nvim_buf_delete(v, {})
			end
		end
	end
end
