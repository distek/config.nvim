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

-- Deal with quickfix
-- set nobuflisted and close if last window
vim.api.nvim_create_augroup("qf", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf" },
	callback = function()
		vim.o.buflisted = false
	end,
	group = "qf",
})

vim.api.nvim_create_autocmd("WinEnter", {
	pattern = { "*" },
	callback = function()
		if vim.fn.winnr("$") == 1 and vim.bo.buftype == "quickfix" then
			vim.cmd([[q]])
		end
	end,
	group = "qf",
})

-- Remove cursorline in insert mode
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	pattern = { "*" },
	callback = function()
		vim.o.cursorline = true
	end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
	pattern = { "*" },
	callback = function()
		vim.o.cursorline = false
	end,
})

-- local function doDim()
-- 	local current = vim.api.nvim_get_current_win()

-- 	local function specialWin(ft)
-- 		local list = {
-- 			["qf"] = "EdgyQuickfixNormal",
-- 			["toggleterm"] = "EdgyTermNormal",
-- 			["termlist"] = "EdgyTermListNormal",
-- 			["help"] = "EdgyHelpNormal",
-- 			["neo-tree"] = "EdgyFileTreeNormal",
-- 		}

-- 		for k, v in pairs(list) do
-- 			if k == ft then
-- 				return v
-- 			end
-- 		end
-- 		return "Normal"
-- 	end

-- 	local darken = Lush.Normal.darken(10)

-- 	vim.api.nvim_set_hl(0, "NormalDim", { bg = darken.hex })

-- 	for _, v in ipairs(vim.api.nvim_list_wins()) do
-- 		if v ~= current then
-- 			vim.api.nvim_set_option_value(
-- 				"winhighlight",
-- 				"Normal:" .. specialWin(vim.bo[vim.api.nvim_get_current_buf()].filetype),
-- 				{ win = v, scope = "local" }
-- 			)
-- 			goto continue
-- 		end

-- 		vim.api.nvim_set_option_value(
-- 			"winhighlight",
-- 			"Normal:" .. specialWin(vim.bo[vim.api.nvim_win_get_buf(v)].filetype),
-- 			{ win = v, scope = "local" }
-- 		)
-- 		::continue::
-- 	end
-- end

-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
-- 	callback = function(ev)
-- 		doDim()
-- 	end,
-- })

-- vim.api.nvim_create_autocmd({ "WinEnter" }, {
-- 	callback = function(ev)
-- 		doDim()
-- 	end,
-- })
