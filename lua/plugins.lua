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
    { "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle",
        lazy = true,
    },
    { "nvim-treesitter/nvim-treesitter-context" },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    { "mrjones2014/nvim-ts-rainbow" },
    { "windwp/nvim-ts-autotag" },

    -- Layout/UI
    { "nvim-lualine/lualine.nvim", dependencies = {
        "kyazdani42/nvim-web-devicons",
    } },
    { "kevinhwang91/nvim-hlslens",
        event = "VeryLazy",
        config = function()
            require("hlslens").setup()
        end
    },
    { "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup({
                triggers_blacklist = {
                    c = { "h" },
                },
                show_help = false,
            })
        end
    },
    { "kwkarlwang/bufresize.nvim",
        lazy = true,
    },
    { "lukas-reineke/indent-blankline.nvim" },
    { "lewis6991/gitsigns.nvim",
        lazy = true,
    },
    { "nvim-tree/nvim-tree.lua",
        cmd = "NvimTree",
        lazy = true,
    },
    { "tiagovla/scope.nvim",
        lazy = true,
    },
    { "sindrets/winshift.nvim",
        cmd = "WinShift",
        lazy = true,
    },
    { "folke/zen-mode.nvim",
        lazy = true,
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
        end
    },
    { "folke/twilight.nvim",
        cmd = "Twilight",
        lazy = true,
    },
    { "distek/session-tabs.nvim" },
    -- { dir = "~/Programming/neovim-plugs/session-tabs.nvim" },
    { "kyazdani42/nvim-web-devicons" },
    {
        "distek/bufferline.nvim",
        branch = "tabpage-rename",
        dependencies = { "kyazdani42/nvim-web-devicons" },
    },

    -- Filetypes
    { "chrisbra/csv.vim",
        ft = { "csv" },
        lazy = true,
    },
    { "rust-lang/rust.vim",
        ft = { "rust" },
        lazy = true,
    },
    { "sirtaj/vim-openscad",
        ft = { "openscad" },
        lazy = true,
    },
    { "plasticboy/vim-markdown",
        ft = { "markdown" },
        lazy = true,
    },
    { "ray-x/go.nvim",
        ft = { "go" },
        lazy = true,
    },

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
    { "dnlhc/glance.nvim",
        cmd = "Glance",
        lazy = true,
    },
    { "simrat39/symbols-outline.nvim" },
    { "ray-x/lsp_signature.nvim" },

    -- dap
    { "mfussenegger/nvim-dap",
        lazy = true,
    },
    { "rcarriga/nvim-dap-ui",
        lazy = true,
    },
    { "theHamsta/nvim-dap-virtual-text",
        lazy = true,
    },
    { "mfussenegger/nvim-dap-python",
        ft = { "python" },
        lazy = true,
    },

    -- telescope
    { "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "Telescope",
        lazy = true,
    },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-telescope/telescope-dap.nvim" },
    { "LinArcX/telescope-command-palette.nvim" },
    { "tknightz/telescope-termfinder.nvim" },

    -- misc
    { "jakewvincent/mkdnflow.nvim",
        ft = { "markdown" },
        lazy = true,
    },
    { "tpope/vim-commentary",
        cmd = "Commentary",
        lazy = true,
    },
    { "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
    },
    { "ThePrimeagen/refactoring.nvim",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
        } },
    { "windwp/nvim-autopairs" },
    { "tpope/vim-fugitive",
        lazy = true,
        cmd = "Git"
    },
    { "ThePrimeagen/git-worktree.nvim",
        lazy = true,
    },
    { "powerman/vim-plugin-AnsiEsc",
        lazy = true,
    },
    { "norcalli/nvim-colorizer.lua",
        cmd = "ColorizerToggle",
        lazy = true,
    },
    { "distek/aftermath.nvim" },
    { "nvim-zh/colorful-winsep.nvim" },
    { "famiu/bufdelete.nvim" },
    { "distek/nvim-terminal", },
    -- { dir = "~/Programming/neovim-plugs/nvim-terminal" },
    -- { dir = "~/Programming/neovim-plugs/dap-buttons" },

    -- Themes
    { "tiagovla/tokyodark.nvim",
        lazy = true
    },
    { "Shatur/neovim-ayu",
        lazy = true
    },
})
-- }}}
