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

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "qf" },
-- 	callback = function()
-- 		vim.o.buflisted = false
-- 	end,
-- 	group = "qf",
-- })

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

-- vim.api.nvim_create_autocmd({ "WinClosed" }, {
-- 	pattern = { "*" },
-- 	callback = function()
-- 		vim.defer_fn(function()
-- 			require("tint").refresh()
-- 		end, 1)
-- 	end,
-- })

-- vim.api.nvim_create_autocmd("WinClosed", {
-- 	pattern = { "*" },
-- 	callback = function(ev)
-- 		local f = tonumber(ev.file)

-- 		if type(f) ~= "number" then
-- 			return
-- 		end

-- 		local edgyList = {}

-- 		local edgyWins = require("edgy.editor").list_wins()
-- 		for _, v in pairs(edgyWins.edgy) do
-- 			if v == f then
-- 				-- is an edgy window, it's fine if it closes
-- 				return
-- 			end
-- 		end

-- 		if vim.api.nvim_win_is_valid(f) and vim.api.nvim_win_get_config(f).relative ~= "" then
-- 			return
-- 		end

-- 		local count = 0

-- 		for _ in pairs(edgyWins.main) do
-- 			count = count + 1
-- 		end

-- 		print(count)

-- 		if count > 1 then
-- 			return
-- 		end

-- 		for _, v in ipairs(edgyWins.edgy) do
-- 			local w = require("edgy").get_win(v)

-- 			if w.visible then
-- 				table.insert(edgyList, w.view.edgebar.pos)

-- 				require("edgy").close(w.view.edgebar.pos)
-- 			end
-- 		end

-- 		local foundABuf = false
-- 		for _, v in ipairs(vim.api.nvim_list_bufs()) do
-- 			if vim.bo[v].buflisted then
-- 				foundABuf = true
-- 				vim.cmd("vsplit #" .. v)
-- 				break
-- 			end
-- 		end

-- 		if not foundABuf then
-- 			vim.cmd("vsplit +enew")
-- 		end

-- 		vim.defer_fn(function()
-- 			for _, w in pairs(edgyList) do
-- 				local bar = w.view.edgebar

-- 				if w.visible then
-- 					require("edgy").open(bar.pos)
-- 				end
-- 			end

-- 			vim.cmd("set cmdheight=1")
-- 		end, 1)
-- 	end,
-- })

vim.api.nvim_create_autocmd("FileType", {
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
	pattern = "neo-tree", -- or any other filetree's `ft`
})

BufStack = {}

vim.api.nvim_create_autocmd({ "BufDelete" }, {
	pattern = "*",
	callback = function(ev)
		local name = vim.api.nvim_buf_get_name(ev.buf)

		if name == "" then
			return
		end

		for _, v in ipairs(BufStack) do
			if name == v then
				return
			end
		end

		table.insert(BufStack, name)
		if #BufStack > 5 then
			table.remove(BufStack, 1)
		end
	end,
})
