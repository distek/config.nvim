local map = vim.keymap.set

map("n", "<leader>so", "<cmd>so<cr>", { desc = "Give it the ol' shout out" })

map("n", "<leader>cm", "<Plug>ContextCommentary", { desc = "Comment line" })
map("v", "<leader>cm", "<Plug>ContextCommentary", { desc = "Comment line(s)" })
