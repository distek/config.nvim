return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.api.nvim_set_hl(0, "NeoTreeNormal", { link = "NormalDark" })
		vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { link = "NormalDark" })

		require("neo-tree").setup({
			sources = {
				"buffers",
				"filesystem",
			},
			source_selector = {
				winbar = false,
				statusline = false,
			},
			event_handlers = {
				{
					event = "neo_tree_buffer_enter",
					handler = function()
						vim.opt_local.statuscolumn = ""
						vim.opt_local.signcolumn = "number"
						vim.opt_local.foldcolumn = "0"
						vim.opt_local.number = true
						vim.opt_local.numberwidth = 4
						vim.opt_local.relativenumber = true
					end,
				},
			},
			default_component_configs = {
				git_status = {
					symbols = {
						-- Change type
						added = "+",
						deleted = "-",
						modified = "m",
						renamed = "r",
						-- Status type
						untracked = "?",
						ignored = ".",
						unstaged = "u",
						staged = "s",
						conflict = "!",
					},
				},
			},
			filesystem = {
				follow_current_file = {
					enabled = true,
				},
				use_libuv_file_watcher = true,
				hide_dotfiles = false,
				hide_gitignore = false,
				group_empty_dirs = true,
				never_show = {
					".DS_Store",
					".vscode",
				},
				window = {
					mappings = {
						["/"] = "filter_as_you_type",
						["<esc><esc>"] = "clear_filter",
						["d"] = function(state, callback)
							local tree = state.tree
							local node = tree:get_node()

							local _, name = require("neo-tree.utils").split_path(node.path)

							local msg = string.format("Are you sure you want to delete '%s'? [y/N]: ", name)

							vim.ui.input({ prompt = msg }, function(input)
								if input == "y" or input == "Y" then
									-- Work around for edgy
									if node.type == "file" or node.type == "directory" then
										for _, v in ipairs(vim.api.nvim_list_bufs()) do
											if vim.api.nvim_buf_get_name(v) == node.path then
												local empty = vim.api.nvim_create_buf(true, false)
												for _, w in ipairs(vim.api.nvim_list_wins()) do
													if vim.api.nvim_win_get_buf(w) == v then
														vim.api.nvim_win_set_buf(w, empty)
													end
												end
												break
											end
										end
										require("neo-tree.sources.filesystem.lib.fs_actions").delete_node(
											node.path,
											callback,
											true
										)
									else
										vim.notify("The `delete` command can only be used on files and directories")
									end
								end
							end)
						end,
					},
				},
			},
			buffers = {
				follow_current_file = {
					enabled = true,
				},
				window = {
					mappings = {
						["/"] = "filter_as_you_type",
						["<esc><esc>"] = "clear_filter",
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
	end,
}
