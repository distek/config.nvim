-- links
local map = vim.keymap.set

if vim.loop.os_uname().sysname == "Darwin" then
	map("n", "gx", 'yiW:!open <C-R>"<CR><Esc>')
elseif vim.loop.os_uname().sysname == "Linux" then
	map("n", "gx", 'yiW:!xdg-open <C-R>"<CR><Esc>')
end

-- Remap for dealing with word wrap
-- Allows for navigating through wrapped lines without skipping over the wrapped portion
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

map("v", ">", "'>gv'", { expr = true, silent = true })
map("v", "<", "'<gv'", { expr = true, silent = true })

map("n", "<Esc><Esc>", ":nohl<CR>", { silent = true })

-- Better incsearch
map("n", "n", "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>")
map("n", "N", "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>")

-- focus tabpages
map("n", "<leader><Tab>", ":tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><S-Tab>", ":tabprevious<cr>", { desc = "Previous Tab" })

-- focus buffers
map("n", "<Tab>", function()
	Util.skipUnwantedBuffers("next")
end)
map("n", "<S-Tab>", function()
	Util.skipUnwantedBuffers("prev")
end)

-- move buffers
map("n", "<A-Tab>", function()
	require("bufferline").move(1)
end)
map("n", "<A-S-Tab>", function()
	require("bufferline").move(-1)
end)

-- Window/buffer stuff
map("n", "<leader>ss", "<cmd>split<cr>", { desc = "Split horizontal" })
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split Vertical" })

-- Split Terminal
map("n", "<leader>stv", "<cmd>vsplit term://" .. vim.o.shell .. "<CR>", { desc = "Vertical Term" })
map("n", "<leader>sts", "<cmd>split term://" .. vim.o.shell .. "<CR>", { desc = "Horizontal Term" })

-- Term escape
map("t", "<A-z>", "<c-\\><c-n>")
map("t", "<A-Tab>", TF.NextTerm)
map("t", "<A-S-Tab>", TF.PrevTerm)

-- Close window(split)
map("n", "<A-q>", "<cmd>lua require('bufdelete').bufdelete(0, true)<CR>")

-- Delete buffer
map("n", "<A-S-q>", function()
	local compCount, winCount = Util.compVsWinCount()

	if winCount - 1 == compCount then
		vim.notify("Cannot close last editor window")
		return
	end

	vim.cmd("wincmd c")
end)

-- Window movement
map("n", "<A-S-h>", "<cmd>WinShift left<cr>")
map("n", "<A-S-j>", "<cmd>WinShift down<cr>")
map("n", "<A-S-k>", "<cmd>WinShift up<cr>")
map("n", "<A-S-l>", "<cmd>WinShift right<cr>")

-- Navigate windows/panes incl. tmux
map("n", "<A-j>", function()
	Util.win_focus("down")
end)
map("n", "<A-k>", function()
	Util.win_focus("up")
end)
map("n", "<A-l>", function()
	Util.win_focus("right")
end)
map("n", "<A-h>", function()
	Util.win_focus("left")
end)

map("v", "<A-j>", function()
	Util.win_focus("down")
end)
map("v", "<A-k>", function()
	Util.win_focus("up")
end)
map("v", "<A-l>", function()
	Util.win_focus("right")
end)
map("v", "<A-h>", function()
	Util.win_focus("left")
end)

map("t", "<A-j>", function()
	Util.win_focus("down")
end)
map("t", "<A-k>", function()
	Util.win_focus("up")
end)
map("t", "<A-l>", function()
	Util.win_focus("right")
end)
map("t", "<A-h>", function()
	Util.win_focus("left")
end)

map("n", "<A-C-j>", function()
	Util.win_resize("bottom")
end)
map("n", "<M-NL>", function()
	Util.win_resize("bottom")
end)
map("n", "<A-C-k>", function()
	Util.win_resize("top")
end)
map("n", "<M-C-K>", function()
	Util.win_resize("top")
end)
map("n", "<A-C-l>", function()
	Util.win_resize("right")
end)
map("n", "<A-C-h>", function()
	Util.win_resize("left")
end)

map("v", "<A-C-j>", function()
	Util.win_resize("bottom")
end)
map("v", "<A-C-k>", function()
	Util.win_resize("top")
end)
map("v", "<A-C-l>", function()
	Util.win_resize("right")
end)
map("v", "<A-C-h>", function()
	Util.win_resize("left")
end)

map("t", "<A-C-j>", function()
	Util.win_resize("bottom")
end)
map("t", "<A-C-k>", function()
	Util.win_resize("top")
end)
map("t", "<A-C-l>", function()
	Util.win_resize("right")
end)
map("t", "<A-C-h>", function()
	Util.win_resize("left")
end)

-- Plugin maps

-- Zen
map("n", "<leader>z", ":ZenMode<cr>", { desc = "Zen mode" })

map("n", "<leader>f", function()
	require("zen-mode").toggle({
		window = {
			width = 1.0,
		},
	})
end, { desc = "Fullscreen window" })

local termFullscreen = function()
	-- an error about entering normal mode from terminal mode happens here but it's
	-- non-blocking so fuk it I guess
	local keys = vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true)
	vim.api.nvim_feedkeys(keys, "t", false)

	require("zen-mode").toggle({
		window = {
			width = 1.0,
		},
		options = {
			signcolumn = "no", -- disable signcolumn
			statuscolumn = "", -- disable signcolumn
			number = false, -- disable number column
			relativenumber = false, -- disable relative numbers
			cursorline = false, -- disable cursorline
			cursorcolumn = false, -- disable cursor column
			list = false, -- disable whitespace characters
		},
	})

	vim.api.nvim_feedkeys("i", "n", false)
	TF.UpdateWinbar()
end

map("t", "<localleader>f", termFullscreen, { desc = "Fullscreen window" })
map("n", "<localleader>f", termFullscreen, { desc = "Fullscreen window" })

-- Commentary
map("n", "<leader>cm", "<Plug>ContextCommentary", { desc = "Comment line" })
map("v", "<leader>cm", "<Plug>ContextCommentary", { desc = "Comment line(s)" })

-- nvim-tree
map("n", "<leader>aa", "<cmd>Telescope file_browser path=%:p:h hidden=true<CR>", { desc = "File browser" })

-- Term is set in terminal.lua
map("n", "<leader>as", TermToggle, { desc = "Toggle terminal" })
map("t", "<localleader>as", TermToggle, { desc = "Toggle terminal" })
map("n", "<M-CR>", TermNew, { desc = "Create new terminal" })
map("t", "<M-CR>", TermNew, { desc = "Create new terminal" })
map("t", "<M-q>", TF.DeleteCurrentTerm, { desc = "Create new terminal" })
map("t", "<M-r>", TF.RenameTerm, { desc = "Create new terminal" })
map("t", "<M-Tab>", TF.NextTerm, { desc = "Next terminal" })
map("t", "<M-S-Tab>", TF.PrevTerm, { desc = "Previous terminal" })

map("n", "<leader>ad", "<cmd>Neotree toggle<CR>", { desc = "Toggle explorer panel" })
map("t", "<localleader>ad", "<cmd>Neotree toggle<CR>", { desc = "Toggle explorer panel" })

map("n", "<leader>af", "<cmd>SymbolsOutline<CR>", { desc = "Toggle outline panel" })

-- LSP
map("n", "<leader>lD", "<Cmd>Glance definitions<CR>", { desc = "Peek definition" })
map("n", "<leader>ld", vim.lsp.buf.hover, { desc = "Hover Definition" })
map("n", "<leader>lr", "<cmd>Glance references<cr>", { desc = "Peek References" })
map("n", "<leader>lo", vim.diagnostic.open_float, { desc = "Show diagnostics" })
map("n", "<leader>lh", vim.diagnostic.goto_prev, { desc = "Next diagnostic" })
map("n", "<leader>ll", vim.diagnostic.goto_next, { desc = "Prev diagnostic" })
map("n", "<leader>ln", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })

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

map("n", "<leader>ks", TF.PickTerm, { desc = "Find terminal" })

-- Debug maps
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

-- Meta LSP stuff
map("n", "<leader>Li", "<cmd>Mason<CR>", { desc = "Mason" })
map("n", "<leader>Lr", "<cmd>LspRestart<CR>", { desc = "Restart LSP" })
map("n", "<leader>Ls", "<cmd>LspStart<CR>", { desc = "Start LSP" })
map("n", "<leader>LS", "<cmd>LspStop<CR>", { desc = "Stop LSP" })

-- Fugitive
map("n", "<leader>gg", "<cmd>vert Git<cr>", { desc = "Git stage" })
map("n", "<leader>gc", "<cmd>Git commit<cr>", { desc = "Git commit" })
map("n", "<leader>gp", "<cmd>Git push<cr>", { desc = "Git push" })
map("n", "<leader>gl", "<cmd>Gclog<cr>", { desc = "Git commit log" })

-- gitsigns
map("v", "<leader>gs", ":Gitsigns stage_hunk<cr>", { desc = "Stage hunk" })
map("v", "<leader>gu", ":Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })

-- Sessions
map("n", "<leader>Ss", require("sessions").saveSession, { desc = "Save session" })
map("n", "<leader>Sl", require("sessions").selectSession, { desc = "Load session" })
map("n", "<leader>Sd", require("sessions").deleteSession, { desc = "Delete session" })

-- Shift block
map("v", "<C-K>", "xkP`[V`]")
map("v", "<C-J>", "xp`[V`]")

map("n", "<A-Space>", "<cmd>Telescope command_palette<CR>")

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
