BufStack = {}

vim.api.nvim_create_autocmd({ "BufDelete" }, {
	pattern = "*",
	callback = function(ev)
		local name = vim.api.nvim_buf_get_name(ev.buf)

		if name == "" then
			return
		end

		for i, v in ipairs(BufStack) do
			if name == v then
				table.remove(BufStack, i)
				break
			end
		end

		table.insert(BufStack, name)
		if #BufStack > 10 then
			table.remove(BufStack, 1)
		end
	end,
})
