-- Bootstrap pre {{{
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

-- Plugin list{{{
require("lazy").setup({
	-- Treesitter
	{ "nvim-treesitter/nvim-treesitter" },
	{ "nvim-treesitter/playground" },
	{ "nvim-treesitter/nvim-treesitter-context" },
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{ "p00f/nvim-ts-rainbow" },
	{ "windwp/nvim-ts-autotag" },

	-- Layout/UI
	{ "nvim-lualine/lualine.nvim", dependencies = {
		"kyazdani42/nvim-web-devicons",
	} },
	{ "kevinhwang91/nvim-hlslens" },
	{ "folke/which-key.nvim" },
	{ "kwkarlwang/bufresize.nvim" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "lewis6991/gitsigns.nvim" },
	{ "ldelossa/nvim-ide" },
	{ "tiagovla/scope.nvim" },
	{ "sindrets/winshift.nvim" },
	{ "folke/zen-mode.nvim" },
	{ "folke/twilight.nvim" },
	{ "distek/session-tabs.nvim" },
	{ "kyazdani42/nvim-web-devicons" },
	{
		"utilyre/barbecue.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"smiteshp/nvim-navic",
			"kyazdani42/nvim-web-devicons",
		},
	},
	{ "smiteshp/nvim-navic", dependencies = "neovim/nvim-lspconfig" },
	{
		"distek/bufferline.nvim",
		branch = "tabpage-rename",
		dependencies = { "kyazdani42/nvim-web-devicons" },
	},

	-- Filetypes
	{ "chrisbra/csv.vim" },
	{ "rust-lang/rust.vim" },
	{ "sirtaj/vim-openscad" },
	{ "plasticboy/vim-markdown" },
	{ "ray-x/go.nvim" },

	-- lsp
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"jayp0521/mason-null-ls.nvim",
		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
		},
	},
	{
		"hrsh7th/nvim-cmp",
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
	},
	{ "onsails/lspkind-nvim" },
	{ "dnlhc/glance.nvim" },

	-- dap
	{ "mfussenegger/nvim-dap" },
	{ "rcarriga/nvim-dap-ui" },
	{ "theHamsta/nvim-dap-virtual-text" },
	{ "mfussenegger/nvim-dap-python" },

	-- telescope
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	{ "nvim-telescope/telescope-file-browser.nvim" },
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{ "nvim-telescope/telescope-dap.nvim" },
	{ "LinArcX/telescope-command-palette.nvim" },

	-- misc
	{ "jakewvincent/mkdnflow.nvim" },
	{ "tpope/vim-commentary" },
	{ "ThePrimeagen/refactoring.nvim", dependencies = {
		"nvim-lua/plenary.nvim",
	} },
	{ "windwp/nvim-autopairs" },
	{ "tpope/vim-fugitive" },
	{ "ThePrimeagen/git-worktree.nvim" },
	{ "powerman/vim-plugin-AnsiEsc" },
	{ "norcalli/nvim-colorizer.lua" },
	{ "distek/aftermath.nvim" },
	{ "nvim-zh/colorful-winsep.nvim" },
	{ "famiu/bufdelete.nvim" },
	{ "luukvbaal/statuscol.nvim" },

	-- Themes
	{ "tiagovla/tokyodark.nvim" },
	{ "Shatur/neovim-ayu" },
})
-- }}}
