local map = vim.keymap.set

-- Remap for dealing with word wrap
-- Allows for navigating through wrapped lines without skipping over the wrapped portion
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Better indent (re-selects last visual)
map("v", ">", "'>gv'", { expr = true, silent = true })
map("v", "<", "'<gv'", { expr = true, silent = true })

-- Easy-to-smash nohl
map("n", "<Esc><Esc>", ":nohl<CR>", { silent = true })

-- Better incsearch
map("n", "n", "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>")
map("n", "N", "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>")

-- focus tabpages
map("n", "<leader><Tab>", ":tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><S-Tab>", ":tabprevious<cr>", { desc = "Previous Tab" })

-- Commentary
map("n", "<leader>cm", "<Plug>ContextCommentary", { desc = "Comment line" })
map("v", "<leader>cm", "<Plug>ContextCommentary", { desc = "Comment line(s)" })

-- Telescope file browser
map("n", "<leader>aa", "<cmd>Telescope file_browser path=%:p:h hidden=true<CR>", { desc = "File browser" })

-- neo-tree
map("n", "<leader>ad", "<cmd>Neotree toggle<CR>", { desc = "Toggle explorer panel" })

map("n", "<leader>af", "<cmd>SymbolsOutline<CR>", { desc = "Toggle outline panel" })

-- refactoring.nvim
map(
	"v",
	"<leader>re",
	[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
	{ desc = "Extract function" }
)
map(
	"v",
	"<leader>rf",
	[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
	{ desc = "Extract function to file" }
)
map(
	"v",
	"<leader>rv",
	[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
	{ desc = "Extract variable" }
)
map(
	"v",
	"<leader>ri",
	[[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
	{ desc = "Inline variable" }
)
map(
	"n",
	"<leader>ri",
	[[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
	{ desc = "Inline variable" }
)
map("n", "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], { desc = "Extract block" })
map(
	"n",
	"<leader>rbf",
	[[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
	{ desc = "Extract block to file" }
)

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

map("n", "<A-n>", require("fnote").toggle)

-- Shift block
map("v", "<C-K>", "xkP`[V`]")
map("v", "<C-J>", "xp`[V`]")

-- Fuck q:
-- https://www.reddit.com/r/neovim/comments/lizyxj/how_to_get_rid_of_q/
-- wont work if you take too long to do perform the action, but that's fine
map("n", "q:", "<nop>")

vim.api.nvim_create_user_command("Q", function(args)
	Util.bdelete(false, args.bang)
end, { bang = true })
vim.api.nvim_create_user_command("Qa", function(args)
	Util.bdelete(true, args.bang)
end, { bang = true })

-- AmBiGuOuS UsE oF UsEr-dEfInEd cOmMaNd
vim.api.nvim_create_user_command("W", "w", {})
