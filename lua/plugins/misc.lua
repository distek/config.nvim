return {
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			})
		end,
	},

	{
		"jakewvincent/mkdnflow.nvim",
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
	},

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
		"distek/colorful-winsep.nvim",
		-- dir = "~/git-clones/colorful-winsep.nvim",
		branch = "fix-highlight",
		event = "VeryLazy",
		config = function()
			require("colorful-winsep").setup({
				-- symbols = { "█", "█", "█", "█", "█", "█" },
				symbols = { "━", "┃", "┏", "┓", "┗", "┛" },

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

	{
		"distek/fnote.nvim",
		-- 	dir = "~/Programming/neovim-plugs/fnote",
		config = function()
			require("fnote").setup({
				anchor = "NE",
				window = {
					offset = {
						x = 4,
						y = 2,
					},
				},

				border = "shadow",
			})
		end,
	},

	{ "tiagovla/tokyodark.nvim", event = "VeryLazy" },

	{ "Shatur/neovim-ayu", event = "VeryLazy" },

	{ "rktjmp/lush.nvim" },
}
