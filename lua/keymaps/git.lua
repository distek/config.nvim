local map = vim.keymap.set

-- Git
map("n", "<leader>gg", "<cmd>vert Git<cr>", { desc = "Git stage" })
map("n", "<leader>gc", "<cmd>Git commit<cr>", { desc = "Git commit" })
map("n", "<leader>gp", "<cmd>Git push<cr>", { desc = "Git push" })
map("n", "<leader>gs", ":Gitsigns stage_hunk<cr>", { desc = "Stage hunk under cursor" })
map("n", "<leader>gu", ":Gitsigns reset_hunk<cr>", { desc = "Reset hunk under cursor" })

map("n", "<leader>gl", ":Gitsigns next_hunk<cr>", { desc = "Next hunk" })
map("n", "<leader>gh", ":Gitsigns next_hunk<cr>", { desc = "Previous hunk" })

-- gitsigns
map("v", "<leader>gs", ":Gitsigns stage_hunk<cr>", { desc = "Stage hunk" })
map("v", "<leader>gu", ":Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })

map("n", "<leader>gj", ":diffget //3<cr>", { silent = true })
map("n", "<leader>gf", ":diffget //2<cr>", { silent = true })

map("n", "<leader>gwts", function()
	require("telescope").extensions.git_worktree.git_worktree()
end, { desc = "Git work trees switch" })

map("n", "<leader>gwtc", function()
	require("telescope").extensions.git_worktree.create_git_worktree()
end, { desc = "Git work trees create" })
