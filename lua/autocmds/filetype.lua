vim.api.nvim_create_augroup("markdown", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.md" },
	callback = function()
		vim.cmd([[setlocal spell]])
	end,
	group = "markdown",
})

-- set some buffer options for helper filetypes
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = function(ev)
		local pattern = {
			"help",
			"fugitive",
			"toggleterm",
			"termlist",
			"gitcommit",
			"qf",
			"starter",
		}

		vim.print(vim.bo[ev.buf].filetype)
		if vim.tbl_get(pattern, vim.bo[ev.buf].filetype) ~= nil then
			vim.opt_local.number = false
			vim.opt_local.relativenumber = false
			vim.opt_local.list = false
			vim.opt_local.signcolumn = "no"
			vim.opt_local.statuscolumn = ""
		end
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.bo[vim.api.nvim_get_current_buf()].filetype == "starter" then
			vim.opt_local.number = false
			vim.opt_local.relativenumber = false
			vim.opt_local.list = false
			vim.opt_local.signcolumn = "no"
			vim.opt_local.statuscolumn = ""
		end
	end,
})

-- make `q` close the window for these + other ui options
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"help",
		"fugitive",
		"gitcommit",
		"qf",
	},
	callback = function()
		vim.keymap.set("n", "q", ":close<cr>", { buffer = true, silent = true })
	end,
})
