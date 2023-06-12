return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "|", right = "|" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {},
					always_divide_middle = true,
					globalstatus = true,
				},
				sections = {
					lualine_a = {
						{
							function()
								return "▊"
							end,
							padding = { left = 0, right = 0 },
							color = function()
								local utils = require("lualine.utils.utils")

								-- auto change color according to neovims mode
								local colors = {
									normal = utils.extract_color_from_hllist("fg", { "Function" }, "#000000"),
									insert = utils.extract_color_from_hllist("fg", { "String", "MoreMsg" }, "#000000"),
									replace = utils.extract_color_from_hllist("fg", { "Number", "Type" }, "#000000"),
									visual = utils.extract_color_from_hllist(
										"fg",
										{ "Special", "Boolean", "Constant" },
										"#000000"
									),
									command = utils.extract_color_from_hllist("fg", { "Identifier" }, "#000000"),
									back1 = utils.extract_color_from_hllist(
										"bg",
										{ "Normal", "StatusLineNC" },
										"#000000"
									),
									fore = utils.extract_color_from_hllist("fg", { "Normal", "StatusLine" }, "#000000"),
									back2 = utils.extract_color_from_hllist("bg", { "StatusLine" }, "#000000"),
								}
								local mode_color = {
									["n"] = colors.normal, -- 'NORMAL',
									["no"] = colors.normal, -- 'O-PENDING',
									["nov"] = colors.normal, -- 'O-PENDING',
									["noV"] = colors.normal, -- 'O-PENDING',
									["no\22"] = colors.normal, -- 'O-PENDING',
									["niI"] = colors.normal, -- 'NORMAL',
									["niR"] = colors.replace, -- 'NORMAL',
									["niV"] = colors.normal, -- 'NORMAL',
									["nt"] = colors.normal, -- 'NORMAL',
									["v"] = colors.visual, -- 'VISUAL',
									["vs"] = colors.visual, -- 'VISUAL',
									["V"] = colors.visual, -- 'V-LINE',
									["Vs"] = colors.visual, -- 'V-LINE',
									["\22"] = colors.visual, -- 'V-BLOCK',
									["\22s"] = colors.visual, -- 'V-BLOCK',
									["s"] = colors.replace, -- 'SELECT',
									["S"] = colors.replace, -- 'S-LINE',
									["\19"] = colors.replace, -- 'S-BLOCK',
									["i"] = colors.insert, -- 'INSERT',
									["ic"] = colors.insert, -- 'INSERT',
									["ix"] = colors.insert, -- 'INSERT',
									["R"] = colors.replace, -- 'REPLACE',
									["Rc"] = colors.replace, -- 'REPLACE',
									["Rx"] = colors.replace, -- 'REPLACE',
									["Rv"] = colors.replace, -- 'V-REPLACE',
									["Rvc"] = colors.replace, -- 'V-REPLACE',
									["Rvx"] = colors.replace, -- 'V-REPLACE',
									["c"] = colors.command, -- 'COMMAND',
									["cv"] = colors.command, -- 'EX',
									["ce"] = colors.command, -- 'EX',
									["r"] = colors.replace, -- 'REPLACE',
									["rm"] = colors.replace, -- 'MORE',
									["r?"] = colors.insert, -- 'CONFIRM',
									["!"] = colors.command, -- 'SHELL',
									["t"] = colors.insert, -- 'TERMINAL',
								}
								return { fg = mode_color[vim.fn.mode()], bg = colors.back1 }
							end,
						},
					},
					lualine_b = { "branch", "diff", "diagnostics", "filename" },
					lualine_c = {
						{
							require("noice").api.statusline.mode.get,
							cond = require("noice").api.statusline.mode.has,
							color = { fg = "#ff9e64" },
						},
					},
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = {
						{
							"location",
							color = {
								fg = require("lualine.utils.utils").extract_color_from_hllist(
									"bg",
									{ "Normal" },
									"#000000"
								),
								bg = require("lualine.utils.utils").extract_color_from_hllist(
									"fg",
									{ "Special", "Boolean", "Constant" },
									"#000000"
								),
							},
						},
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				extensions = {},
			})
		end,

		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},

	{
		"kevinhwang91/nvim-hlslens",
		event = "VeryLazy",
		config = function()
			require("hlslens").setup()
		end,
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup({
				triggers_blacklist = {
					c = { "h" },
				},
				show_help = false,
			})
		end,
	},

	{
		"kwkarlwang/bufresize.nvim",
		event = "VeryLazy",
		config = function()
			require("bufresize").setup()
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		config = function()
			require("indent_blankline").setup({
				space_char_blankline = " ",
				show_current_context = true,
				show_current_context_start = true,
			})
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",

		config = function()
			require("gitsigns").setup()
		end,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				source_selector = {
					winbar = true,
					statusline = false,
				},
				filesystem = {
					follow_current_file = true,
					use_libuv_file_watcher = true,
				},
				window = {
					width = 40,
					mappings = {
						["l"] = "next_source",
						["h"] = "prev_source",
					},
				},
				buffers = {
					follow_current_file = true,
				},
				git_status = {
					window = {
						mappings = {
							["<CR>"] = "open_gdiff",
						},
					},
					commands = {
						open_gdiff = function(state)
							local node = state.tree:get_node()
							local path = node:get_id()

							local cmds = require("neo-tree.sources.filesystem.commands")
							cmds.open(state)

							vim.cmd("Gvdiffsplit!")
						end,
					},
				},
				popup_border_style = "shadow",
				event_handlers = {
					{
						event = "neo_tree_buffer_enter",
						handler = function(arg)
							vim.cmd([[ setlocal relativenumber ]])
						end,
					},
					{
						event = "neo_tree_window_after_open",
						handler = function(arg)
							vim.api.nvim_set_option_value(
								"statuscolumn",
								get_statuscol({
									"num",
									"space",
								}),
								{ scope = "local", win = arg.winid }
							)

							local panelWidth = 35

							local offset = math.floor(panelWidth / 2 - #"Neovim") + 2

							local header = ""
							for _ = 0, offset do
								header = header .. " "
							end

							header = header .. "Neovim"

							require("bufferline.api").set_offset(panelWidth + 1, header)
							vim.api.nvim_win_set_width(arg.winid, panelWidth)
						end,
					},
					{
						event = "neo_tree_window_after_close",
						handler = function()
							require("bufferline.api").set_offset(0, "")
						end,
					},
				},
			})
		end,
	},

	{
		"sindrets/winshift.nvim",
		cmd = "WinShift",
	},

	{
		"distek/zen-mode.nvim",
		-- dir = "~/Programming/neovim-plugs/zen-mode.nvim",
		cmd = "ZenMode",
		config = function()
			require("zen-mode").setup({
				window = {
					backdrop = 0.75,
					width = 120,
					height = 1, -- >1 dicates height of the actual window
				},
				plugins = {
					options = {
						enabled = true,
						ruler = true,
						showcmd = true,
					},
					twilight = { enabled = false },
					gitsigns = { enabled = true },
					tmux = { enabled = false },
				},
			})
		end,
	},

	{
		"folke/twilight.nvim",
		cmd = "Twilight",
		config = function()
			require("twilight").setup({
				dimming = {
					alpha = 0.25,
					color = { "Normal", "#ffffff" },
					inactive = false,
				},
				context = 10,
				treesitter = true,
				expand = {
					"function",
					"method",
					"table",
					"if_statement",
				},
				exclude = {},
			})
		end,
	},

	{
		"romgrk/barbar.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			animation = false,
			insert_at_end = false,
			no_name_title = "-empty-",
		},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-dap.nvim",
			"tknightz/telescope-termfinder.nvim",
		},
		cmd = "Telescope",
		event = "VeryLazy",
		config = function()
			CommandPaletteAllTheThings = function()
				vim.cmd("NeoTree")
				TF.Open()
			end

			require("telescope").setup({
				defaults = {
					mappings = {
						n = {
							["<esc>"] = require("telescope.actions").close,
						},
					},
				},
				extensions = {},
				source_selector = {
					winbar = false,
					statusline = false,
				},
			})

			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("git_worktree")
			require("telescope").load_extension("ui-select")
			-- require("telescope").load_extension("termfinder")
		end,
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
				},
				views = {
					cmdline_popup = {
						border = {
							style = "shadow",
							padding = { 0, 0 },
						},
						win_options = {
							winhighlight = { Normal = "NoiceCmdLine" },
						},
						position = {
							row = 5,
							col = "50%",
						},
						size = {
							width = 60,
							height = "auto",
						},
					},
					popupmenu = {
						relative = "editor",
						position = {
							row = 8,
							col = "50%",
						},
						size = {
							width = 60,
							height = 10,
						},
						border = {
							style = "shadow",
							padding = { 0, 1 },
						},
						win_options = {
							winhighlight = { Normal = "NoiceCmdLine" },
						},
					},
					popup = {
						border = {
							style = "shadow",
							padding = { 0, 1 },
						},
						win_options = {
							winhighlight = { Normal = "NoiceCmdLine" },
						},
					},
					hover = {
						border = {
							style = "shadow",
							padding = { 0, 1 },
						},
						win_options = {
							winhighlight = { Normal = "NoiceCmdLine" },
						},
					},
				},
			})
		end,
	},
}
