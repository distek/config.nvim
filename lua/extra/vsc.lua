vim.cmd([[filetype off]])

vim.backspace = { "indent", "eol", "start" }
vim.o.clipboard = "unnamedplus"
vim.cmd([[filetype plugin indent on]])
vim.o.ignorecase = true
vim.o.inccommand = "nosplit"
vim.o.smartcase = true
vim.o.startofline = false

vim.o.swapfile = false
vim.o.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.o.undofile = true

local map = vim.keymap.set

local exmap = function(mode, keys, command)
	vim.api.nvim_set_keymap(
		mode,
		keys,
		command,
		{ noremap = true, expr = true, silent = true }
	)
end

exmap("n", "k", "v:count == 0 ? 'gk' : 'k'")
exmap("n", "j", "v:count == 0 ? 'gj' : 'j'")

exmap("v", ">", "'>gv'")
exmap("v", "<", "'<gv'")

exmap("n", "<C-d>", "'<C-d>zz'")
exmap("n", "<C-u>", "'<C-u>zz'")

map("n", "<Esc><Esc>", ":nohl<CR>", { silent = true })

map("n", "<Space>", "<cmd>call VSCodeNotify('whichkey.show')<cr>")
map("v", "<Space>", "<cmd>call VSCodeNotify('whichkey.show')<cr>")
map("x", "<Space>", "<cmd>call VSCodeNotify('whichkey.show')<cr>")

-- map("v", "<leader>cm", "<Plug>VSCodeCommentarygv<Esc>")
-- map("n", "<leader>cm", "<Plug>VSCodeCommentaryLine<Esc>")
