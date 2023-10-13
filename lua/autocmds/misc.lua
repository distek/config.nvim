-- Return to previous line in fileauto
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = { "*" },
	callback = function()
		local line = vim.fn.line

		if line("'\"") > 0 and line("'\"") <= line("$") then
			vim.cmd("normal! g`\"zvzz'")
		end
	end,
})

vim.api.nvim_create_augroup("qf", { clear = true })

-- Remove cursorline in insert mode
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	pattern = { "*" },
	callback = function(ev)
		local fts =
			{ "qf", "neo-tree", "neotest-summary", "Outline", "Trouble" }
		for _, v in ipairs(fts) do
			if vim.bo[ev.buf].filetype == v then
				return
			end
		end
		vim.o.cursorline = true
	end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
	pattern = { "*" },
	callback = function(ev)
		local fts =
			{ "qf", "neo-tree", "neotest-summary", "Outline", "Trouble" }
		for _, v in ipairs(fts) do
			if vim.bo[ev.buf].filetype == v then
				return
			end
		end
		vim.o.cursorline = false
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "neo-tree",
	callback = function(tbl)
		local set_offset = require("bufferline.api").set_offset

		local bufwinid
		local last_width
		local autocmd = vim.api.nvim_create_autocmd("WinScrolled", {
			callback = function()
				bufwinid = bufwinid or vim.fn.bufwinid(tbl.buf)

				if not vim.api.nvim_win_is_valid(bufwinid) then
					set_offset(8, "Neovim")
					return
				end

				local width = vim.api.nvim_win_get_width(bufwinid)

				if last_width ~= width then
					set_offset(width, "Neovim")
				end
			end,
		})

		vim.api.nvim_create_autocmd("BufWipeout", {
			buffer = tbl.buf,
			callback = function()
				vim.api.nvim_del_autocmd(autocmd)
				set_offset(0)
			end,
			once = true,
		})
	end,
})
