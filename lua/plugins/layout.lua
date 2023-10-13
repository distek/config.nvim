return {
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		views = {
	-- 			cmdline_popup = {
	-- 				border = {
	-- 					style = "shadow",
	-- 					-- padding = { 1, 2 },
	-- 				},
	-- 				win_options = {
	-- 					winhighlight = {
	-- 						Normal = "NoiceCmdLine",
	-- 					},
	-- 				},
	-- 			},
	-- 		},
	-- 		lsp = {
	-- 			progress = {
	-- 				enabled = false,
	-- 			},
	-- 			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
	-- 			override = {
	-- 				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	-- 				["vim.lsp.util.stylize_markdown"] = true,
	-- 				["cmp.entry.get_documentation"] = true,
	-- 			},

	-- 			documentation = {
	-- 				view = "hover",
	-- 				opts = {
	-- 					lang = "markdown",
	-- 					replace = true,
	-- 					render = "plain",
	-- 					format = { "{message}" },
	-- 					border = {
	-- 						style = "shadow",
	-- 						-- padding = { 1, 2 },
	-- 					},
	-- 					win_options = {
	-- 						concealcursor = "n",
	-- 						conceallevel = 3,
	-- 						winhighlight = {
	-- 							Normal = "NormalFloat",
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 		},
	-- 		-- you can enable a preset for easier configuration
	-- 		presets = {
	-- 			bottom_search = true, -- use a classic bottom cmdline for search
	-- 			command_palette = true, -- position the cmdline and popupmenu together
	-- 			long_message_to_split = true, -- long messages will be sent to a split
	-- 			inc_rename = false, -- enables an input dialog for inc-rename.nvim
	-- 			lsp_doc_border = false, -- add a border to hover docs and signature help
	-- 		},
	-- 	},
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 	},
	-- },
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
									normal = utils.extract_color_from_hllist(
										"fg",
										{ "Function" },
										"#000000"
									),
									insert = utils.extract_color_from_hllist(
										"fg",
										{ "String", "MoreMsg" },
										"#000000"
									),
									replace = utils.extract_color_from_hllist(
										"fg",
										{ "Number", "Type" },
										"#000000"
									),
									visual = utils.extract_color_from_hllist(
										"fg",
										{ "Special", "Boolean", "Constant" },
										"#000000"
									),
									command = utils.extract_color_from_hllist(
										"fg",
										{ "Identifier" },
										"#000000"
									),
									back1 = utils.extract_color_from_hllist(
										"bg",
										{ "Normal", "StatusLineNC" },
										"#000000"
									),
									fore = utils.extract_color_from_hllist(
										"fg",
										{ "Normal", "StatusLine" },
										"#000000"
									),
									back2 = utils.extract_color_from_hllist(
										"bg",
										{ "StatusLine" },
										"#000000"
									),
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
								return {
									fg = mode_color[vim.fn.mode()],
									bg = colors.back1,
								}
							end,
						},
					},
					lualine_b = {
						"branch",
						"diff",
						"diagnostics",
						{ "filename", path = 1 },
					},
					lualine_c = {
						-- {
						-- 	require("noice").api.statusline.mode.get,
						-- 	cond = require("noice").api.statusline.mode.has,
						-- 	color = { fg = "#ff9e64" },
						-- },
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

	-- {
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("indent_blankline").setup({
	-- 			space_char_blankline = " ",
	-- 			show_current_context = true,
	-- 			show_current_context_start = true,
	-- 		})
	-- 	end,
	-- },
	{
		"shellRaining/hlchunk.nvim",
		event = "VeryLazy",
		config = function()
			local exclude = function()
				local t = {
					"neo-tree",
					"starter",
					"Outline",
					"scratch",
				}

				local tb = {}

				for _, v in ipairs(t) do
					tb[v] = true
				end

				return tb
			end
			require("hlchunk").setup({
				indent = {
					enable = true,
					exclude_filetypes = exclude(),
					use_treesitter = false,
					chars = {
						"│",
					},
					style = {
						{
							fg = vim.fn.synIDattr(
								vim.fn.synIDtrans(vim.fn.hlID("NeoTreeDimText")),
								"fg",
								"gui"
							),
						},
					},
				},

				chunk = {
					enable = true,
					notify = false,
					chars = {
						horizontal_line = "─",
						vertical_line = "│",
						left_top = "╭",
						left_bottom = "╰",
						right_arrow = "─",
					},
					exclude_filetypes = {
						["neo-tree"] = true,
						["starter"] = true,
						["Outline"] = true,
					},
					style = {
						{
							fg = vim.fn.synIDattr(
								vim.fn.synIDtrans(
									vim.fn.hlID("HLChunkIndicator")
								),
								"fg",
								"gui"
							),
						},
					},

					use_treesitter = false,
				},

				line_num = {
					enable = false,
				},

				blank = {
					enable = false,
				},
			})
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "VimEnter",

		config = function()
			require("gitsigns").setup()
		end,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			-- if os.getenv("VIDESOCK") ~= nil then
			-- 	return
			-- end
			require("neo-tree").setup({
				sources = {
					"buffers",
					"filesystem",
				},
				source_selector = {
					winbar = false,
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
					window = {
						mappings = {
							["/"] = "filter_as_you_type",
							["<esc><esc>"] = "clear_filter",
							["d"] = function(state, callback)
								local tree = state.tree
								local node = tree:get_node()

								local _, name =
									require("neo-tree.utils").split_path(
										node.path
									)

								local msg = string.format(
									"Are you sure you want to delete '%s'? [y/N]: ",
									name
								)

								vim.ui.input({ prompt = msg }, function(input)
									if input == "y" or input == "Y" then
										-- Work around for edgy
										if
											node.type == "file"
											or node.type == "directory"
										then
											for _, v in
												ipairs(vim.api.nvim_list_bufs())
											do
												if
													vim.api.nvim_buf_get_name(v)
													== node.path
												then
													local empty =
														vim.api.nvim_create_buf(
															true,
															false
														)
													for _, w in
														ipairs(
															vim.api.nvim_list_wins()
														)
													do
														if
															vim.api.nvim_win_get_buf(
																w
															)
															== v
														then
															vim.api.nvim_win_set_buf(
																w,
																empty
															)
														end
													end
													break
												end
											end
											require(
												"neo-tree.sources.filesystem.lib.fs_actions"
											).delete_node(
												node.path,
												callback,
												true
											)
										else
											vim.notify(
												"The `delete` command can only be used on files and directories"
											)
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
	},

	{
		"sindrets/winshift.nvim",
		cmd = "WinShift",
	},

	{
		"folke/zen-mode.nvim",
		-- dir = "~/Programming/neovim-plugs/zen-mode.nvim",
		cmd = "ZenMode",
		config = function()
			require("zen-mode").setup({
				window = {
					backdrop = 0.75,
					width = 120,
					height = 1, -- >1 dictates height of the actual window
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
				treesitter = false,
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
			no_name_title = "-empty-",
			exclude_ft = {
				"toggleterm",
				"termlist",
				"qf",
			},
			focus_on_close = "left",
			insert_at_end = true,
			-- sidebar_filetypes = {
			-- 	["neo-tree"] = true,
			-- },
		},
		config = function(opts)
			require("bufferline").setup(opts)
			require("bufferline.api").set_offset(8, "Neovim")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			TelescopeLayoutGen = function(name)
				local Layout = require("telescope.pickers.layout")

				local function create_window(
					enter,
					width,
					height,
					row,
					col,
					title
				)
					local bufnr = vim.api.nvim_create_buf(false, true)
					local winid = vim.api.nvim_open_win(bufnr, enter, {
						style = "minimal",
						relative = "editor",
						width = width,
						height = height,
						row = row,
						col = col,
						border = "shadow",
						title = title,
					})

					vim.wo[winid].winhighlight = "Normal:NormalFloat"

					return Layout.Window({
						bufnr = bufnr,
						winid = winid,
					})
				end

				local function destory_window(window)
					if window then
						if vim.api.nvim_win_is_valid(window.winid) then
							vim.api.nvim_win_close(window.winid, true)
						end
						if vim.api.nvim_buf_is_valid(window.bufnr) then
							vim.api.nvim_buf_delete(
								window.bufnr,
								{ force = true }
							)
						end
					end
				end

				-- default {{{
				local function defaultMount(self)
					local line_count = vim.o.lines - vim.o.cmdheight
					if vim.o.laststatus ~= 0 then
						line_count = line_count - 1
					end

					local width = vim.o.columns
					local height = line_count - 15 - 2

					local topPad = 7

					local paneWidth = math.floor((width * 0.70) / 2)

					self.results = create_window(
						false,
						paneWidth - 1, -- width
						height, -- height
						topPad, -- row
						math.floor(vim.o.columns * 0.15), -- col
						"Results"
					)

					self.preview = create_window(
						false,
						paneWidth - 1,
						height,
						topPad,
						math.floor(vim.o.columns * 0.15 + paneWidth) + 1,
						"Preview"
					)
					self.prompt = create_window(
						true,
						paneWidth * 2,
						1,
						height + topPad + 2,
						math.floor(vim.o.columns * 0.15),
						"Prompt"
					)
				end

				local function defaultUnmount(self)
					destory_window(self.results)
					destory_window(self.preview)
					destory_window(self.prompt)
				end
				-- }}}

				-- select {{{
				local function selectMount(self)
					local line_count = vim.o.lines - vim.o.cmdheight
					if vim.o.laststatus ~= 0 then
						line_count = line_count - 1
					end

					local width = vim.o.columns
					local height = 10

					local topPad = 7

					local paneWidth = math.floor(width * 0.50)

					self.results = create_window(
						false,
						paneWidth, -- width
						height, -- height
						topPad, -- row
						math.floor(vim.o.columns * 0.25), -- col
						"Results"
					)

					self.prompt = create_window(
						true,
						paneWidth,
						1,
						height + topPad + 2,
						math.floor(vim.o.columns * 0.25),
						"Prompt"
					)
				end
				local function selectUnmount(self)
					destory_window(self.results)
					destory_window(self.prompt)
				end
				-- }}}

				local function get(key, layoutName)
					if key == "mount" then
						if layoutName == "default" then
							return defaultMount
						end
						if layoutName == "select" then
							return selectMount
						end
					elseif key == "unmount" then
						if layoutName == "default" then
							return defaultUnmount
						end
						if layoutName == "select" then
							return selectUnmount
						end
					end
				end

				return function(picker)
					local layout = Layout({
						picker = picker,
						mount = get("mount", name),
						unmount = get("unmount", name),
						update = function(self) end,
					})

					return layout
				end
			end

			require("telescope").setup({
				defaults = {
					mappings = {
						n = {
							["<esc>"] = require("telescope.actions").close,
							["<esc><esc>"] = require("telescope.actions").close,
						},
					},

					create_layout = TelescopeLayoutGen("default"),
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("git_worktree")
			require("telescope").load_extension("ui-select")

			vim.api.nvim_create_autocmd("User", {
				pattern = "TelescopePreviewerLoaded",
				callback = function(args)
					vim.wo.winhighlight = "Normal:NormalFloatDarker"
				end,
			})
		end,
	},
	{ "folke/trouble.nvim" },
	-- {
	-- 	"distek/tt.nvim",
	-- 	-- dir = "~/dev/neovim-plugs/tt.nvim",
	-- 	config = function()
	-- 		require("tt").setup({
	-- 			termlist = {
	-- 				enabled = false,
	-- 				width = 25,
	-- 				name = "Terminals",
	-- 				winhighlight = "Normal:EdgyTermListNormal",
	-- 				winbar = true,
	-- 				focus_on_select = true,
	-- 			},

	-- 			terminal = {
	-- 				winhighlight = "Normal:EdgyTermNormal",
	-- 				winbar = false,
	-- 				force_insert_on_focus = true,
	-- 			},

	-- 			height = 15,

	-- 			fixed_height = false,
	-- 			fixed_width = true,
	-- 		})
	-- 	end,
	-- },

	-- {
	-- 	"levouh/tint.nvim",
	-- 	event = "VeryLazy",
	-- },
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				left = { size = 35 },
				top = { size = 15 },
				bottom = { size = 15 },
				right = { size = 35 },
			},
			exit_when_last = false,
			wo = {
				-- Setting to `true`, will add an edgy winbar.
				-- Setting to `false`, won't set any winbar.
				-- Setting to a string, will set the winbar to that string.
				winbar = false,
				winfixwidth = true,
				winfixheight = true,
				winhighlight = "WinBar:EdgyWinBar",
				spell = false,
				signcolumn = "no",
				statuscolumn = "",
				number = false,
				relativenumber = false,
			},
			keys = {
				["q"] = function(win)
					win:hide()
				end,
				["<c-q>"] = false,
				["Q"] = false,
				["]w"] = false,
				["[w"] = false,
				["]W"] = false,
				["[W"] = false,
				["<c-w>>"] = false,
				["<c-w><lt>"] = false,
				["<c-w>+"] = false,
				["<c-w>-"] = false,
				["<c-w>"] = false,
				["<A-C-j>"] = function(win)
					win:resize("height", 1)
				end,
				["<A-C-k>"] = function(win)
					win:resize("height", -2)
				end,
				["<A-C-h>"] = function(win)
					win:resize("width", 2)
				end,
				-- decrease width
				["<A-C-l>"] = function(win)
					win:resize("width", -2)
				end,
			},
			animate = {
				enabled = false,
			},
			top = {},
			left = {
				{
					title = "Buffers",
					ft = "neo-tree",
					size = { height = 0.25 },
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "buffers"
					end,
					pinned = true,
					open = "Neotree position=top buffers",
					wo = {
						winbar = true,
					},
				},
				{
					title = "Files",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "filesystem"
					end,
					open = "Neotree",
					pinned = true,
					size = { height = 0.75 },
					wo = {
						winbar = true,
					},
				},
			},
			right = {
				{
					ft = "Outline",
					visible = false,
					size = { height = 0.25 },
					pinned = true,
					open = "SymbolsOutlineOpen",
					wo = {
						winbar = true,
					},
				},
				-- {
				-- 	ft = "help",
				-- 	size = { width = 79 },
				-- 	filter = function(buf)
				-- 		return vim.bo[buf].buftype == "help"
				-- 	end,
				-- 	wo = {
				-- 		winbar = true,
				-- 		winhighlight = "Normal:EdgyHelpNormal",
				-- 	},
				-- },
				{
					title = "Tests",
					ft = "neotest-summary",
					pinned = true,
					open = "Neotest summary",
					size = { width = 30 },
					wo = {
						winbar = true,
						wrap = false,
					},
				},
			},
			fix_win_height = vim.fn.has("nvim-0.10.0") == 0,
		},
	},
	{
		"s1n7ax/nvim-window-picker",
		name = "window-picker",
		event = "VeryLazy",
		version = "2.*",
		config = function()
			require("window-picker").setup()
		end,
	},
}
