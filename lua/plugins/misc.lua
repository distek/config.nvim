return {
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.sessions").setup({
				-- Whether to read latest session if Neovim opened without file arguments
				autoread = false,

				-- Whether to write current session before quitting Neovim
				autowrite = true,

				-- Directory where global sessions are stored (use `''` to disable)
				directory = "~/.local/share/nvim/sessions", --<"session" subdir of user data directory from |stdpath()|>,

				-- File for local session (use `''` to disable)
				file = "",

				-- Whether to force possibly harmful actions (meaning depends on function)
				force = { read = false, write = true, delete = false },

				-- Hook functions for actions. Default `nil` means 'do nothing'.
				hooks = {
					-- Before successful action
					pre = { read = nil, write = nil, delete = nil },
					-- After successful action
					post = { read = nil, write = nil, delete = nil },
				},

				-- Whether to print session path after action
				verbose = { read = false, write = true, delete = true },
			})

			if os.getenv("VIDETREE") == nil then
				require("mini.starter").setup()
			end

			-- require("mini.animate").setup()
		end,
	},
	{
		"jakewvincent/mkdnflow.nvim",
		ft = { "markdown" },
		lazy = true,
		config = function()
			require("mkdnflow").setup({
				modules = {
					conceal = true,
				},
				links = {
					conceal = true,
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

	{ "tpope/vim-fugitive" },
	{ "ThePrimeagen/git-worktree.nvim", event = "VeryLazy" },

	{ "powerman/vim-plugin-AnsiEsc" },

	{
		"norcalli/nvim-colorizer.lua",
		cmd = "ColorizerToggle",
		event = "VeryLazy",
	},

	-- {
	-- 	"nvim-zh/colorful-winsep.nvim",
	-- 	-- dir = "~/git-clones/colorful-winsep.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("colorful-winsep").setup({
	-- 			-- symbols = { "█", "█", "█", "█", "█", "█" },
	-- 			symbols = { "━", "┃", "┏", "┓", "┗", "┛" },

	-- 			no_exec_files = { "lazy", "TelescopePrompt", "mason", "" },
	-- 			create_event = function()
	-- 				if vim.api.nvim_win_get_config(vim.api.nvim_get_current_win()).relative == "editor" then
	-- 					require("colorful-winsep").NvimSeparatorDel()
	-- 				end
	-- 			end,
	-- 		})
	-- 	end,
	-- },

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

	{ "rktjmp/lush.nvim" },

	{ "ray-x/guihua.lua" },
	{
		"nvim-neotest/neotest",
		dependencies = {
			"akinsho/neotest-go",
		},
		config = function()
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message = diagnostic.message
							:gsub("\n", " ")
							:gsub("\t", " ")
							:gsub("%s+", " ")
							:gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)

			require("neotest").setup({
				adapters = {
					require("neotest-go"),
				},
				highlights = {
					adapter_name = "Cyan",
					dir = "NeoTreeDirectoryName",
					expand_marker = "NeoTreeExpander",
					failed = "Red",
					focused = "LightMagenta",
					indent = "LightBlack",
					marked = "NeotestMarked",
					namespace = "NeotestNamespace",
					passed = "Green",
					running = "Yellow",
					select_win = "NeotestWinSelect",
					skipped = "NeotestSkipped",
					target = "NeotestTarget",
					test = "NeotestTest",
					unknown = "NeotestUnknown",
					watching = "LightBlue",
				},
			})
		end,
	},
	{ "kiyoon/nvim-tree-remote.nvim" },
}
