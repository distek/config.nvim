return {
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

	{ "nvim-treesitter/playground", event = "VeryLazy" },
	{ "nvim-treesitter/nvim-treesitter-textobjects", event = "VeryLazy" },
	{ "mrjones2014/nvim-ts-rainbow", event = "VeryLazy" },
	{ "windwp/nvim-ts-autotag", event = "VeryLazy" },

	{ "JoosepAlviste/nvim-ts-context-commentstring" },
}
