return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		views = {
			cmdline_popup = {
				border = {
					style = "shadow",
					-- padding = { 1, 2 },
				},
				win_options = {
					winhighlight = {
						Normal = "NoiceCmdLine",
					},
				},
			},
		},
		lsp = {
			progress = {
				enabled = false,
			},
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},

			documentation = {
				view = "hover",
				opts = {
					lang = "markdown",
					replace = true,
					render = "plain",
					format = { "{message}" },
					border = {
						style = "shadow",
						-- padding = { 1, 2 },
					},
					win_options = {
						concealcursor = "n",
						conceallevel = 3,
						winhighlight = {
							Normal = "NormalFloat",
						},
					},
				},
			},
		},
		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = false, -- add a border to hover docs and signature help
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
}
