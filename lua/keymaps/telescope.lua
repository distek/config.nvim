local map = vim.keymap.set

-- Telescopic Johnson
map("n", "<leader>kr", "<cmd> lua require('telescope.builtin').live_grep()<cr>", { desc = "Live grep" })
map(
	"n",
	"<leader>kw",
	"<cmd> lua require('telescope.builtin').grep_string()<cr>",
	{ desc = "Grep string under cursor" }
)

map("n", "<leader>kF", "<cmd> lua require('telescope.builtin').find_files()<cr>", { desc = "Find files" })
map("n", "<leader>kf", "<cmd> lua require('telescope.builtin').buffers()<cr>", { desc = "Find buffers" })
map("n", "<leader>kh", "<cmd> lua require('telescope.builtin').help_tags()<cr>", { desc = "Search help" })

map("n", "<leader>kq", "<cmd> lua require('telescope.builtin').quickfix()<cr>", { desc = "Quickfix list" })
map("n", "<leader>kl", "<cmd> lua require('telescope.builtin').loclist()<cr>", { desc = "Location list" })

map("n", "<leader>kk", "<cmd> lua require('telescope.builtin').resume()<cr>", { desc = "Resume last" })

map("n", "<leader>aa", "<cmd>Telescope file_browser path=%:p:h hidden=true<CR>", { desc = "File browser" })
