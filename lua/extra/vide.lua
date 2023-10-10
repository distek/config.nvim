-- Remote nvim's --listen address
local ntr = require("nvim_tree_remote")

local neotree = require("neo-tree")

neotree.setup({
	sources = {
		"filesystem",
	},
	source_selector = {
		winbar = true,
		statusline = false,
	},
	filesystem = {
		follow_current_file = {
			enabled = true,
		},
		use_libuv_file_watcher = true,
		hide_dotfiles = false,
		hide_gitignore = false,
		never_show = {
			".DS_Store",
			".vscode",
		},
		commands = {
			nt_remote_vsplit = function(state)
				local node = state.tree:get_node()
				if node.type == "directory" then
					return
				end

				local socket_path = os.getenv("VIDESOCK")
				local path = vim.fn.shellescape(node:get_id(), 1)

				vim.cmd(
					"silent !nvim --server "
						.. socket_path
						.. " --remote-send '<esc>:vsplit "
						.. path
						.. "<cr>'"
				)
			end,
			nt_remote_split = function(state)
				local node = state.tree:get_node()
				if node.type == "directory" then
					return
				end

				local socket_path = os.getenv("VIDESOCK")
				local path = vim.fn.shellescape(node:get_id(), 1)

				vim.cmd(
					"silent !nvim --server "
						.. socket_path
						.. " --remote-send '<esc>:split "
						.. path
						.. "<cr>'"
				)
			end,
			nt_remote_edit = function(state)
				local node = state.tree:get_node()
				if node.type == "directory" then
					require("neo-tree.sources.filesystem.commands").toggle_node(
						state
					)
					return
				end

				local socket_path = os.getenv("VIDESOCK")
				local path = vim.fn.shellescape(node:get_id(), 1)

				vim.cmd(
					"silent !nvim --server "
						.. socket_path
						.. " --remote-send '<esc>:edit "
						.. path
						.. "<cr>'"
				)
				vim.cmd("silent !tmux select-pane -t 1")
			end,
		},
		window = {
			mappings = {
				["/"] = "filter_as_you_type",
				["<esc><esc>"] = "clear_filter",
				["v"] = "nt_remote_vsplit",
				["s"] = "nt_remote_split",
				["<CR>"] = "nt_remote_edit",
				["l"] = "nt_remote_edit",
				["q"] = "nop",
			},
		},
	},
	use_popups_for_input = false,
	open_files_do_not_replace_types = {
		"terminal",
		"Trouble",
		"qf",
		"Outline",
		"edgy",
	},
})

vim.o.statuscolumn = _G.get_statuscol({
	"sep",
	"num",
	"space",
	"lastSep",
	"clear",
})

vim.cmd("Neotree action=show source=filesystem position=current")
