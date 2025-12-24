return {
	"nvim-treesitter/nvim-treesitter",
	branch = 'main',
	opts = {
			sync_install = true,
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
				additional_vim_regex_highlighting = { "sql" },
				-- custom_captures = {
				--     ["variable"] = "Constant",
			},
			indent = {
				enable = true,
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
						["]]"] = {
							query = "@class.outer",
							desc = "Next class start",
						},
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
			disable = function(lang, bufnr)
				local max_filesize_kb = 500 -- Set your desired maximum file size in KB
				local max_filesize_bytes = max_filesize_kb * 1024

				local filename = vim.api.nvim_buf_get_name(bufnr)
				if filename == "" then
					return false
				end -- Don't disable for unnamed buffers

				local ok, stats = pcall(vim.loop.fs_stat, filename)
				if ok and stats and stats.size > max_filesize_bytes then
					return true -- Disable if file size exceeds the limit
				end
				return false -- Otherwise, keep Tree-sitter enabled
			end,
	}
}
