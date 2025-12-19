local map = vim.keymap.set

-- Telescopic Johnson
map("n", "<leader>kr", require("telescope.builtin").live_grep, { desc = "Live grep" })
map("n", "<leader>kw", require("telescope.builtin").grep_string, { desc = "Grep string under cursor" })

map("n", "<leader>kF", require("telescope.builtin").find_files, { desc = "Find files" })
map("n", "<leader>kf", require("telescope.builtin").buffers, { desc = "Find buffers" })
map("n", "<leader>kh", require("telescope.builtin").help_tags, { desc = "Search help" })

map("n", "<leader>kq", require("telescope.builtin").quickfix, { desc = "Quickfix list" })
map("n", "<leader>kl", require("telescope.builtin").loclist, { desc = "Location list" })

map("n", "<leader>kk", require("telescope.builtin").resume, { desc = "Resume last" })

map("n", "<leader>aa", "<cmd>Telescope file_browser path=%:p:h hidden=true<CR>", { desc = "File browser" })
