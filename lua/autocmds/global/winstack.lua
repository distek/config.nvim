WinStack = {}

vim.api.nvim_create_autocmd({ "WinLeave" }, {
	pattern = "*",
	callback = function(ev)
		local winid = tonumber(ev.id)
		for i, v in ipairs(WinStack) do
			if winid == v then
				table.remove(WinStack, i)
				break
			end
		end

		table.insert(WinStack, winid)
		if #WinStack > 10 then
			table.remove(WinStack, 1)
		end
	end,
})
