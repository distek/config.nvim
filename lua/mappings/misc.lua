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

map("n", "<A-n>", require("fnote").toggle)

-- Shift block
map("v", "<C-K>", "xkP`[V`]")
map("v", "<C-J>", "xp`[V`]")

-- Edgy
map("n", "<leader>as", function()
	require("edgy").toggle("bottom")
end, { desc = "Bottom panel" })

map("t", "<localleader>as", function()
	require("edgy").toggle("bottom")
end, { desc = "Bottom panel" })

map("n", "<leader>ad", function()
	require("edgy").toggle("left")
end, { desc = "Left panel" })

map("n", "<leader>af", function()
	require("edgy").toggle("right")
end, { desc = "Right panel" })

-- Toggleterm
map("t", "<A-Tab>", function()
	require("tt.terminal"):FocusNext()
end, { desc = "Focus next terminal" })

map("t", "<A-S-Tab>", function()
	require("tt.terminal"):FocusPrevious()
end, { desc = "Focus previous terminal" })

map("n", "<A-Tab>", function()
	if require("tt"):IsOpen() then
		require("tt.terminal"):FocusNext()
	end
end, { desc = "Focus next terminal" })

map("n", "<A-S-Tab>", function()
	if require("tt"):IsOpen() then
		require("tt.terminal"):FocusPrevious()
	end
end, { desc = "Focus previous terminal" })

map("t", "<A-a>", "<C-\\><C-n>")

-- Fuck q:
-- https://www.reddit.com/r/neovim/comments/lizyxj/how_to_get_rid_of_q/
-- won't work if you take too long to do perform the action, but that's fine
map("n", "q:", "<nop>")

vim.api.nvim_create_user_command("Q", function(args)
	Util.bdelete(false, args.bang)
end, { bang = true })
vim.api.nvim_create_user_command("Qa", function(args)
	Util.bdelete(true, args.bang)
end, { bang = true })

-- AmBiGuOuS UsE oF UsEr-dEfInEd cOmMaNd
vim.api.nvim_create_user_command("W", "w", {})

-- manual qf
map("n", "<leader>qa", "<cmd>lua Util.addToQF()<cr>", { desc = "Add line to quickfix list" })
map("n", "<leader>qd", "<cmd>lua Util.delFromQF()<cr>", { desc = "Delete line from quickfix list" })
map("n", "<leader>qo", function()
	require("edgy").toggle("top")
end, { desc = "Open quickfix list" })

map("n", "<leader>Sw", function()
	vim.ui.input({ prompt = "Session name: " }, function(input)
		if input == "" then
			return
		end

		MiniSessions.write(input)
	end)
end, { desc = "save session" })

map("n", "<leader>Ss", function()
	MiniSessions.select()
end, { desc = "select session" })

map("n", "<leader>Sd", function()
	MiniSessions.select("delete", { force = true })
end, { desc = "save session" })

map("n", "<leader>so", ":so %<cr>", { desc = "Give it the ol' shout out!" })
