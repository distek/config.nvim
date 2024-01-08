return function()
	local toys = require("tabline_framework.toys")

	toys.setup_tab_buffers()

	local getIcon = function(f, info)
		if info.filename == nil then
			return ""
		end

		local color = f.icon_color(info.filename)

		return "%#"
			.. color
			.. "#"
			.. f.icon(info.filename)
			.. "%#BufferCurrent#"
	end

	local neoTreeInfo = function()
		local winid =
			require("neo-tree.sources.manager").get_state("filesystem").winid
		if winid == nil then
			return false, 0
		end

		local valid = vim.api.nvim_win_is_valid(winid)

		if valid then
			return true, vim.api.nvim_win_get_width(winid)
		end

		return false, 0
	end

	-- vim.api.nvim_create_autocmd("FileType", {
	-- 	pattern = "neo-tree",
	-- 	callback = function(tbl)
	-- 		local set_offset = require("bufferline.api").set_offset

	-- 		local bufwinid
	-- 		local last_width
	-- 		local autocmd = vim.api.nvim_create_autocmd("WinScrolled", {
	-- 			callback = function()
	-- 				bufwinid = bufwinid or vim.fn.bufwinid(tbl.buf)

	-- 				if not vim.api.nvim_win_is_valid(bufwinid) then
	-- 					set_offset(8, "Neovim")
	-- 					return
	-- 				end

	-- 				ntWidth = vim.api.nvim_win_get_width(bufwinid)

	-- 			end,
	-- 		})

	-- 		vim.api.nvim_create_autocmd("BufWipeout", {
	-- 			buffer = tbl.buf,
	-- 			callback = function()
	-- 				vim.api.nvim_del_autocmd(autocmd)
	-- 				set_offset(0)
	-- 			end,
	-- 			once = true,
	-- 		})
	-- 	end,
	-- })

	local render = function(f)
		local ntOpen, ntWidth = neoTreeInfo()

		f.add("%#BufferOffset# Neovim ")

		if ntOpen then
			local pad = "%#BufferOffset#"

			for i = 0, ntWidth - 9, 1 do
				pad = pad .. " "
			end

			pad = pad .. "%#BufferFill#┃"
			f.add(pad)
		end

		f.make_bufs(function(info)
			local visible = false

			if not info.current then
				for _, v in ipairs(vim.api.nvim_list_wins()) do
					if vim.api.nvim_win_get_buf(v) == info.buf then
						visible = true
						break
					end
				end
			end

			local hlFG = ""
			local hlBG = ""
			if info.current == true then
				hlFG = Util.getColor("BufferCurrent", "fg")
				hlBG = Util.getColor("BufferCurrent", "bg")
			elseif visible then
				hlFG = Util.getColor("BufferVisible", "fg")
				hlBG = Util.getColor("BufferVisible", "bg")
			else
				hlFG = Util.getColor("BufferInactive", "fg")
				hlBG = Util.getColor("BufferInactive", "bg")
			end

			f.set_fg(hlFG)
			f.set_bg(hlBG)

			f.add("%" .. info.buf .. "@v:lua.Util.bufSelect@")

			f.add("▎ ")

			if info.filename ~= nil then
				f.add({
					" " .. f.icon(info.filename) .. " ",
					fg = info.current and f.icon_color(info.filename) or nil,
				})
			end

			f.add(info.filename or "-empty-")

			f.add(info.modified and " + ")

			f.add("%X%" .. info.buf .. "@v:lua.Util.bufClose@  %X")
		end, toys.get_tab_buffers(0))

		f.add("%#BufferFill#")

		f.add_spacer()

		f.make_tabs(function(info)
			local name = Util.getTabName(info.index)
			if name == nil then
				f.add(" " .. info.index .. " ")
			else
				f.add(" " .. info.index .. " " .. name .. " ")
			end
		end)
	end

	require("tabline_framework").setup({ render = render })
end
