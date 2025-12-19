local map = vim.keymap.set

map("n", "<leader>lD", function()
	vim.cmd("mark D")
	vim.cmd("Telescope lsp_definitions")
end, { desc = "Peek definition" })
map("n", "<leader>lsD", function()
	vim.cmd("split")
	vim.cmd("Telescope lsp_definitions")
end, { desc = "Peek definition split" })
map("n", "<leader>lsd", function()
	vim.cmd("vsplit")
	vim.cmd("Telescope lsp_definitions")
end, { desc = "Peek definition vsplit" })

map("n", "<leader>ld", vim.lsp.buf.hover, { desc = "Hover Definition" })

map("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", { desc = "Peek References" })
map("n", "<leader>lo", vim.diagnostic.open_float, { desc = "Show diagnostics" })
map("n", "<leader>lh", vim.diagnostic.goto_prev, { desc = "Next diagnostic" })
map("n", "<leader>ll", vim.diagnostic.goto_next, { desc = "Prev diagnostic" })
map("n", "<leader>ln", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })

-- Meta LSP stuff
map("n", "<leader>Li", "<cmd>Mason<CR>", { desc = "Mason" })
map("n", "<leader>Lr", "<cmd>LspRestart<CR>", { desc = "Restart LSP" })
map("n", "<leader>Ls", "<cmd>LspStart<CR>", { desc = "Start LSP" })
map("n", "<leader>LS", "<cmd>LspStop<CR>", { desc = "Stop LSP" })

map("n", "<leader>at", function()
	require("trouble").open({ mode = "diagnostics" })
end, { desc = "Trouble" })
