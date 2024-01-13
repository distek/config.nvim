local map = vim.keymap.set

-- Remap for dealing with word wrap
-- Allows for navigating through wrapped lines without skipping over the wrapped portion
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Better indent (re-selects last visual)
map("v", ">", "'>gv'", { expr = true, silent = true })
map("v", "<", "'<gv'", { expr = true, silent = true })

-- Easy-to-smash nohl
map("n", "<Esc><Esc>", function()
	vim.cmd("nohl")

	-- local edgyList = {}

	-- local edgyWins = require("edgy.editor").list_wins()
	-- for _, v in ipairs(edgyWins.edgy) do
	-- 	local w = require("edgy").get_win(v)

	-- 	if w.visible then
	-- 		table.insert(edgyList, w.view.edgebar.pos)

	-- 		require("edgy").close(w.view.edgebar.pos)
	-- 	end
	-- end

	-- vim.cmd("set cmdheight=1")
	-- vim.cmd("resize")

	-- for _, w in pairs(edgyList) do
	-- 	local bar = w.view.edgebar

	-- 	if w.visible then
	-- 		require("edgy").open(bar.pos)
	-- 	end
	-- end
end, { silent = true })

-- Better incsearch
map(
	"n",
	"n",
	"<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>"
)
map(
	"n",
	"N",
	"<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>"
)

-- focus tabpages
map("n", "<leader><Tab>", ":tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><S-Tab>", ":tabprevious<cr>", { desc = "Previous Tab" })

-- Commentary
map("n", "<leader>cm", "<Plug>ContextCommentary", { desc = "Comment line" })
map("v", "<leader>cm", "<Plug>ContextCommentary", { desc = "Comment line(s)" })

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
map(
	"n",
	"<leader>rb",
	[[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
	{ desc = "Extract block" }
)
map(
	"n",
	"<leader>rbf",
	[[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
	{ desc = "Extract block to file" }
)

NotesLastView = ""

local function toggleNotes()
	local panel = require("panel")
	if panel.isOpen() then
		if panel.currentView == "Notes" then
			if NotesLastView ~= "" then
				panel.open({ name = NotesLastView, focus = true })
			end
		else
			NotesLastView = panel.currentView
			panel.open({ name = "Notes", focus = true })
		end
	else
		panel.open({ name = "Notes", focus = true })
	end
end

map("n", "<A-n>", toggleNotes)
map("t", "<A-n>", toggleNotes)

-- Shift block
map("v", "<C-K>", "xkP`[V`]")
map("v", "<C-J>", "xp`[V`]")

map("t", "<A-z>", "<C-\\><C-n>")

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
map(
	"n",
	"<leader>qa",
	"<cmd>lua Util.addToQF()<cr>",
	{ desc = "Add line to quickfix list" }
)
map(
	"n",
	"<leader>qd",
	"<cmd>lua Util.delFromQF()<cr>",
	{ desc = "Delete line from quickfix list" }
)
map("n", "<leader>qo", function()
	vim.cmd("copen")
end, { desc = "Open quickfix list" })

-- map("n", "<leader>Ss", require("resession").save_tab, { desc = "save session" })

-- map("n", "<leader>Sl", require("resession").load, { desc = "select session" })

-- map("n", "<leader>Sd", require("resession").delete, { desc = "save session" })

map("n", "<leader>so", ":so %<cr>", { desc = "Give it the ol' shout out!" })

vim.keymap.set("n", "<leader>tr", function()
	Util.setTabName()
end)

vim.keymap.set("n", "<leader>tn", function()
	vim.cmd("tabnew")

	Util.setTabName()
end)

vim.keymap.set("n", "<leader>tq", function()
	vim.cmd("tabclose")
end)
