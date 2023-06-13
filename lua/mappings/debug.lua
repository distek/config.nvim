local map = vim.keymap.set

map("n", "<leader>db", require("dap").toggle_breakpoint, { desc = "Toggle breakpoint" })
map("n", "<leader>di", require("dap").step_into, { desc = "Step into" })
map("n", "<leader>dn", require("dap").step_over, { desc = "Step over" })
map("n", "<leader>do", require("dap").step_out, { desc = "Step out" })
map("n", "<leader>du", require("dap").up, { desc = "Up" })
map("n", "<leader>dd", require("dap").down, { desc = "Down" })
map("n", "<leader>drn", require("dap").run_to_cursor, { desc = "Run to cursor" })
map("n", "<leader>dc", require("dap").continue, { desc = "Continue" })
map("n", "<leader>ds", Util.dapStart, { desc = "Start Debug" })
map("n", "<leader>dS", Util.dapStop, { desc = "Stop Debug" })
