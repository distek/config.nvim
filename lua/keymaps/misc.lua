local map = vim.keymap.set

map("n", "<leader>so", function()
	local ok, err = pcall(function()
		vim.api.nvim_exec2("so", { output = false })
	end)

	if not ok then
		print("Failed to source file:", vim.fn.expand("%"))
		vim.print(err)
		return
	end

	print("Sourced file:", vim.fn.expand("%"))
end, { desc = "Give it the ol' shout out" })

map("n", "<leader>cm", "<Plug>ContextCommentary", { desc = "Comment line" })
map("v", "<leader>cm", "<Plug>ContextCommentary", { desc = "Comment line(s)" })

-- Remap for dealing with word wrap
-- Allows for navigating through wrapped lines without skipping over the wrapped portion
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Better indent (re-selects last visual)
map("v", ">", "'>gv'", { expr = true, silent = true })
map("v", "<", "'<gv'", { expr = true, silent = true })
