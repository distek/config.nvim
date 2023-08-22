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
					lualine_b = { "branch", "diff", "diagnostics", { "filename", path = 1 } },
					lualine_c = {},
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
						{ fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("NeoTreeDimText")), "fg", "gui") },
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
						{ fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("HLChunkIndicator")), "fg", "gui") },
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
		event = "VeryLazy",

		config = function()
			require("gitsigns").setup()
		end,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				source_selector = {
					winbar = false,
					statusline = false,
				},
				filesystem = {
					follow_current_file = {
						enabled = true,
					},
					use_libuv_file_watcher = true,
				},
				window = {
					mappings = {
						-- ["l"] = "next_source",
						-- ["h"] = "prev_source",
						["/"] = "filter_as_you_type",
						["<esc><esc>"] = "clear_filter",
					},
				},
				buffers = {
					follow_current_file = {
						enabled = true,
					},
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
				use_popups_for_input = false,
				open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline", "edgy" },
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
			-- 	["neo-tree"] = { event = "BufWipeout" },
			-- },
		},
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
							["<esc><esc>"] = require("telescope.actions").close,
						},
					},
				},
				extensions = {},
				source_selector = {
					winbar = false,
					statusline = true,
				},
			})

			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("git_worktree")
			require("telescope").load_extension("ui-select")
			-- require("telescope").load_extension("termfinder")
		end,
	},
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				left = { size = 35 },
				bottom = { size = 15 },
				right = { size = 35 },
			},
			exit_when_last = true,
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
				["<a-c-j>"] = function(win)
					win:resize("height", 1)
				end,
				["<a-c-k>"] = function(win)
					win:resize("height", -2)
				end,
				["<a-c-h>"] = function(win)
					win:resize("width", 2)
				end,
				-- decrease width
				["<a-c-l>"] = function(win)
					win:resize("width", -2)
				end,
			},
			animate = {
				enabled = false,
			},
			top = {
				{
					ft = "qf",
					title = "QuickFix",
					pinned = true,
					open = ":copen",
					wo = {
						winbar = true,
						winhighlight = "Normal:EdgyQuickfixNormal",
					},
				},
			},
			bottom = {
				{
					ft = "toggleterm",
					size = { height = 0.15 },
					pinned = true,
					open = function()
						local t = require("tt")

						if #t.terminal.TermList == 0 then
							t.terminal:NewTerminal()
							return
						end

						if t:IsOpen() then
							t.terminal:Close()
							return
						end

						t.terminal:Open("last")
					end,
					-- wo = {
					-- 	winhighlight = "Normal:EdgyTermNormal",
					-- },
				},
				{
					ft = "termlist",
					size = { height = 0.15, width = 25 },
				},
				"Trouble",
			},
			left = {
				{
					title = "Buffers",
					ft = "neo-tree",
					size = { height = 0.15 },
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "buffers"
					end,
					pinned = true,
					visible = true,
					wo = {
						height = "15",
						winbar = true,
					},
					open = "Neotree position=top buffers",
				},
				{
					title = "File Tree",
					ft = "neo-tree",
					size = { height = 0.85 },
					visible = true,
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "filesystem"
					end,
					pinned = true,
					open = "Neotree filesystem",
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
				{
					ft = "help",
					size = { width = 79 },
					filter = function(buf)
						return vim.bo[buf].buftype == "help"
					end,
					wo = {
						winhighlight = "Normal:EdgyHelpNormal",
					},
				},
			},
			fix_win_height = true,
		},
	},
	{ "folke/trouble.nvim" },
	{
		-- "distek/tt.nvim",
		dir = "~/Programming/neovim-plugs/tt.nvim",
		config = function()
			require("tt").setup({
				termlist = {
					enabled = true,
					width = 25,
					name = "Terminals",
					winhighlight = "Normal:EdgyTermListNormal",
					winbar = true,
					focus_on_select = true,
				},

				terminal = {
					winhighlight = "Normal:EdgyTermNormal",
					winbar = true,
					force_insert_on_focus = true,
				},

				height = 15,

				fixed_height = false,
				fixed_width = true,
			})
		end,
	},
}
