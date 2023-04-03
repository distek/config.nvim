-- Bootstrap {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- }}}

-- Plugins
require("lazy").setup({
	-- Treesitter{{{

	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"css",
					"diff",
					"git_rebase",
					"gitattributes",
					"gitcommit",
					"gitignore",
					"go",
					"gomod",
					"help",
					"html",
					"ini",
					"javascript",
					"jq",
					"jsonc",
					"lua",
					"make",
					"markdown",
					"markdown_inline",
					"python",
					"regex",
					"rust",
					"scss",
					"sql",
					"svelte",
					"swift",
					"terraform",
					"todotxt",
					"tsx",
					"typescript",
					"vim",
					"yaml",
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = true,
					-- custom_captures = {
					--     ["variable"] = "Constant",
				},
				indent = {
					enable = true,
				},
				rainbow = {
					enable = true,
					extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
					max_file_lines = nil, -- Do not enable for files with more than n lines, int
					-- colors = {}, -- table of hex strings
					-- termcolors = {} -- table of colour name strings
				},
				autotag = {
					enable = true,
				},
				textobjects = {
					-- syntax-aware textobjects
					select = {

						enable = true,
						keymaps = {
							-- or you use the queries from supported languages with textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["aC"] = "@class.outer",
							["iC"] = "@class.inner",
							["ac"] = "@conditional.outer",
							["ic"] = "@conditional.inner",
							["ae"] = "@block.outer",
							["ie"] = "@block.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["is"] = "@statement.inner",
							["as"] = "@statement.outer",
							["ad"] = "@comment.outer",
							["am"] = "@call.outer",
							["im"] = "@call.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = { query = "@class.outer", desc = "Next class start" },
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
				},
				context_commentstring = {
					enable = true,
					commentary_integration = {
						-- change default mapping
						Commentary = false,
						-- disable default mapping
						CommentaryLine = false,
					},
				},
			})
		end,
	},
	-- Treesitter playground{{{
	{ "nvim-treesitter/playground", event = "VeryLazy" },
	-- }}}
	-- Treesitter context{{{
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
					-- For all filetypes
					-- Note that setting an entry here replaces all other patterns for this entry.
					-- By setting the 'default' entry below, you can control which nodes you want to
					-- appear in the context window.
					default = {
						"class",
						"function",
						"method",
						"for",
						"while",
						"if",
						"switch",
						"case",
					},
					-- Patterns for specific filetypes
					-- If a pattern is missing, *open a PR* so everyone can benefit.
					tex = {
						"chapter",
						"section",
						"subsection",
						"subsubsection",
					},
					rust = {
						"impl_item",
						"struct",
						"enum",
					},
					scala = {
						"object_definition",
					},
					vhdl = {
						"process_statement",
						"architecture_body",
						"entity_declaration",
					},
					markdown = {
						"section",
					},
					elixir = {
						"anonymous_function",
						"arguments",
						"block",
						"do_block",
						"list",
						"map",
						"tuple",
						"quoted_content",
					},
					json = {
						"pair",
					},
					yaml = {
						"block_mapping_pair",
					},
				},
				exact_patterns = {
					-- Example for a specific filetype with Lua patterns
					-- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
					-- exactly match "impl_item" only)
					-- rust = true,
				},
				-- [!] The options below are exposed but shouldn't require your attention,
				--     you can safely ignore them.

				zindex = 20, -- The Z-index of the context window
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
			})
		end,
	},
	-- }}}
	-- Treesitter extras{{{
	{ "nvim-treesitter/nvim-treesitter-textobjects", event = "VeryLazy" },
	{ "mrjones2014/nvim-ts-rainbow", event = "VeryLazy" },
	{ "windwp/nvim-ts-autotag", event = "VeryLazy" },
	-- }}}

	{ "JoosepAlviste/nvim-ts-context-commentstring" },

	-- }}}

	-- Layout/UI{{{
	{
		"nvim-lualine/lualine.nvim", -- {{{
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
	-- }}}

	{
		"kevinhwang91/nvim-hlslens", -- {{{
		event = "VeryLazy",
		config = function()
			require("hlslens").setup()
		end,
	}, -- }}}

	{
		"folke/which-key.nvim", -- {{{
		event = "VeryLazy",
		config = function()
			require("which-key").setup({
				triggers_blacklist = {
					c = { "h" },
				},
				show_help = false,
			})
		end,
	}, -- }}}

	{
		"kwkarlwang/bufresize.nvim", -- {{{
		event = "VeryLazy",
		config = function()
			require("bufresize").setup()
		end,
	}, -- }}}

	{
		"lukas-reineke/indent-blankline.nvim", -- {{{
		event = "VeryLazy",
		config = function()
			require("indent_blankline").setup({
				space_char_blankline = " ",
				show_current_context = true,
				show_current_context_start = true,
			})
		end,
	}, -- }}}

	{
		"lewis6991/gitsigns.nvim", -- {{{
		event = "VeryLazy",

		config = function()
			require("gitsigns").setup()
		end,
	}, -- }}}

	{
		"nvim-neo-tree/neo-tree.nvim", -- {{{
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
				},
				buffers = {
					follow_current_file = true,
				},
				popup_border_style = "rounded",
			})
		end,
	}, -- }}}

	{
		"sindrets/winshift.nvim", -- {{{
		cmd = "WinShift",
	}, -- }}}

	{
		"distek/zen-mode.nvim", -- {{{
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
	}, -- }}}

	{
		"folke/twilight.nvim", -- {{{
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
	}, -- }}}

	{
		"distek/sessions.nvim", -- {{{
		-- dir = "~/Programming/neovim-plugs/sessions.nvim",
		event = "VeryLazy",
		config = function()
			require("sessions").setup({
				post_exec = function()
					TF.TermOpen()

					vim.cmd("Neotree show")

					vim.defer_fn(function()
						vim.cmd("wincmd k")
						vim.cmd("stopinsert")
					end, 100)
				end,
			})
		end,
	},
	-- }}}

	{
		"distek/bufferline.nvim", -- {{{
		branch = "tabpage-rename",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers", -- set to "tabs" to only show tabpages instead
					numbers = "none",
					close_command = "lua require('bufdelete').bufdelete(0, true)", -- can be a string | function, see "Mouse actions"
					right_mouse_command = "", -- can be a string | function, see "Mouse actions"
					left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
					middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
					indicator = {
						icon = "▎", -- this should be omitted if indicator style is not 'icon'
						style = "icon",
					},
					buffer_close_icon = "",
					modified_icon = "●",
					close_icon = "",
					left_trunc_marker = "",
					right_trunc_marker = "",
					max_name_length = 18,
					max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
					truncate_names = true, -- whether or not tab names should be truncated
					tab_size = 18,
					diagnostics = "nvim_lsp",
					diagnostics_update_in_insert = false,
					-- NOTE: this will be called a lot so don't do any heavy processing here
					-- custom_filter = function(buf_number, buf_numbers)
					--     -- filter out filetypes you don't want to see
					--     if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
					--         return true
					--     end
					--     -- filter out by buffer name
					--     if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
					--         return true
					--     end
					--     -- filter out based on arbitrary rules
					--     -- e.g. filter out vim wiki buffer from tabline in your work repo
					--     if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
					--         return true
					--     end
					--     -- filter out by it's index number in list (don't show first buffer)
					--     if buf_numbers[1] ~= buf_number then
					--         return true
					--     end
					-- end,
					offsets = {
						{
							filetype = "neo-tree",
							text = "Neovim",
							highlight = "Explorer",
							text_align = "center",
							padding = 1,
						},
					},
					color_icons = true, -- whether or not to add the filetype icon highlights
					show_buffer_icons = true, -- disable filetype icons for buffers
					show_buffer_close_icons = true,
					show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
					show_close_icon = true,
					show_tab_indicators = true,
					show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
					persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
					-- can also be a table containing 2 custom separators
					-- [focused and unfocused]. eg: { '|', '|' }
					separator_style = "thick",
					always_show_bufferline = true,
					-- hover = {
					--     enabled = true,
					--     delay = 200,
					--     reveal = {'close'}
					-- },
					-- sort_by = 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
					-- add custom logic
					-- return buffer_a.modified > buffer_b.modified
					-- end
				},
			})
		end,
	}, -- }}}

	{
		"nvim-telescope/telescope.nvim", -- {{{
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-dap.nvim",
			"LinArcX/telescope-command-palette.nvim",
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
				extensions = {
					command_palette = {
						{
							"IDE",
							{ "All the things", "lua CommandPaletteAllTheThings()" },
							{ "New Term", "lua TermNew()" },
						},
						{
							"Session",
							{ "Delete", "lua require('sessions').deleteSession()" },
							{ "Save", "lua require('sessions').saveSession()" },
							{ "Load", "lua require('sessions').selectSession()" },
							{ "New", "lua require('sessions').newSession()" },
						},
					},
				},
				source_selector = {
					winbar = false,
					statusline = false,
				},
			})

			require("telescope").load_extension("command_palette")
			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("git_worktree")
			require("telescope").load_extension("ui-select")
			-- require("telescope").load_extension("termfinder")
		end,
	}, -- }}}
	-- }}}

	-- Filetypes{{{
	{ "chrisbra/csv.vim", ft = { "csv" }, lazy = true },
	{
		"simrat39/rust-tools.nvim",
		ft = { "rust" },
		lazy = true,
		config = function()
			local rt = require("rust-tools")

			rt.setup({
				server = {
					on_attach = function(_, bufnr) end,
				},
			})
		end,
	},
	{ "sirtaj/vim-openscad", ft = { "openscad" }, lazy = true },

	{
		"plasticboy/vim-markdown",
		ft = { "markdown" },
		lazy = true,
		config = function()
			vim.g.vim_markdown_folding_disabled = 1
			vim.g.vim_markdown_no_default_key_mappings = 1
			vim.g.vim_markdown_conceal = 1
			vim.g.vim_markdown_conceal_code_blocks = 0
			vim.g.vim_markdown_strikethrough = 1
		end,
	},

	{
		"ray-x/go.nvim",
		ft = { "go" },
		lazy = true,
		config = function()
			require("go").setup()
		end,
	}, -- }}}

	-- LSP{{{
	{
		"neovim/nvim-lspconfig", -- {{{
		config = function()
			local lspconfig = require("lspconfig")

			-- Formatting
			-- Map :Format to vim.lsp.buf.formatting()
			vim.cmd([[command! Format execute 'lua vim.lsp.buf.format { async = true }']])

			-- Aesthetics
			local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

			for type, icon in pairs(signs) do
				local hl = "LspDiagnosticsSign" .. type

				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			require("mason").setup({
				ui = {
					icons = {
						server_installed = "✓",
						server_pending = "➜",
						server_uninstalled = "✗",
					},
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = { "bashls", "clangd", "cssls", "gopls", "lua_ls", "tsserver" },
				automatic_installation = true,
			})

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({})
				end,
				["clangd"] = function()
					local capabilities = vim.lsp.protocol.make_client_capabilities()
					capabilities.offsetEncoding = { "utf-16" }
					require("lspconfig").clangd.setup({
						capabilities = capabilities,
					})
				end,
				["cssls"] = function()
					local capabilities = vim.lsp.protocol.make_client_capabilities()
					capabilities.textDocument.completion.completionItem.snippetSupport = true
					require("lspconfig").cssls.setup({
						capabilities = capabilities,
					})
				end,
				["gopls"] = function()
					lspconfig.gopls.setup({
						root_dir = lspconfig.util.root_pattern("go.mod", ".git", "main.go"),
					})
				end,
				["lua_ls"] = function()
					local runtime_path = vim.split(package.path, ";")
					table.insert(runtime_path, "lua/?.lua")
					table.insert(runtime_path, "lua/?/init.lua")

					lspconfig.lua_ls.setup({
						settings = {
							Lua = {
								runtime = {
									-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
									version = "LuaJIT",
									-- Setup your lua path
									path = runtime_path,
								},
								diagnostics = {
									-- Get the language server to recognize the `vim` global
									globals = { "vim" },
								},
								workspace = {
									-- Make the server aware of Neovim runtime files
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false,
								},
								-- Do not send telemetry data containing a randomized but unique identifier
								telemetry = {
									enable = false,
								},
								format = {
									enable = false,
									-- Put format options here
									-- NOTE: the value should be STRING!!
									defaultConfig = {
										indent_style = "space",
										indent_size = "2",
									},
								},
							},
						},
					})
				end,
			})

			require("mason-null-ls").setup({
				ensure_installed = {
					"clang_format",
					"goimports",
					"golangci_lint",
					"jq",
					"prettier",
					"rust_analyzer",
					"shfmt",
					"stylua",
				},
				automatic_installation = true,
				automatic_setup = true, -- Recommended, but optional
			})

			require("null-ls").setup()

			require("mason-null-ls").setup_handlers()
			-- local prettier = require("prettier")

			-- prettier.setup({
			--     bin = 'prettier', -- or `'prettierd'` (v0.22+)
			--     filetypes = {
			--         "css",
			--     },
			--     cli_options = {
			--         arrow_parens = "always",
			--         bracket_spacing = true,
			--         bracket_same_line = false,
			--         embedded_language_formatting = "auto",
			--         end_of_line = "lf",
			--         html_whitespace_sensitivity = "css",
			--         -- jsx_bracket_same_line = false,
			--         jsx_single_quote = false,
			--         print_width = 80,
			--         prose_wrap = "preserve",
			--         quote_props = "as-needed",
			--         semi = true,
			--         single_attribute_per_line = false,
			--         single_quote = false,
			--         tab_width = 4,
			--         trailing_comma = "es5",
			--         use_tabs = false,
			--         vue_indent_script_and_style = false,
			--     },
			-- })

			-- lsp_signature
			require("lsp_signature").setup({
				debug = false, -- set to true to enable debug logging
				log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
				-- default is  ~/.cache/nvim/lsp_signature.log
				verbose = false, -- show debug line number
				bind = true, -- This is mandatory, otherwise border config won't get registered.
				-- If you want to hook lspsaga or other signature handler, pls set to false
				doc_lines = 0, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
				-- set to 0 if you DO NOT want any API comments be shown
				-- This setting only take effect in insert mode, it does not affect signature help in normal
				-- mode, 10 by default

				max_height = 12, -- max height of signature floating_window
				max_width = 80, -- max_width of signature floating_window
				noice = false, -- set to true if you using noice to render markdown
				wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
				floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
				floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
				-- will set to true when fully tested, set to false will use whichever side has more space
				-- this setting will be helpful if you do not want the PUM and floating win overlap

				floating_window_off_x = 1, -- adjust float windows x position.
				floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
				-- can be either number or function, see examples

				close_timeout = 4000, -- close floating window after ms when laster parameter is entered
				fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
				hint_enable = true, -- virtual hint enable
				hint_prefix = "", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
				hint_scheme = "String",
				hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
				handler_opts = {
					border = "shadow", -- double, rounded, single, shadow, none, or a table of borders
				},
				always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
				auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
				extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
				zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
				padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
				transparency = nil, -- disabled by default, allow floating win transparent value 1~100
				shadow_blend = 36, -- if you using shadow as border use this set the opacity
				shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
				timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
				toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
				select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
				move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
			})
		end,
	}, -- }}}

	{ "williamboman/mason.nvim", event = "BufReadPre" },
	{ "williamboman/mason-lspconfig.nvim", event = "BufReadPre" },

	{
		"jayp0521/mason-null-ls.nvim",
		event = "BufReadPre",
		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
		},
	},

	{
		"hrsh7th/nvim-cmp", -- {{{
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-look",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-nvim-lua",
			"uga-rosa/cmp-dictionary",
			"hrsh7th/vim-vsnip",
			"rafamadriz/friendly-snippets",
			"honza/vim-snippets",
		},
		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local luasnip = require("luasnip")

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				formatting = {
					format = require("lspkind").cmp_format({
						with_text = true,
						maxwidth = 50,
						menu = {
							buffer = "[Buffer]",
							nvim_lsp = "[LSP]",
							luasnip = "[Luasnip]",
							nvim_lua = "[Lua]",
							look = "[Look]",
							spell = "[Spell]",
							path = "[Path]",
							calc = "[Calc]",
						},
					}),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				preselect = cmp.PreselectMode.None,
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "look", keyword_length = 2, options = { convert_case = true, loud = true } },
					{ name = "path" },
					{ name = "calc" },
					{ name = "dictionary" },
				}),
			})

			require("cmp").setup.cmdline(":", {
				sources = {
					{ name = "cmdline" },
					{ name = "path" },
				},
				mapping = {
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "c" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "c" }),
				},
			})
			-- require("cmp").setup.cmdline("@", {
			-- 	sources = cmp.config.sources({
			-- 		{ name = "cmdline" },
			-- 		{ name = "path" },
			-- 	}),
			-- 	mapping = {
			-- 		["<Tab>"] = cmp.mapping(function(fallback)
			-- 			if cmp.visible() then
			-- 				cmp.select_next_item()
			-- 			else
			-- 				fallback()
			-- 			end
			-- 		end, { "c" }),
			-- 		["<S-Tab>"] = cmp.mapping(function(fallback)
			-- 			if cmp.visible() then
			-- 				cmp.select_prev_item()
			-- 			else
			-- 				fallback()
			-- 			end
			-- 		end, { "c" }),
			-- 	},
			-- })

			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_snipmate").lazy_load()
		end,
	}, -- }}}

	{ "onsails/lspkind-nvim", event = "InsertEnter" },

	{
		"dnlhc/glance.nvim",
		event = "VeryLazy",
		cmd = "Glance",
		config = function()
			require("glance").setup({
				border = {
					enable = true, -- Show window borders. Only horizontal borders allowed
					top_char = "―",
					bottom_char = "―",
				},
			})
		end,
	},

	{
		"simrat39/symbols-outline.nvim", -- {{{
		event = "InsertEnter",
		config = function()
			require("symbols-outline").setup({
				highlight_hovered_item = true,
				show_guides = true,
				auto_preview = false,
				position = "right",
				relative_width = true,
				width = 25,
				auto_close = false,
				show_numbers = false,
				show_relative_numbers = false,
				show_symbol_details = true,
				preview_bg_highlight = "Pmenu",
				autofold_depth = nil,
				auto_unfold_hover = true,
				fold_markers = { "", "" },
				wrap = false,
				keymaps = { -- These keymaps can be a string or a table for multiple keys
					close = { "q" },
					goto_location = "<Cr>",
					focus_location = "o",
					hover_symbol = "<C-space>",
					toggle_preview = "K",
					rename_symbol = "r",
					code_actions = "a",
					fold = "zc",
					unfold = "zo",
					fold_all = "zM",
					unfold_all = "zR",
					fold_reset = "R",
				},
				lsp_blacklist = {},
				symbol_blacklist = {},
				symbols = {
					File = { icon = "", hl = "TSURI" },
					Module = { icon = "", hl = "TSNamespace" },
					Namespace = { icon = "", hl = "TSNamespace" },
					Package = { icon = "", hl = "TSNamespace" },
					Class = { icon = "𝓒", hl = "TSType" },
					Method = { icon = "ƒ", hl = "TSMethod" },
					Property = { icon = "", hl = "TSMethod" },
					Field = { icon = "", hl = "TSField" },
					Constructor = { icon = "", hl = "TSConstructor" },
					Enum = { icon = "ℰ", hl = "TSType" },
					Interface = { icon = "ﰮ", hl = "TSType" },
					Function = { icon = "", hl = "TSFunction" },
					Variable = { icon = "", hl = "TSConstant" },
					Constant = { icon = "", hl = "TSConstant" },
					String = { icon = "𝓐", hl = "TSString" },
					Number = { icon = "#", hl = "TSNumber" },
					Boolean = { icon = "⊨", hl = "TSBoolean" },
					Array = { icon = "", hl = "TSConstant" },
					Object = { icon = "⦿", hl = "TSType" },
					Key = { icon = "🔐", hl = "TSType" },
					Null = { icon = "NULL", hl = "TSType" },
					EnumMember = { icon = "", hl = "TSField" },
					Struct = { icon = "𝓢", hl = "TSType" },
					Event = { icon = "🗲", hl = "TSType" },
					Operator = { icon = "+", hl = "TSOperator" },
					TypeParameter = { icon = "𝙏", hl = "TSParameter" },
				},
			})
		end,
	}, -- }}}

	{ "ray-x/lsp_signature.nvim", event = "InsertEnter" },
	-- }}}

	-- DAP{{{
	{
		"mfussenegger/nvim-dap", -- {{{
		event = "VeryLazy",
		config = function()
			local dap = require("dap")

			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "red" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "ﳁ", texthl = "blue" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "red" })
			vim.fn.sign_define("DapLogPoint", { text = "", texthl = "yellow" })
			vim.fn.sign_define("DapStopped", { text = "", texthl = "green" })

			dap.adapters.go = function(callback, _)
				local handle
				local port = 38697
				handle, _ = vim.loop.spawn("dlv", {
					args = { "dap", "-l", "127.0.0.1:" .. port },
					detached = true,
				}, function(code)
					handle:close()
					print("Delve exited with exit code: " .. code)
				end)
				-- Wait 100ms for delve to start
				vim.defer_fn(function()
					dap.repl.open()
					callback({ type = "server", host = "127.0.0.1", port = port })
				end, 100)
			end

			-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
			require("dapui").setup({
				icons = { expanded = "▾", collapsed = "▸" },
				mappings = {
					-- use(a table to apply multiple mappings
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
				},
				layouts = {
					{
						elements = {
							"scopes",
							"breakpoints",
							"stacks",
							"watches",
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							"repl",
							"console",
						},
						size = 10,
						position = "bottom",
					},
				},
				controls = {
					-- Requires Neovim nightly (or 0.8 when released)
					enabled = true,
					-- Display controls in this element
					element = "console",
					icons = {
						pause = "",
						play = "",
						step_into = "",
						step_over = "",
						step_out = "",
						step_back = "",
						run_last = "",
						terminate = "",
					},
				},
				floating = {
					max_height = 1, -- These can be integers or a float between 0 and 1.
					max_width = 19, -- Floats will be treated as percentage of your screen.
					border = "single", -- Border style. Can be "single", "double" or "rounded"
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
			})

			dap.adapters.dlv_spawn = function(cb)
				local stdout = vim.loop.new_pipe(false)
				local handle
				local pid_or_err
				local port = 38697
				local opts = {
					stdio = { nil, stdout },
					args = { "dap", "-l", "127.0.0.1:" .. port },
					detached = true,
				}
				handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
					stdout:close()
					handle:close()
					if code ~= 0 then
						print("dlv exited with code", code)
					end
				end)
				assert(handle, "Error running dlv: " .. tostring(pid_or_err))
				stdout:read_start(function(err, chunk)
					assert(not err, err)
					if chunk then
						vim.schedule(function()
							--- You could adapt this and send `chunk` to somewhere else
							require("dap.repl").append(chunk)
						end)
					end
				end)
				-- Wait for delve to start
				vim.defer_fn(function()
					cb({ type = "server", host = "127.0.0.1", port = port })
				end, 100)
			end

			dap.configurations.go = {
				{
					type = "dlv_spawn",
					name = "Launch dlv & file",
					request = "launch",
					program = "${workspaceFolder}",
				},
				{
					type = "go",
					name = "Debug",
					request = "launch",
					program = "${workspaceFolder}",
				},
				{
					type = "dlv_spawn",
					name = "Debug with arguments",
					request = "launch",
					program = "${workspaceFolder}",
					args = function()
						local args_string = vim.fn.input("Arguments: ")
						return vim.split(args_string, " +")
					end,
				},
				{
					type = "go",
					name = "Debug test",
					request = "launch",
					mode = "test", -- Mode is important
					program = "${file}",
				},
			}

			dap.configurations.c = {
				{
					name = "codelldb server",
					type = "server",
					port = "${port}",
					executable = {
						command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
						args = { "--port", "${port}" },
					},
				},
			}

			require("nvim-dap-virtual-text").setup({})
		end,
	}, -- }}}

	{ "rcarriga/nvim-dap-ui", event = "VeryLazy" },

	{ "theHamsta/nvim-dap-virtual-text", event = "VeryLazy" },
	{ "mfussenegger/nvim-dap-python", ft = { "python" }, lazy = true },
	-- }}}

	-- Misc{{{

	{
		"jakewvincent/mkdnflow.nvim", -- {{{
		ft = { "markdown" },
		lazy = true,
		config = function()
			require("mkdnflow").setup({
				links = {
					transform_explicit = function(text)
						-- Make lowercase, remove spaces, and reverse the string
						return string.lower(text:gsub(" ", "_"))
					end,
				},
				mappings = {
					MkdnEnter = { { "n", "v" }, "<CR>" },
					MkdnTab = false,
					MkdnSTab = false,
					MkdnNextLink = false,
					MkdnPrevLink = false,
					MkdnNextHeading = { "n", "]]" },
					MkdnPrevHeading = { "n", "[[" },
					MkdnGoBack = { "n", "<BS>" },
					MkdnGoForward = { "n", "<Del>" },
					MkdnFollowLink = false, -- see MkdnEnter
					MkdnDestroyLink = { "n", "<M-CR>" },
					MkdnTagSpan = { "v", "<M-CR>" },
					MkdnMoveSource = { "n", "<F2>" },
					MkdnYankAnchorLink = { "n", "ya" },
					MkdnYankFileAnchorLink = { "n", "yfa" },
					MkdnIncreaseHeading = { "n", "+" },
					MkdnDecreaseHeading = { "n", "-" },
					MkdnToggleToDo = { { "n", "v" }, "<C-Space>" },
					MkdnNewListItem = false,
					MkdnNewListItemBelowInsert = { "n", "o" },
					MkdnNewListItemAboveInsert = { "n", "O" },
					MkdnExtendList = false,
					MkdnUpdateNumbering = { "n", "<leader>nn" },
					MkdnTableNextCell = { "i", "<Tab>" },
					MkdnTablePrevCell = { "i", "<S-Tab>" },
					MkdnTableNextRow = false,
					MkdnTablePrevRow = { "i", "<M-CR>" },
					MkdnTableNewRowBelow = { "n", "<leader>ir" },
					MkdnTableNewRowAbove = { "n", "<leader>iR" },
					MkdnTableNewColAfter = { "n", "<leader>ic" },
					MkdnTableNewColBefore = { "n", "<leader>iC" },
					MkdnFoldSection = false,
					MkdnUnfoldSection = false,
				},
			})
		end,
	}, -- }}}

	{ "tpope/vim-commentary" },

	{
		"ThePrimeagen/refactoring.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				disable_in_macro = true,
				enable_check_bracket_line = true,
			})
		end,
	},

	{ "tpope/vim-fugitive", event = "VeryLazy", cmd = "Git" },
	{ "ThePrimeagen/git-worktree.nvim", event = "VeryLazy" },

	{ "powerman/vim-plugin-AnsiEsc" },

	{ "norcalli/nvim-colorizer.lua", cmd = "ColorizerToggle", event = "VeryLazy" },

	{
		"nvim-zh/colorful-winsep.nvim",
		event = "VeryLazy",
		config = function()
			require("colorful-winsep").setup({
				-- symbols = { "█", "█", "█", "█", "█", "█" },
				symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
				highlight = {
					fg = Util.getColor("Title", "fg"),
					bg = Util.darken(Util.getColor("Normal", "bg"), 0.94),
				},
				no_exec_files = { "lazy", "TelescopePrompt", "mason", "neo-tree", "" },
				create_event = function()
					if vim.api.nvim_win_get_config(vim.api.nvim_get_current_win()).relative == "editor" then
						require("colorful-winsep").NvimSeparatorDel()
					end
				end,
			})
		end,
	},

	{ "famiu/bufdelete.nvim", event = "VeryLazy" },

	{ "distek/nvim-terminal" },

	{
		"distek/fnote.nvim",
		config = function()
			require("fnote").setup({
				anchor = "NE",
				window = {
					offset = {
						x = 4,
						y = 2,
					},
				},

				border = Border,
			})
		end,
	},

	-- Themes{{{
	{ "tiagovla/tokyodark.nvim", event = "VeryLazy" },

	{ "Shatur/neovim-ayu", event = "VeryLazy" },

	{ "rktjmp/lush.nvim" },
	-- }}}
})
