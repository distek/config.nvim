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

map("n", "<leader>ha", function()
	require("harpoon"):list():add()
end)

map("n", "<leader>hh", function()
	require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
end)

map("n", "<C-h>", function()
	require("harpoon"):list():select(1)
end)

map("n", "<C-j>", function()
	require("harpoon"):list():select(2)
end)

map("n", "<C-k>", function()
	require("harpoon"):list():select(3)
end)

map("n", "<C-l>", function()
	require("harpoon"):list():select(4)
end)

vim.api.nvim_create_user_command("W", "w", { bang = true })

if vim.g.notes then
	map("n", "<CR>", function()
		local ts_utils = require("nvim-treesitter.ts_utils")
		local node = ts_utils.get_node_at_cursor()

		while node do
			if node:type() == "shortcut_link" then
				local text = vim.treesitter.get_node_text(node, 0)
				-- Remove [[ and ]]
				text = text:sub(2, -3)
				-- Get part before pipe
				local file_path = text:match("^([^|]+)")

				if file_path then
					file_path = file_path:match("^%s*(.-)%s*$")
					if not file_path:match("%.%w+$") then
						file_path = file_path .. ".md"
					end
					vim.print(vim.fn.fnameescape(file_path))
					vim.cmd("edit " .. vim.fn.fnameescape(file_path))
					return
				end
			end
			node = node:parent()
		end

		print("No markdown link found under cursor")
	end)
end

map("n", "<leader>sj", require("sibling-swap").swap_with_right, { desc = "Swap parameter under cursor with next" })
map("n", "<leader>sf", require("sibling-swap").swap_with_left, { desc = "Swap parameter under cursor with previous" })

map("v", "<leader>qa", Util.AddVisualSelectionToQuickfix, { desc = "Add visual selection to Quickfix List" })
